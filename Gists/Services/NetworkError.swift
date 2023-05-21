//
//  NetworkError.swift
//  Gists
//
//  Created by Дмитрий Подольский on 20.05.2023.
//

import Foundation

public enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case requestFailed(Error)
    case decodingFailed(Error)
    case encodingFailed(Error)
}

