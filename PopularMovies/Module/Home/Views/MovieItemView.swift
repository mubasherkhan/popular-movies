//
//  MovieItemView.swift
//  PopularMovies
//
//  Created by Mubasher Khan on 11/10/23.
//

import SwiftUI

struct MovieItemView: View {
    var shoImage = true
    let movie:Movie
    var body: some View {
        HStack(alignment: .top){
            if shoImage{
                CachedAsyncImage(urlRequest: URLRequest(url: URL(string: "https://image.tmdb.org/t/p/w300/\(movie.posterPath ?? "")")!,cachePolicy: .returnCacheDataElseLoad), urlCache: .imageCache){ image in
                             image.resizable()
                         } placeholder: {
                             Image(systemName: "photo.fill")
                                 .foregroundColor(.white)
                                 .frame(maxWidth: 182,maxHeight: .infinity,alignment: .center)
                                 .background(Color("argent"))
                                 .cornerRadius(15)
                             
//                             ProgressView()
                         }
                    .background(Color("argent"))
                    .frame(maxWidth: 182,maxHeight: .infinity,alignment: .center)
                    .cornerRadius(15)
                    .padding(4)
            } else {
                Image(systemName: "photo.fill")
                    .foregroundColor(.white)
                    .frame(maxWidth: 182,maxHeight: .infinity,alignment: .center)
                    .background(Color("argent"))
                    .cornerRadius(15)
                    .padding(4)
            }
           
//            Image("moviebg")
//                .resizable()
//                .background(Color("argent"))
//                .cornerRadius(15)
//                .frame(width: 181)
            
            VStack(alignment: .leading,spacing: 6.0){
                        Text(movie.title ?? "N/A")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                HStack(alignment:.center,spacing:4){
                    Image(systemName: "star.fill")
                        .foregroundColor(Color("forsythia"))
                    Text("\(String(format: "%.2f", movie.voteAverage ?? 0)) / 10")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                        .fontWeight(.regular)
                    Text("(\(movie.voteCount ?? 0))")
                        .font(.system(size: 15))
                        .foregroundColor(Color("argent"))
                        .fontWeight(.regular)
                    Spacer()
                }
                    Text(movie.genres ?? "N/A")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                Text(movie.overview ?? "N/A")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 13))
                    .foregroundColor(Color("argent"))
                    .fontWeight(.regular)
                Spacer()
                
            }
            
        }
        .onAppear{
//            URLCache.shared.memoryCapacity = 10_000_000
//            URLCache.shared.diskCapacity = 1_000_000_000
        }
        .background(Color("background"))
        .frame(height: 273)
        .padding()
    }
}

//#Preview {
////    MovieItemView(movie: Movie(from: <#Decoder#>))
//}

extension URLCache {
    
    static let imageCache = URLCache(memoryCapacity: 512_000_000, diskCapacity: 10_000_000_000)
}
