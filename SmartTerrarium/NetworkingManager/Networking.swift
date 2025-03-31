//
//  Networking.swift
//  SmartTerrarium
//
//  Created by Than Hai Phong on 28/12/2024.
//

import Foundation
import UIKit

class Networking {
    static let shared   = Networking()
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    /**
        GET Method to retrieve sensor data
     */
    func getSensorData(_ userId: String?) async throws -> [SensorDataResponse] {
        let request = try await self.createRequestWithoutAuthorization(with: BackendAPI.urlForSensorData(userId))
        print("GET sensorData url: ", request.url?.absoluteString ?? "unknown")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Response is not HTTPURLResponse")
            throw ExError.invalidResponse
        }
        
        do {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            decoder.dateDecodingStrategy = .formatted(formatter)
            
            let decodedResponse = try decoder.decode([SensorDataResponse].self, from: data)
            print("Successfully decoded \(decodedResponse.count) items")
            return decodedResponse
        } catch let decodingError as DecodingError {
            print("Detailed decoding error: \(decodingError)")
            throw ExError.inValidData
        } catch {
            print("Other error: \(error)")
            throw ExError.inValidData
        }
    }
    
    /**
        POST Method to turn fan on/off
     */
    func postToggleFan(_ fanRequest: FanRequest) async throws -> FanResponse{
        let request = try await self.createPostRequestWithoutAuthorization(
            with: BackendAPI.urlForCommands(),
            data: fanRequest)
        print("POST fan toggle url: ", request.url?.absoluteString ?? "unknown")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 201 else{
            throw ExError.invalidResponse
        }
        
        do{
            return try decoder.decode(FanResponse.self, from: data)
        }catch{
            throw ExError.inValidData
        }
    }
    
    /**
        POST Method to turn on Pump for a specific duration
     */
    func postPump(_ waterRequest: WaterRequest) async throws -> WaterResponse{
        let request = try await self.createPostRequestWithoutAuthorization(
            with: BackendAPI.urlForCommands(),
            type:.POST,
            data: waterRequest)
        print("POST water pump url: ", request.url?.absoluteString ?? "unknown")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 201 else{
            throw ExError.invalidResponse
        }
        
        do{
            return try decoder.decode(WaterResponse.self, from: data)
        }catch{
            throw ExError.inValidData
        }
    }
    
    /**
        For GET: create a request without authorization
     */
    private func createRequestWithoutAuthorization(with url: URL?, type: HTTPMethod = .GET) async throws -> URLRequest {
        
        guard let apiURL = url else{
            throw ExError.invalidURL
        }
        
        var request = URLRequest(url: apiURL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = type.rawValue
        
        return request
    }
    
    /**
        For POST: create a request without authorization
     */
    private func createPostRequestWithoutAuthorization<T: Encodable>(
            with url: URL?,
            type: HTTPMethod = .POST,
            data: T
        ) async throws -> URLRequest {
            
        guard let apiURL = url else {
            throw ExError.invalidURL
        }

        var request = URLRequest(url: apiURL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = type.rawValue

        request.httpBody = try encoder.encode(data)

        return request
    }
}
