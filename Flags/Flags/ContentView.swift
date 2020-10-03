//
//  ContentView.swift
//  Flags
//
//  Created by denpazakura on 01/10/2020.
//  Copyright © 2020 denpazakura. All rights reserved.
//

import SwiftUI

let color1 = Color(red: 233/255.0, green: 241/255.0, blue: 242/255.0)
let color2 = Color(red: 189/255.0, green: 200/255.0, blue: 216/255.0)

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var currentScore = 0
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [color1, color2]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number].lowercased())
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                    Spacer()
                }
                
                Text("current score: \(currentScore)")
                    .foregroundColor(.white)
                    .font(.largeTitle)
            }
                
            .alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTitle), message: Text("Your score is \(currentScore)"), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                    })
            }
        }
    }
    
    private func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            addPoints()
        } else {
            deduct()
            scoreTitle = "Wrong, that's \(countries[number])"
        }
        
        showingScore = true
    }
    
    private func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    private func addPoints() {
        currentScore += 1
    }
    
    private func deduct() {
        guard currentScore != 0 else {
            return
        }
        
        currentScore -= 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}