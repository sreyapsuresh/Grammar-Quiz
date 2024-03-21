//  ContentView.swift
//  GrammarQuiz

import SwiftUI


// Question initialization
var questions: [Question] = [.init(question: "What is the correct plural form of 'child'?", options: ["childs", "childrens", "child", "children"], answer: "children"),
    .init(question: "Which of the following is a comparative adjective?", options: ["Good", "Better", "Best", "Great"], answer: "Better"),
    .init(question: "Identify the correct usage of the word 'their' in a sentence:", options: ["Their going to the store.", "They're going to the store.", "There going to the store.", "Their going to the store."], answer: "They're going to the store."),
    .init(question: "Which punctuation mark is used to separate items in a list?", options: ["Colon (:)","Semicolon (;)","Comma (,)","Dash (-)"], answer: "Comma (,)"),
    .init(question: "What is the past tense of the verb 'sing'?", options: ["Singed", "Sang", "Sung", "Sing"], answer: "Sang")]

struct ContentView: View {
    
    // Private variables
    @State private var questionCount = 0
    @State private var score = 0
    @State private var userAnswer = ""
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Text("Grammar Quiz")
                .font(.largeTitle.bold())
                .padding()
            
            // Question counter
            Text("Question \(questionCount + 1) of \(questions.count)")
                .frame(width: 300)
                .bold()
            
            Text(questions[questionCount].question)
                .padding()
                .frame(width: 350)
                .multilineTextAlignment(.center)
            
            // Creates button for each option
            ForEach(questions[questionCount].options, id: \.self) { option in
                Button(action: {
                    self.checkAnswer(selectedOption: option)
                }) {
                    Text(option)
                        .padding()
                        .frame(width: 300)
                        .background(Color.teal)
                        .foregroundColor(.white) // Text color
                        .cornerRadius(10)
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Result"), message: Text("You scored \(score)/\(questions.count)"), dismissButton: .default(Text("Restart")) {
                // Reset variables
                questionCount = 0
                score = 0
                userAnswer = ""
                showAlert = false
            })
        }
    }
    
    func checkAnswer(selectedOption: String) {
        // Score iteration
        if selectedOption == questions[questionCount].answer {
            score += 1
        }
        
        // Game end criteria
        if self.questionCount + 1 < questions.count {
            self.questionCount += 1
        } else {
            showAlert = true
        }
    }
}

#Preview {
    ContentView()
}

struct Question {
    let question: String
    let options: [String]
    let answer: String
}
