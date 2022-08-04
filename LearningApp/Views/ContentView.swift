//
//  ContentView.swift
//  LearningApp
//
//  Created by Abdelrahman Mohammad on 6/2/22.
//

import SwiftUI

struct ContentView: View {
    
//    var module: Module
    @EnvironmentObject var model: ContentModel
    
    
    var body: some View {
        
        ScrollView {
            LazyVStack(spacing: 20){
                
                if model.currentModule != nil{
                    ForEach(0..<model.currentModule!.content.lessons.count){ i in

                        NavigationLink {
                            ContentDetailView()
                                .onAppear {
                                    model.beginLesson(i)
                                }
                        } label: {
                            ContentCardView(index: i)
                        }
                        .accentColor(.black)
                    }
                }
                
            }
            .padding()
            .navigationTitle("Learn \(model.currentModule?.category ?? "")")
        }
        
    }
}
