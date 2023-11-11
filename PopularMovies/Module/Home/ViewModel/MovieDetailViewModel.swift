//
//  MovieDetailViewModel.swift
//  PopularMovies
//
//  Created by Mubasher Khan on 11/11/23.
//

import Foundation
import Combine
class MovieDetailViewModel : ObservableObject{
    private var cancellables = Set<AnyCancellable>()
    let selectedMovie:Movie
    @Published var movieDetail:MovieDetail?
    @Published var loadingDetail:Bool = false
    init(selectedMovie: Movie) {
        self.selectedMovie = selectedMovie
    }
    func getMovieDetails(){
        loadingDetail = true
        guard let movieId = selectedMovie.id else {return}
        print("\(Constants.MOVIES_DETAILS_URL)\(movieId)")
        let publisher: AnyPublisher<MovieDetail, Error> = NetworkManager.shared.getMethod(url: "\(Constants.MOVIES_DETAILS_URL)\(movieId)", params: [:])
        publisher.sink { completion in
            self.loadingDetail = false
            switch completion{
            case .finished:
                Logger.log(.info, "Movies Data Loaded")
            case .failure(let error):
                Logger.log(.error, error.localizedDescription)
            }
            
        } receiveValue: { [weak self] data in
            
            guard let self = self else {return}
            self.movieDetail = data
            Logger.log(.info, "\(data)")
        }
        .store(in: &cancellables)
    }
}
