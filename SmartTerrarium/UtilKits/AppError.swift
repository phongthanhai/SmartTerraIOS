//
//  AppError.swift
//  SmartTerrarium
//
//  Created by Than Hai Phong on 28/12/2024.
//

import Foundation

enum ExError: String, Error {
    case httpResponse = "False"
    case invalidURL = "HEYYY!!! Give me a valid URL"
    case invalidUsernameOrPassword = "invalid Username and Password. please try again.."
    case invalidCredentials = "please check that you have used the correct email and password"
    case unableToComplete = "Unable to complete you request. Please check your Internet connection.."
    case invalidResponse = "Invalid response from the server. please try again."
    case inValidData = "the data recevied from the server was Invalid. please try again."
    case decodingError = "Response could not be decoded"
    case NotFound = "Not Found"
    case somethingWrong = "HEYYY!!!! Something Wrong."
    case missingToken
    case invalidToken
}
