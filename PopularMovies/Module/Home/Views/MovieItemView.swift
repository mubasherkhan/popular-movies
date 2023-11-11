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
    var nameSpace:Namespace.ID
    var body: some View {
        HStack(alignment: .top){
            if movie.posterPath != nil{
                CachedAsyncImage(urlRequest: URLRequest(url: URL(string: "\(Constants.IMAGE_BASE_URL)\(movie.posterPath ?? "")")!,cachePolicy: .returnCacheDataElseLoad), urlCache: .imageCache){ image in
                             image.resizable()
                         } placeholder: {
                             Image(systemName: "photo.fill")
                                 .foregroundColor(.white)
                                 .frame(maxWidth: 182,maxHeight: .infinity,alignment: .center)
                                 .background(Color("argent"))
                                 .cornerRadius(15)
                         }
                    .background(Color("argent"))
                    .frame(maxWidth: 182,maxHeight: .infinity,alignment: .center)
                    .cornerRadius(15)
                    .padding(4)
                    .matchedGeometryEffect(id: "\(movie.id ?? 0)_image", in: nameSpace)
            } else {
                Image(systemName: "photo.fill")
                    .foregroundColor(.white)
                    .frame(maxWidth: 182,maxHeight: .infinity,alignment: .center)
                    .background(Color("argent"))
                    .cornerRadius(15)
                    .padding(4)
            }
           

            
            VStack(alignment: .leading,spacing: 6.0){
                        Text(movie.title ?? "N/A")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .matchedGeometryEffect(id: "\(movie.id ?? 0)_title", in: nameSpace)
                HStack(alignment:.center,spacing:4){
                    Image(systemName: "star.fill")
                        .foregroundColor(Color("forsythia"))
                    Text("\(String(format: "%.2f", movie.voteAverage ?? 0)) / 10")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                        .fontWeight(.regular)
                        .matchedGeometryEffect(id: "\(movie.id ?? 0)_star", in: nameSpace)
                    Text("(\(movie.voteCount ?? 0))")
                        .font(.system(size: 15))
                        .foregroundColor(Color("argent"))
                        .fontWeight(.regular)
                        .matchedGeometryEffect(id: "\(movie.id ?? 0)_voteCount", in: nameSpace)
                    Spacer()
                }
                    Text(movie.genres ?? "N/A")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .matchedGeometryEffect(id: "\(movie.id ?? 0)_genres", in: nameSpace)
                Text(movie.overview ?? "N/A")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 13))
                    .foregroundColor(Color("argent"))
                    .fontWeight(.regular)
                    .matchedGeometryEffect(id: "\(movie.id ?? 0)_overview", in: nameSpace)
                Spacer()
                
            }
            
        }
        .background(Color("background"))
        .frame(height: 273)
        .padding()
    }
}



