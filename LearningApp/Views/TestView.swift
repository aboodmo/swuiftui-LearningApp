//
//  TestView.swift
//  LearningApp
//
//  Created by Abdelrahman Mohammad on 8/5/22.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        if model.currentQuestion != nil{
            
            VStack {
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
            }
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
            
            CodeTextView()
            
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
