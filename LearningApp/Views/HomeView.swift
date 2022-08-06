//
//  ContentView.swift
//  LearningApp
//
//  Created by Abdelrahman Mohammad on 6/2/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading) {
                Text("What do you want to for today?")
                    .padding(.leading)
                
                ScrollView {
                    
                    LazyVStack(spacing: 30){
                        
                        ForEach(model.modules){ module in
                            
                            NavigationLink(tag: module.id, selection: $model.currentContentSelected, destination: {
                                ContentView()
                                    .onAppear {
                                        model.beginModule(module.id)
//                                        print(model.currentContentSelected)
                                    }
                            }, label: {
                                // Learning Card
                                CardView(image: module.content.image, title: "Learn " + module.category, description: module.content.description, lessons: "\(module.content.lessons.count) Lessons", time: module.content.time)
                            })
                            
//                            {
//                                ContentView()
//                                    .onAppear {
//                                        model.beginModule(module.id)
//                                    }
//
//                            },
//                        tag:
//                        tag:{ },
//                        selection:{ $model.currentContentSelected},
//                        label: {
//
//                                // Learning Card
//                                CardView(image: module.content.image, title: "Learn " + module.category, description: module.content.description, lessons: "\(module.content.lessons.count) Lessons", time: module.content.time)
//                            }
                            
                            

                            NavigationLink(tag: module.id, selection: $model.currentTestSelected, destination: {
                                TestView()
                                    .onAppear {
                                        model.beginTest(module.id)
//                                        print(model.currentContentSelected)
                                    }
                            }, label: {
                                //  Test Card
                                CardView(image: module.test.image, title: module.category + " Test", description: module.test.description, lessons: "\(module.test.questions.count) Lessons", time: module.test.time)
                            })
                            
//                            NavigationLink(tag: module.id, selection: $model.currentTestSelected, destination: TestView()) {
//
//                            }
//                            //  Test Card
//                            CardView(image: module.test.image, title: module.category + " Test", description: module.test.description, lessons: "\(module.test.questions.count) Lessons", time: module.test.time)
                            
                            
                        }
                        
                    }
                    .accentColor(.black)
                    .padding()
                }
            }.navigationTitle("Get Started")
        }
        .navigationViewStyle(.stack)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(ContentModel())
    }
}
