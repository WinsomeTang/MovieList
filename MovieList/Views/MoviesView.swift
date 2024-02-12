//
//  MoviesView.swift
//  MovieList
//
//  Created by Winsome Tang on 2024-02-11.
//

import SwiftUI

struct MoviesView: View {
    @ObservedObject var viewModel = MovieViewModel()

    var body: some View {
        NavigationStack {
            List(viewModel.movies) { movie in
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.headline)
                    Text(movie.director)
                        .font(.subheadline)
                    HStack {
                        Text("Year: \(movie.year)")
                        Spacer()
                        Text("Rating: \(movie.rating, specifier: "%.1f")")
                    }
                    .font(.caption)
                }
            }
            .navigationTitle("Movies")
            .onAppear {
                viewModel.fetchMovies()
            }
        }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}
