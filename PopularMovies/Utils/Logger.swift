//
//  Logger.swift
//  PopularMovies
//
//  Created by Mubasher Khan on 11/11/23.
//

import Foundation

enum LogLevel {
    case debug
    case info
    case warning
    case error
}

struct Logger {
    static func log(_ level: LogLevel, _ message: String) {
        #if DEBUG
        let formattedMessage = "[\(level)] \(message)"
        print(formattedMessage)
        #endif
    }
}

