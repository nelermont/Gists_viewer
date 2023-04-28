//
//  Networking.swift
//  Gists
//
//  Created by Дмитрий Подольский on 28.04.2023.
//

import Foundation

protocol Networking {
    func makeRequest<T: Decodable>(url: URL, method: HTTPMethod?, headers: [String: String]?, query: [String: String]?, body: Data?, responseType: T.Type?) async throws -> T?
}
