//
//  NetworkClient.swift
//  Gists
//
//  Created by Дмитрий Подольский on 26.04.2023.
//
import Foundation


class NetworkClient: Networking {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func makeRequest<T: Decodable>(url: URL, method: HTTPMethod? = nil, headers: [String: String]? = nil, query: [String: String]? = nil, body: Data? = nil, responseType: T.Type? = nil) async throws -> T? {
        
        let request = try createRequest(url: url, method: method, headers: headers, query: query, body: body)
        return try await sendRequest(request: request, responseType: responseType)
    }
    
    private func createRequest(url: URL, method: HTTPMethod?, headers: [String: String]?, query: [String: String]?, body: Data?) throws -> URLRequest {
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw NetworkError.invalidURL
        }
        
        if let query = query {
            urlComponents.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        
        if let method = method {
            request.httpMethod = method.rawValue
        }
        
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        request.httpBody = body
        
        return request
    }
    
    private func sendRequest<T: Decodable>(request: URLRequest, responseType: T.Type?) async throws -> T? {
        
        let (data, response) = try await urlSession.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.invalidResponse
        }
        
        if let responseType = responseType {
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(responseType, from: data)
                return result
            } catch {
                throw NetworkError.decodingFailed(error)
            }
        } else {
            return nil
        }
    }
}
