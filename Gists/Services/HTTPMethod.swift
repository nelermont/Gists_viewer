//
//  HTTPMethod.swift
//  Gists
//
//  Created by Дмитрий Подольский on 27.04.2023.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
    case options = "OPTIONS"
    case head = "HEAD"
    case connect = "CONNECT"
    case trace = "TRACE"
}
