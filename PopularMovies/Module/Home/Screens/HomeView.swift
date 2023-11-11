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

    var body: some View {
        ZStack{
            Color("background")
                .ignoresSafeArea()
            ScrollView{
                LazyVStack(content: {
                    ForEach(viewModel.movies.indices, id: \.self) { ind in
                        MovieItemView(movie: viewModel.movies[ind])
                    }
                    MovieItemView(movie: Movie())
                        .onAppear(perform: {
                            viewModel.getPopularMovies()
                        })
                        .redacted(reason: .placeholder)
                })
            }
        }.onAppear{
            viewModel.getPopularMovies()
        }
         
    }
}

#Preview {
    HomeView()
}
