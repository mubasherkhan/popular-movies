//
//  MovieDetailView.swift
//  PopularMovies
//
//  Created by Mubasher Khan on 11/11/23.
//

import SwiftUI


struct MovieDetailView: View {
    @Binding var showMovieDetail:Bool
    @StateObject var viewModel:MovieDetailViewModel
    var nameSpace:Namespace.ID
    var body: some View {
        ZStack {
            Color("background")
            
            
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 350)
                Text(viewModel.selectedMovie.title ?? "N/A")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.leading,8)
                    .matchedGeometryEffect(id: "\(viewModel.selectedMovie.id ?? 0)_title", in: nameSpace)
                HStack(alignment:.center,spacing:4){
                    Image(systemName: "star.fill")
                        .foregroundColor(Color("forsythia"))
                        .matchedGeometryEffect(id: "\(viewModel.selectedMovie.id ?? 0)_star", in: nameSpace)
                    Text("\(String(format: "%.2f", viewModel.selectedMovie.voteAverage ?? 0)) / 10")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                        .fontWeight(.regular)
                        .matchedGeometryEffect(id: "\(viewModel.selectedMovie.id ?? 0)_voteAverage", in: nameSpace)
                    Text("(\(viewModel.selectedMovie.voteCount ?? 0))")
                        .font(.system(size: 15))
                        .foregroundColor(Color("argent"))
                        .fontWeight(.regular)
                        .matchedGeometryEffect(id: "\(viewModel.selectedMovie.id ?? 0)_voteCount", in: nameSpace)
                    Spacer()
                }.padding(.top,8)
                    .padding(.leading,5)
                Text(viewModel.selectedMovie.genres ?? "N/A")
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.top,8)
                    .padding(.leading,8)
                    .matchedGeometryEffect(id: "\(viewModel.selectedMovie.id ?? 0)_genres", in: nameSpace)
                Text(viewModel.selectedMovie.overview ?? "N/A")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 16))
                    .foregroundColor(Color("argent"))
                    .fontWeight(.regular)
                    .padding(.top,8)
                    .padding(.leading,8)
                    .matchedGeometryEffect(id: "\(viewModel.selectedMovie.id ?? 0)_overview", in: nameSpace)
                if viewModel.loadingDetail{
                    HStack{
                        Spacer()
                        ProgressView()
                        Spacer()
                    }.padding()
                }
                if viewModel.movieDetail != nil {
                    VStack(alignment: .leading){
                        Text("Production")
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.top,8)
                            .padding(.leading,8)
                        Text(viewModel.movieDetail?.productionCountries?.first?.name ?? "N/A")
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 16))
                            .foregroundColor(Color("argent"))
                            .fontWeight(.regular)
                            .padding(.top,8)
                            .padding(.leading,8)
                    }
                }
                Spacer()
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .background(
                VStack{
                    if viewModel.selectedMovie.posterPath != nil{
                        CachedAsyncImage(urlRequest: URLRequest(url: URL(string: "\(Constants.IMAGE_BASE_URL)\(viewModel.selectedMovie.posterPath ?? "")")!,cachePolicy: .returnCacheDataElseLoad), urlCache: .imageCache){ image in
                            image.resizable()
                        } placeholder: {
                            Image(systemName: "photo.fill")
                                .foregroundColor(.white)
                                .frame(
                                    minWidth: 0,
                                    maxWidth: .infinity,
                                    minHeight: 400,
                                    maxHeight: 400,
                                    alignment: .topLeading
                                )
                                .background(Color("argent"))
                                .cornerRadius(15)
                        }
                        .background(Color("argent"))
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            minHeight: 400,
                            maxHeight: 400,
                            alignment: .topLeading
                        )
                        .matchedGeometryEffect(id: "\(viewModel.selectedMovie.id ?? 0)_image", in: nameSpace)
                        
                    } else {
                        Image(systemName: "photo.fill")
                            .foregroundColor(.white)
                            .frame(
                                minWidth: 0,
                                maxWidth: .infinity,
                                minHeight: 400,
                                maxHeight: 400,
                                alignment: .topLeading
                            )
                            .background(Color("argent"))
                            
                    }
                    Spacer()
                }
            )
            
            Button {
                withAnimation(.easeIn) {
                    showMovieDetail.toggle()
                }
            } label: {
                
                Image(systemName: "chevron.left")
                    .font(.title)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 10)
            }.frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .padding(EdgeInsets(top: 50, leading: 40, bottom: 0, trailing: 0))
        }.ignoresSafeArea()
            .onAppear{
                viewModel.getMovieDetails()
            }
    }
}

//#Preview {
//    MovieDetailView(showMovieDetail: .constant(false), viewModel: MovieDetailViewModel(selectedMovie: Movie()))
//}
