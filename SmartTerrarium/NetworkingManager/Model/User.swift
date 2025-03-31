//
//  User.swift
//  SmartTerrarium
//
//  Created by Than Hai Phong on 28/12/2024.
//

import Foundation

struct SensorDataResponse: Decodable {
    let _id: String
    var temperature: Double?
    var humidity: Double?
    var moisture: Double?
    let timestamp: Date
    let __v: Int
    
    enum CodingKeys: String, CodingKey {
        case _id
        case temperature
        case humidity
        case moisture
        case timestamp
        case __v
    }
}

struct FanResponse: Decodable {
    let Id: Int
    let fan: Bool
    let duration: Double
    let _id: String
    let timestamp: String
    let __v: Int
}

struct FanRequest: Encodable {
    let Id: Int
    let fan: Bool
    let duration: Double
}

struct WaterRequest: Encodable{
    let Id: Int
    let pump: Bool
    let duration: Double
}

struct WaterResponse: Decodable{
    let Id: Int
    let pump: Bool
    let duration: Double
    let _id: String
    let timestamp: String
    let __v: Int
}
