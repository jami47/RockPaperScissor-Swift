//
//  ContentView.swift
//  RockPaperScissor-Swift
//
//  Created by Gaming Lab on 7/11/24.
//

import SwiftUI

struct ContentView: View {
    
    // State variables to track the player's and CPU's choices
    @State private var playerChoice: String? = nil
    @State private var cpuChoice: String? = nil
    
    // State variables to track scores
    @State private var playerScore = 0
    @State private var cpuScore = 0
    
    // State to control the animation of the selected option
    @State private var animateChoice = false
    
    // State to control when the results should be shown (after both choices are made)
    @State private var showResults = false
    
    // Array of asset names for the rock, paper, and scissors options
    let options = ["hrock", "hpaper", "hscissors"]
    
    // Function to decide the outcome based on player's and CPU's choices
    func decideWinner() {
        guard let player = playerChoice, let cpu = cpuChoice else { return }
        
        // Determine the result of the game
        if player == cpu {
            // It's a tie, no score update
            return
        }
        
        // Define the winning combinations
        if (player == "hrock" && cpu == "hscissors") ||  // Rock beats Scissors
            (player == "hscissors" && cpu == "hpaper") || // Scissors beats Paper
            (player == "hpaper" && cpu == "hrock") {      // Paper beats Rock
            // Player wins
            playerScore += 1
        } else {
            // CPU wins
            cpuScore += 1
        }
    }
    
    var body: some View {
        ZStack {
            // Background Image (you can customize this as you like)
            Image("background-wood-grain") // Replace with your own image name
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Spacer for top padding
                Spacer()
                
                // Game Title
                Text("Rock Paper Scissors")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                // Spacer for some space below the title
                Spacer()
                
                // Horizontal Stack for displaying choices
                HStack(spacing: 10) {
                    // Rock Button (using hrock image for rock)
                    Button(action: {
                        animateChoice = true
                        playerChoice = "hrock"  // Rock
                        cpuChoice = nil // Reset CPU choice before randomization
                        showResults = false
                        
                        // Simulate a slight delay for the CPU to make a random choice
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            cpuChoice = options.randomElement() // CPU makes its choice after delay
                            showResults = true
                            decideWinner()
                        }
                    }) {
                        Image("hrock") // Custom Rock Image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .padding()
                            .scaleEffect(animateChoice ? 1.2 : 1.0) // Animation on click
                            .animation(.easeInOut(duration: 0.3), value: animateChoice)
                    }
                    
                    // Paper Button (using hpaper image for paper)
                    Button(action: {
                        animateChoice = true
                        playerChoice = "hpaper"  // Paper
                        cpuChoice = nil // Reset CPU choice before randomization
                        showResults = false
                        
                        // Simulate a slight delay for the CPU to make a random choice
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            cpuChoice = options.randomElement() // CPU makes its choice after delay
                            showResults = true
                            decideWinner()
                        }
                    }) {
                        Image("hpaper") // Custom Paper Image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .padding()
                            .scaleEffect(animateChoice ? 1.2 : 1.0) // Animation on click
                            .animation(.easeInOut(duration: 0.3), value: animateChoice)
                    }
                    
                    // Scissors Button (using hscissors image for scissors)
                    Button(action: {
                        animateChoice = true
                        playerChoice = "hscissors" // Scissors
                        cpuChoice = nil // Reset CPU choice before randomization
                        showResults = false
                        
                        // Simulate a slight delay for the CPU to make a random choice
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            cpuChoice = options.randomElement() // CPU makes its choice after delay
                            showResults = true
                            decideWinner()
                        }
                    }) {
                        Image("hscissors") // Custom Scissors Image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .padding()
                            .scaleEffect(animateChoice ? 1.2 : 1.0) // Animation on click
                            .animation(.easeInOut(duration: 0.3), value: animateChoice)
                    }
                }
                
                // Spacer for some space below the buttons
                Spacer()
                
                // Show selected choices and results
                if showResults {
                    HStack(spacing: 30) {
                        // Display Player's Choice
                        VStack {
                            Text("YOU:")
                                .font(.headline)
                                .foregroundColor(.white)
                            Image(playerChoice ?? "questionmark.circle") // Display the player's image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .foregroundColor(.white)
                        }
                        
                        // Display CPU's Choice
                        VStack {
                            Text("CPU:")
                                .font(.headline)
                                .foregroundColor(.white)
                            Image(cpuChoice ?? "questionmark.circle") // Display the CPU's image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    
                    // Display the results of the round
                    Text(playerChoice == cpuChoice ? "It's a Tie!" : (playerChoice == "hrock" && cpuChoice == "hscissors" ||
                                                                  playerChoice == "hpaper" && cpuChoice == "hrock" ||
                                                                  playerChoice == "hscissors" && cpuChoice == "hpaper" ? "You Win!" : "You Lose!"))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                }
                
                // Spacer to push content to the top
                Spacer()
                
                // Display Scores
                HStack(spacing: 10) {
                    VStack {
                        Text("Player Score")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("\(playerScore)")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    Spacer()
                    VStack {
                        Text("CPU Score")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("\(cpuScore)")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                }
                .padding()
                
                // Button to restart the game
                Button(action: {
                    playerChoice = nil
                    cpuChoice = nil
                    showResults = false
                    animateChoice = false
                }) {
                    Text("Restart Game")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

