//
//  Constants.swift
//  PopularMovies
//
//  Created by Mubasher Khan on 11/11/23.
//

import Foundation

struct Constants{
    static let TMDB_SECRET = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiYTQ5OTc5NTlkZGJlNDhmMmQ4NDdkZDUyMjczZTI1MiIsInN1YiI6IjY1NGQyZWQ5ZDQ2NTM3MDEzODYwMjU0NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.AIt4RAfv5UJh-zj_Nz47g-sLcx-xg-0ayoqpx7KwM_Y"
    static let IMAGE_BASE_URL = "https://image.tmdb.org/t/p/w300/"
    static let BASE_URL = "https://api.themoviedb.org/3/"
    static let POPULAR_MOVIES_URL =  BASE_URL + "movie/popular"
    static let MOVIES_DETAILS_URL =  BASE_URL + "movie/"
}
