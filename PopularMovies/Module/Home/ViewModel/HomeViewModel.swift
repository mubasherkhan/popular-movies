//
//  HomeViewModel.swift
//  PopularMovies
//
//  Created by Mubasher Khan on 11/11/23.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject{
    @Published var movies:[Movie] = []
    private var cancellables = Set<AnyCancellable>()
    private var currentPage = 0
    private var totalPages = 1
    var selectedMovieIndex = 0
    
    func getPopularMovies(){
        currentPage += 1
        let publisher: AnyPublisher<PopularMovies, Error> = NetworkManager.shared.getMethod(url: Constants.POPULAR_MOVIES_URL, params: ["page":currentPage])
        publisher.sink { completion in
            switch completion{
            case .finished:
                Logger.log(.info, "Movies Data Loaded")
            case .failure(let error):
                Logger.log(.error, error.localizedDescription)
            }
            
        } receiveValue: { [weak self] data in
            
            guard let self = self else {return}
            if self.currentPage == 1 {
                self.movies = data.results ?? []
            } else{
                self.movies += data.results ?? []
            }
            Logger.log(.info, "\(data)")
        }
        .store(in: &cancellables)
    }
}
