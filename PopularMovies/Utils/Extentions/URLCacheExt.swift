//
//  URLCacheExt.swift
//  PopularMovies
//
//  Created by Mubasher Khan on 11/11/23.
//

import Foundation

extension URLCache {
    
    static let imageCache = URLCache(memoryCapacity: 512_000_000, diskCapacity: 10_000_000_000)
}
