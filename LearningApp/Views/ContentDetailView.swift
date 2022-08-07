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
            //Video
            if url != nil {
                VideoPlayer(player: AVPlayer(url: url!))
                    .cornerRadius(10)
            }
            
            // Discription
            CodeTextView()
            
            // Button to next lesson
            if model.hasNextLesson() {
                Button {
                    // Advance lesson
                    model.nextLesson()
                } label: {
                    ZStack{
                        
                        RectangleCard(color: Color.green)
                            .frame(height: 48)
                        
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .foregroundColor(Color.white)
                            .bold()
                        
                    }
                    
                }
                
            }
            else{
                // Show Complete botton
                Button {
                    // Advance lesson
                    model.currentContentSelected = nil
                } label: {
                    ZStack{
                        
                        RectangleCard(color: Color.green)
                            .frame(height: 48)
                        
                        Text("Complete")
                            .foregroundColor(Color.white)
                            .bold()
                        
                    }
                    
                }
            }
            
            
        }
        .padding()
        .navigationBarTitle(lesson?.title ?? "")
        
        
        
        
        
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
