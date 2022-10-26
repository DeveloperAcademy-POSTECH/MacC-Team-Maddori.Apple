//
//  NetworkError.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/26.
//

import Foundation

enum NetworkError: Error {
    case encodingError
    case clientError(message: String?)
    case serverError
}
