//
//  IntroView.swift
//  MovieList
//
//  Created by Winsome Tang on 2024-02-11.
//

import SwiftUI

struct IntroView: View {
    @State private var isPresenting = false  // State to manage the presentation of the full-screen cover

    var body: some View {
        VStack {
            Spacer()

            Text("The")
                .font(.custom("JetBrainsMono-Regular", size: 35))
                .fontWeight(.light)
                .multilineTextAlignment(.center)

            Text("Epic Movie List")
                .font(.custom("JetBrainsMono-Bold", size: 35))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.bottom, 50)

            // Assuming you have an image named "movieCamera" in your assets
            Image("MovieCamera")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)

            Text("It's movie time! ! !")
                .font(.custom("JetBrainsMono-Regular", size: 15))
                .fontWeight(.light)
                .padding()

            // Use a Button to present the full-screen cover
            Button(action: {
                isPresenting = true
            }) {
                Text("START HERE.")
                    .font(.custom("JetBrainsMono-Regular", size: 20))
                    .foregroundColor(Color("BorderColour"))
                    .padding(.vertical)
                    .padding(.horizontal, 50)
                    .background(Color.white)
                    .cornerRadius(30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color("BorderColour"), lineWidth: 1)
                    )
            }
            .padding()
            .fullScreenCover(isPresented: $isPresenting) {
                MoviesView(isPresented: self.$isPresenting)  // The view to show when the sheet is presented
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color("Background").ignoresSafeArea())
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
