//
//  PopularMovies.swift
//  PopularMovies
//
//  Created by Mubasher Khan on 11/11/23.
//

import Foundation

struct PopularMovies: Codable {
    let page: Int?
    let results: [Movie]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
struct Genre: Codable {
    let id: Int
    let name: String
}

struct Movie: Codable,Identifiable {
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalTitle, overview, genres: String?
    let posterPath, title: String?
    let voteAverage: Double?
    let voteCount: Int?
    init(id:Int){
        self.backdropPath =   nil
        self.genreIDS =       nil
        self.id =             id
        self.originalTitle =  nil
        self.overview =       nil
        self.posterPath =     nil
        self.title =          nil
        self.voteAverage =    nil
        self.voteCount =      nil
        self.genres = nil
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.backdropPath, forKey: .backdropPath)
        try container.encodeIfPresent(self.genreIDS, forKey: .genreIDS)
        try container.encodeIfPresent(self.id, forKey: .id)
        try container.encodeIfPresent(self.originalTitle, forKey: .originalTitle)
        try container.encodeIfPresent(self.overview, forKey: .overview)
        try container.encodeIfPresent(self.posterPath, forKey: .posterPath)
        try container.encodeIfPresent(self.title, forKey: .title)
        try container.encodeIfPresent(self.voteAverage, forKey: .voteAverage)
        try container.encodeIfPresent(self.voteCount, forKey: .voteCount)
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        self.genreIDS = try container.decodeIfPresent([Int].self, forKey: .genreIDS)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle)
        self.overview = try container.decodeIfPresent(String.self, forKey: .overview)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage)
        self.voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount)
        self.genres = transformGenreIdsToNames(genreIds: self.genreIDS ?? [])
        
    }
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
 
    
}

func transformGenreIdsToNames(genreIds: [Int]) -> String {
    let genres: [Genre] = [
        Genre(id: 28, name: "Action"),
        Genre(id: 12, name: "Adventure"),
        Genre(id: 16, name: "Animation"),
        Genre(id: 35, name: "Comedy"),
        Genre(id: 80, name: "Crime"),
        Genre(id: 99, name: "Documentary"),
        Genre(id: 18, name: "Drama"),
        Genre(id: 10751, name: "Family"),
        Genre(id: 14, name: "Fantasy"),
        Genre(id: 36, name: "History"),
        Genre(id: 27, name: "Horror"),
        Genre(id: 10402, name: "Music"),
        Genre(id: 9648, name: "Mystery"),
        Genre(id: 10749, name: "Romance"),
        Genre(id: 878, name: "Science Fiction"),
        Genre(id: 10770, name: "TV Movie"),
        Genre(id: 53, name: "Thriller"),
        Genre(id: 10752, name: "War"),
        Genre(id: 37, name: "Western")
    ]
    let genreNames = genreIds.compactMap { genreId in
        genres.first { $0.id == genreId }?.name
    }

    return genreNames.joined(separator: ", ")
}
