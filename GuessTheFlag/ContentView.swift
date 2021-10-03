//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Sree on 12/09/21.
//

import SwiftUI




struct ContentView: View {
    struct  FlagVeiw: View {
        var imageName: String
        var body: some View {
            Image(self.imageName).renderingMode(.original).clipShape(Capsule()).overlay(Capsule().stroke(Color.black,lineWidth: 1)).shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 2)
        }
    }

    @State private var countries = ["Estonia","France","Germany","Ireland","Italy","Nigeria","Poland","Russia","Spain","UK","US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var rotate = 0.0
    @State private var clicked = Int()
    @State private var animationBool = false
    var body: some View {
        ZStack {
        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        VStack(spacing:40) {
        VStack {
            Text("Tap the flag of..").foregroundColor(.white)
            Text(countries[correctAnswer]).foregroundColor(.white).font(.largeTitle).fontWeight(.black)
        }
        ForEach(0..<3){ number in
            Button(action: {
                self.clicked = number
                withAnimation {
                    self.rotate += 360
                }
                self.flagTapped(number)
            }, label: {
                // Swift modifiers
                FlagVeiw(imageName: self.countries[number]).animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
            })        .rotation3DEffect(.degrees(clicked == number && clicked == correctAnswer ?  rotate : 0.0), axis: (x: 1, y: 1, z: 1))

        }.transition(.opacity)
        .zIndex(2)
            Text("Your score is \(score)").foregroundColor(.white).font(.title)
            Spacer()
        }
        }.alert(isPresented: $showingScore, content: {
            Alert(title:  Text(scoreTitle),message: Text("Your score \(score)"),dismissButton: .default(Text("Continue")){
                self.askQuestion()
            })
        })
        
    }
    func flagTapped(_ number: Int){
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            score+=1
        } else {
            scoreTitle = "Wrong! The correct flag is \(countries[correctAnswer])"
        }
        showingScore = true
    }
    
    
    func askQuestion() {
        countries.shuffle()
        withAnimation(Animation.easeOut) {
        correctAnswer = Int.random(in: 0...2)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
