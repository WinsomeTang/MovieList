//
//  AddMovieView.swift
//  MovieList
//
//  Created by Winsome Tang on 2024-02-11.
//

import SwiftUI

struct AddMovieView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: MovieViewModel
    @State private var title: String = ""
    @State private var director: String = ""
    @State private var year: String = ""
    @State private var rating: String = ""


    var body: some View {
        VStack(spacing: 10){
            Text("Add a new movie")
                .font(.custom("JetBrainsMono-Bold", size: 35))
                .fontWeight(.bold)
                .padding(.bottom, 10)
            VStack(alignment: .leading) {
                LabelTextField(label: "Title", placeHolder: "Enter a movie title", textValue: $title)
                LabelTextField(label: "Director", placeHolder: "Enter a director", textValue: $director)
                LabelTextField(label: "Year", placeHolder: "Enter the movie's year of release", textValue: $year)
                LabelTextField(label: "Rating", placeHolder: "Enter the movie's rating [E.g. 9.5]", textValue: $rating)
            }
            .padding()
            Button(action: {
                // Perform input validation and create a new movie
                if let yearInt = Int(year), let ratingDouble = Double(rating) {
                    let newMovie = Movie(id: Int.random(in: 1...10000), title: title, director: director, year: yearInt, rating: ratingDouble)
                    viewModel.postMovie(movie: newMovie)
                    dismiss() // Dismiss the shThe Hoeet after submitting
                }
            }) {
                Text("Submit")
                    .font(.custom("JetBrainsMono-Regular", size: 15))
                    .foregroundColor(Color.white)
                    .padding() // Add padding inside the button
                    .frame(maxWidth: .infinity) // Make the button width expand to the available space
                    .background(Color("BorderColour")) // Use the custom border color
                    .cornerRadius(30) // Add corner radius to the button
            }
            .padding(.horizontal, 50) // Add padding to the sides of the button
        }
        .padding() // Add padding around the VStack
    }
}

struct LabelTextField : View {
    var label: String
    var placeHolder: String
    @Binding var textValue: String // Use a Binding to allow for two-way data flow

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.custom("JetBrainsMono-Regular", size: 15))
            TextField(placeHolder, text: $textValue)
                .padding(.all)
                .background(Color("Background")) // Set the background color
                .cornerRadius(30) // Apply corner radius to the background
                .overlay(
                    RoundedRectangle(cornerRadius: 30) // Apply corner radius to the overlay stroke
                        .stroke(Color("BorderColour"), lineWidth: 2)
                )
                .padding(.bottom, 20)
        }
        .padding(.horizontal, 12)
    }
}

//#Preview {
//    AddMovieView()
//}
