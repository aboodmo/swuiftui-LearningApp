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
                                
//                                if index == SelectedAnwserIndex {
//                                    RectangleCard(color: .gray)
//                                        .frame(height: 48)
//                                }else if (isSubmitted && index == model.currentQuestion!.correctIndex){
//                                    RectangleCard(color: .green)
//                                        .frame(height: 48)
//                                }else if (isSubmitted && index != model.currentQuestion!.correctIndex){
//                                    RectangleCard(color: .red)
//                                        .frame(height: 48)
//                                }else{
//                                    RectangleCard(color: .white)
//                                        .frame(height: 48)
//                                }
//                                RectangleCard(color: index == SelectedAnwserIndex ? .gray : .white)
//                                    .frame(height: 48)
                                
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
                if SelectedAnwserIndex == model.currentQuestion!.correctIndex {
                    score += 1
                }
                isSubmitted = true
            } label: {
                ZStack{
                    RectangleCard(color: .green)
                        .frame(height: 48)
                    
                    Text("Submit")
                        .bold()
                        .foregroundColor(.white)
                    
                }
                .padding()
            }.disabled(SelectedAnwserIndex == -1)

            
        }else{
            ProgressView()
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
