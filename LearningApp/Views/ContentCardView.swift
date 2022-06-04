//
//  ContentCardView.swift
//  LearningApp
//
//  Created by Abdelrahman Mohammad on 6/3/22.
//

import SwiftUI

struct ContentCardView: View {
    
    @EnvironmentObject var model: ContentModel
    var index: Int
    
    var body: some View {
        
        let lesson = model.currentModule!.content.lessons[index]
        
        ZStack(alignment: .leading){
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .aspectRatio(CGSize(width: 230, height: 50), contentMode: .fit)

            HStack {
                // Number
                Text("\(index + 1)")
                    .font(.title)
                    .padding(.trailing, 20.0)


                VStack(alignment: .leading, spacing: 1) {
                    // Title
                    Text(lesson.title)
                        .bold()

                    // Duration
                    Text("Video - " + lesson.duration)
                        .font(.footnote)
                    

                }
            }.padding()

        }
    }
}

