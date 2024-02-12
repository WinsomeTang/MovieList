//
//  Movie.swift
//  MovieList
//
//  Created by Winsome Tang on 2024-02-11.
//

import Foundation

struct Movie: Identifiable, Decodable {
    var id: Int
    var title: String
    var director: String
    var year: Int
    var rating: Double
}
