//
//  APIManager.swift
//  ImageViewer
//
//  Created by César Cubillos on 12/10/23.
//

import Foundation

/// Class to manage the API calls
class APIManager {
    
    static let shared = APIManager()
    
    
    /// To call an API
    /// - Parameters:
    ///   - t: Type to decode JSON response
    ///   - httpMethod: Type of HTTP request
    ///   - endpoint: URL
    /// - Returns: A tuple with a generic type data and network response
    func fetch<T: Codable>(_ t: T.Type, with httpMethod: MethodHTTP, from endpoint: String) async throws -> (T?, NetworkError) {
        guard let url = URL(string: endpoint) else {
            return (nil, .urlError)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        let (data, response) = try await URLSession.shared.data(for: request)
        let responseValidated = validate(response)
        
        if responseValidated != .success || httpMethod == .delete {
            return (nil, responseValidated)
        }
        
        let dataProcessed = try processData(T.self, of: data)
        return (dataProcessed, responseValidated)
        
    }
    
    /// To download data from API
    /// - Parameters:
    ///   - endpoint: URL
    /// - Returns: A Data object
    func downLoadData(from endpoint: String) async throws -> Data {
        guard let url = URL(string: endpoint) else {
            return Data()
        }
        
        let request = URLRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return data
        
    }
    
    /// Transform data into a model gave
    /// - Parameters:
    ///   - t: Type to decode JSON response
    ///   - data: Data response from API
    /// - Returns: Data formatted to generic type
    private func processData<T: Codable>(_ t: T.Type, of data: Data) throws -> (T?) {
        let fetchData = try JSONDecoder().decode(T.self, from: data)
        return fetchData
    }
    
    /// Validate status of HTTP request
    /// - Parameter response: HTTP response
    /// - Returns: An error type to handle
    private func validate(_ response: URLResponse) -> NetworkError {
        guard let httpResponse = response as? HTTPURLResponse else {
            return .unkown
        }
        
        switch httpResponse.statusCode {
        case 200..<300:
            return .success
        case 404:
            return .notFound
        case 500:
            return .serverError
        default:
            return .unkown
        }
    }
}
