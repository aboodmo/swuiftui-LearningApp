//
//  ContentDetailView.swift
//  LearningApp
//
//  Created by Abdelrahman Mohammad on 6/3/22.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHost + (lesson?.video ?? ""))
        
        VStack {
            if url != nil {
                VideoPlayer(player: AVPlayer(url: url!))
                    .cornerRadius(10)
            }
            
            if model.hasNextLesson() {
                Button {
                    // Advance lesson
                    model.nextLesson()
                } label: {
                    ZStack{
                        
                        Rectangle()
                            .frame(height: 48)
                            .foregroundColor(Color.green)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .foregroundColor(Color.white)
                            .bold()
                        
                    }
                    
                }

            }
                
        
        }
        .padding()
        
        
        
        
        
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
