//
//  ContentView.swift
//  JokeGenerator
//
//  Created by Otourou Da Costa on 22/03/2024.
//

import SwiftUI
import GoogleGenerativeAI

struct ContentView: View {
    @State private var topic = ""
    @State private var joke = ""
    @State private var isGenerating = false
    
    var body: some View {
        VStack {
            TextField("Enter a topic", text: $topic)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: generateJoke) {
                Text("Generate Joke")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .disabled(isGenerating)
            
            if isGenerating {
                ProgressView()
                    .padding()
            }
            
            Text(joke)
                .padding()
        }
    }
    
    private func generateJoke() {
        isGenerating = true
        
        let model = GenerativeModel(name: "gemini-pro", apiKey: APIKey.geminiKey)
        let prompt = "Generate a joke about \(topic)."
        
        Task {
            do {
                let response = try await model.generateContent(prompt)
                joke = response.text ?? "Failed to generate a joke. Please try again."
            } catch {
                joke = "Failed to generate a joke. Please try again."
            }
            
            isGenerating = false
        }
    }
}

#Preview {
    ContentView()
}
