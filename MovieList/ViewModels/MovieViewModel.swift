//
//  MovieViewModel.swift
//  MovieList
//
//  Created by Winsome Tang on 2024-02-11.
//

import Foundation

class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []

    // URL for the movies API
    private let moviesURL = "https://movie-db-api.azurewebsites.net/movies"

    // Fetch movies from the API
    func fetchMovies() {
        guard let url = URL(string: moviesURL) else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let decodedResponse = try? JSONDecoder().decode([Movie].self, from: data) {
                DispatchQueue.main.async {
                    self.movies = decodedResponse
                }
            } else {
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }

    // Post a new movie to the API
    func postMovie(movie: Movie) {
        guard let url = URL(string: moviesURL) else { return }
        
        // Convert movie to JSON data
        guard let jsonData = try? JSONEncoder().encode(movie) else { return }

        // Create the POST request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        // Perform the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                self.fetchMovies() // Refresh the movie list after posting
            } else {
                print("POST request failed: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }
}
