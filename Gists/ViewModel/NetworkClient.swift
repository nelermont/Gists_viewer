//
//  NetworkClient.swift
//  Gists
//
//  Created by Дмитрий Подольский on 26.04.2023.
//
import Foundation

class NetworkClient {
    
    static let shared = NetworkClient()
    
    private init() {}
    
    func makeRequest<T: Decodable>(url: URL, method: HTTPMethod? = nil, headers: [String: String]? = nil, query: [String: String]? = nil, body: Data? = nil) async throws -> T {
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        if let query = query {
            urlComponents.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        var request = URLRequest(url: urlComponents.url!)
        
        if let method = method {
            request.httpMethod = method.rawValue
        }
        
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        request.httpBody = body
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(T.self, from: data)
            return result
        } catch {
            throw NetworkError.decodingFailed(error)
        }
        
    }
}

