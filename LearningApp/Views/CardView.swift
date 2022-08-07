//
//  CardView.swift
//  LearningApp
//
//  Created by Abdelrahman Mohammad on 6/2/22.
//

import SwiftUI

struct CardView: View {
    
    var image: String
    var title: String
    var description: String
    var lessons: String
    var time: String
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .aspectRatio(CGSize(width: 335, height: 175), contentMode: .fit)
            
            
            HStack {
                
                // Image
                Image(image)
                    .resizable()
                    .frame(width: 116, height: 116)
                    .clipShape(Circle())
                
                
                VStack(alignment: .leading, spacing: 10){
                    
                    // Title and Description
                    Text(title)
                        .bold()
                    Text(description)
                        .font(.caption)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 20.0)
                    
                    
                    HStack {
                        
                        // Icon + # of lessons
                        Image(systemName: "text.book.closed")
                            .resizable()
                            .frame(width: 15, height: 15)
                        Text(lessons)
                            .font(Font.system(size: 10))
                        
                        Spacer()
                        
                        // Icon + amount of time
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 15, height: 15)
                        Text(time)
                            .font(Font.system(size: 10))
                    }
                }
                .padding(.leading, 20.0)
            }
            .padding(.horizontal, 20.0)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(image: "swift", title: "Learn Swift", description: "description", lessons: "10 lessons", time: "3 hours")
    }
}
