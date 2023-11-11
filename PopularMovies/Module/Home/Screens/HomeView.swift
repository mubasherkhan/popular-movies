//
//  HomeView.swift
//  PopularMovies
//
//  Created by Mubasher Khan on 11/10/23.
//

import SwiftUI

struct HomeView: View {
    @State var numberOfItems = 10
    @StateObject var viewModel = HomeViewModel()
    @State var showMovieDetail = false
    @Namespace var nameSpace

    var body: some View {
        ZStack{
            Color("background")
                .ignoresSafeArea()
                ScrollView{
                    LazyVStack(content: {
                        ForEach(viewModel.movies.indices, id: \.self) { ind in
                            MovieItemView(movie: viewModel.movies[ind], nameSpace: nameSpace)
                                .onTapGesture {
                                    viewModel.selectedMovieIndex = ind
                                    withAnimation(.easeIn) {
                                        showMovieDetail.toggle()
                                    }
//                                    showMovieDetail.toggle()
                                }
                        }
                        MovieItemView(movie: Movie(id: 0), nameSpace: nameSpace)
                            .onAppear(perform: {
                                viewModel.getPopularMovies()
                            })
                            .redacted(reason: .placeholder)
                    })
                }
            if showMovieDetail {
                MovieDetailView(showMovieDetail: $showMovieDetail, viewModel: MovieDetailViewModel(selectedMovie: viewModel.movies[viewModel.selectedMovieIndex]), nameSpace: nameSpace)
            }
            
            
        }.onAppear{
            viewModel.getPopularMovies()
        }
        
    }
}

#Preview {
    HomeView()
}
