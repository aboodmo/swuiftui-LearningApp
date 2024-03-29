//
//  TestView.swift
//  LearningApp
//
//  Created by Abdelrahman Mohammad on 8/5/22.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    
    @State var SelectedAnwserIndex = -1
    @State var score = 0
    @State var isSubmitted = false
    
    var body: some View {
        
        if model.currentQuestion != nil{
            
            // Question Number
            VStack {
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                    .padding(.leading, 20)
            }
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
            
            // Question
            CodeTextView()
                .padding(.horizontal, 20)
            
            // Answers
            ScrollView {
                VStack{
                    ForEach (0..<model.currentQuestion!.answers.count, id: \.self) { index in
                        
                        Button {
                            SelectedAnwserIndex = index
                        } label: {
                            ZStack{
                                
                                if !isSubmitted {
                                    // Answer is not submitted
                                    RectangleCard(color: index == SelectedAnwserIndex ? .gray : .white)
                                        .frame(height: 48)
                                }else{
                                    // Answer is submitted
                                    
                                    // Correct Answer is green
                                    if index == model.currentQuestion!.correctIndex {
                                        RectangleCard(color: .green)
                                            .frame(height: 48)
                                    }else {
                                        // If incorrect, answer chosen is red
                                        // All others stay white
                                        RectangleCard(color: index == SelectedAnwserIndex ? .red : .white)
                                            .frame(height: 48)
                                    }
                                }
                                
                                
                                Text(model.currentQuestion!.answers[index])
                                
                            }
                            
                        }
                        .disabled(isSubmitted)
                        
                    }
                    
                    
                }
                .accentColor(.black)
                .padding()
            }
            
            // Submit Answers Button
            Button {
                
                if isSubmitted {
                    // move to next question
                    model.nextQuestion()
                    
                    // Reset Proporties
                    isSubmitted = false
                    SelectedAnwserIndex = -1
                    
                }else{
                    // submit the answer
                    isSubmitted = true
                    
                    if SelectedAnwserIndex == model.currentQuestion!.correctIndex {
                        score += 1
                    }
                }
                
                
                
                
            } label: {
                ZStack{
                    RectangleCard(color: .green)
                        .frame(height: 48)
                    
                    Text(buttonText)
                        .bold()
                        .foregroundColor(.white)
                    
                }
                .padding()
            }.disabled(SelectedAnwserIndex == -1)
            
            
        }else{
            //            ProgressView()
            TestResultsView(score: score)
        }
    }
    
    var buttonText: String {
        
        if isSubmitted {
            if model.currentQuestionIndex + 1 == model.currentModule!.test.questions.count {
                return "Finish"
            }else {
                return "Next"
            }
            
            
        }else {
            return "Submit"
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
