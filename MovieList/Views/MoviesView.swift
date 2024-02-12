//
//  MoviesView.swift
//  MovieList
//
//  Created by Winsome Tang on 2024-02-11.
//
import SwiftUI

struct MoviesView: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel = MovieViewModel()
    
    var body: some View {
        VStack(spacing: 5) { // Remove spacing between VStack elements
            HStack{
                Button(action: {
                    self.isPresented = false  // Dismiss the full screen cover
                }) {
                    Image(systemName: "arrow.left") // SF Symbol for back arrow
                        .foregroundColor(Color("Background"))
                        
                        .padding()
                        .background(Color("BorderColour")) // Custom color
                        .clipShape(Circle())
                }
                
                Text("Discover")
                    .font(.custom("JetBrainsMono-Bold", size: 35))
                    .fontWeight(.bold)
                Image("Woohoo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40) // Adjusted height to match the text better
            }
            .padding(.top, 20) // Add padding only to the top to push it down from the safe area
           
            List(viewModel.movies) { movie in
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.custom("JetBrainsMono-Bold", size: 15))
                    Text(movie.director)
                        .font(.custom("JetBrainsMono-Regular", size: 10))
                    HStack {
                        Text("Year: \(movie.year)")
                        Spacer()
                        Text("Rating: \(movie.rating, specifier: "%.1f")")
                    }
                    .padding(.top,5)
                    .font(.custom("JetBrainsMono-Regular", size: 10))
                }
                .listRowBackground(Color("Background"))
                .listRowSeparator(.hidden) //None of that ugly default horizontal line between list rows
                .padding(.vertical, 10)
                .padding(.horizontal)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("BorderColour"), lineWidth: 2)
                )
            }
            .listStyle(PlainListStyle())
        }
        .onAppear {
            viewModel.fetchMovies()
        }
        .background(Color("Background").ignoresSafeArea())
    }
}
struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        // Provide a constant binding value for the preview
        MoviesView(isPresented: .constant(true))
            .environmentObject(MovieViewModel()) // If your MovieViewModel is designed to be used as an EnvironmentObject
    }
}
