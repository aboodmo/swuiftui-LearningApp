//
//  TestResultsView.swift
//  LearningApp
//
//  Created by Abdelrahman Mohammad on 8/7/22.
//

import SwiftUI

struct TestResultsView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var score: Int
    
    var resultsHeading: String {
        
        guard model.currentModule != nil else{
            return ""
        }
        
        let pct = Double(score)/Double(model.currentModule!.test.questions.count)
        
        if pct == 1 {
            return "Perfect!!!"
        }else if pct >= 0.75 {
            return "Doing Great!"
        }else if pct >= 0.5 {
            return "Well done"
        }else{
            return "Keep Learning"
        }
        
    }
    
    var body: some View {
        VStack {
            Text(resultsHeading)
                .font(.title)
            
            Text("You got \(score) out of \(model.currentModule?.test.questions.count ?? 0) questions")
            
            Button {
                
                // Send user back to home view
                model.currentTestSelected = nil
            } label: {
                
                ZStack {
                    RectangleCard(color: .green)
                        .frame(height: 48)
                    
                    Text("Complete")
                        .bold()
                        .foregroundColor(.white)
                    
                }
            }.padding()
            Spacer()
            
        }
    }
}

//struct TestResultsView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestResultsView()
//    }
//}
