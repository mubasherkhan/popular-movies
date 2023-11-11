//
//  PopularMoviesTests.swift
//  PopularMoviesTests
//
//  Created by Mubasher Khan on 11/10/23.
//

import XCTest
import Combine

@testable import PopularMovies

final class PopularMoviesTests: XCTestCase {
    var viewModel: HomeViewModel!
    var detailsViewModel: MovieDetailViewModel!
    var cancellables: Set<AnyCancellable>!
    override func setUpWithError() throws {
        viewModel = HomeViewModel()
        detailsViewModel = MovieDetailViewModel(selectedMovie: Movie(id: 615656))
        cancellables = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        cancellables = nil
    }
    func testGetPopularMovies() {
           let expectation = XCTestExpectation(description: "Fetching popular movies")

           viewModel.getPopularMovies()

           viewModel.$movies
                .dropFirst()
               .sink { movies in
                   XCTAssertFalse(movies.isEmpty, "Movies should not be empty")
                   expectation.fulfill()
               }
               .store(in: &cancellables)

           wait(for: [expectation], timeout: 5.0)
       }
    func testGetMovieDetails() {
           let expectation = XCTestExpectation(description: "Movies details should not be empty")

            detailsViewModel.getMovieDetails()

        detailsViewModel.$movieDetail
                .dropFirst()
               .sink { movieDetail in
                   XCTAssertNotNil(movieDetail, "Movies should not be empty")
                   expectation.fulfill()
               }
               .store(in: &cancellables)

           wait(for: [expectation], timeout: 5.0)
       }

       func testSelectedMovieIndex() {
           XCTAssertEqual(viewModel.selectedMovieIndex, 0, "Initial selectedMovieIndex should be 0")

           viewModel.selectedMovieIndex = 42

           XCTAssertEqual(viewModel.selectedMovieIndex, 42, "Selected movie index should be updated")
       }
    

}
