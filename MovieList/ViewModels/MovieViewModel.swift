//
//  MovieViewModel.swift
//  MovieList
//
//  Created by Winsome Tang on 2024-02-11.
//

import Foundation

class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []

    func fetchMovies() {
        guard let url = URL(string: "https://movie-db-api.azurewebsites.net/movies") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([Movie].self, from: data) {
                    DispatchQueue.main.async {
                        self.movies = decodedResponse
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}
