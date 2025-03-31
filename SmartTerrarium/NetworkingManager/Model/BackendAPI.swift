//
//  BackendAPI.swift
//  SmartTerrarium
//
//  Created by Than Hai Phong on 09/12/2024.
//

import Foundation

struct BackendAPI {
    static func urlForSensorData(_ userId: String?)-> URL?{
        var urlComponents   = BackendAPI.faceMobileUrlComponents
        urlComponents.path  = Endpoints.sensorData.rawValue
        let sensorItem      = URLQueryItem(name: "Id", value: "\(userId ?? "1")")
        
        urlComponents.queryItems = [sensorItem]
        return urlComponents.url
    }
    
    static func urlForCommands() -> URL?{
        var urlComponents   = BackendAPI.faceMobileUrlComponents
        urlComponents.path  = Endpoints.commands.rawValue
        return urlComponents.url
    }
}

extension BackendAPI{
    
    enum Endpoints: String{
        case sensorData =       "/api/SensorDatas"
        case commands   =       "/api/Commands"
        case user       =       "/api/Users"
    }
    
    static var faceMobileUrlComponents: URLComponents {
        var urlComponents       = URLComponents()
        urlComponents.scheme    = "http"
        urlComponents.host      = "localhost"
        urlComponents.port      = 3000
        
        return urlComponents
    }
    
    
}

