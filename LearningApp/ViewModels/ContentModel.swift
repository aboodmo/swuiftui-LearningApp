//
//  ContentModel.swift
//  LearningApp
//
//  Created by Abdelrahman Mohammad on 6/2/22.
//

import Foundation

class ContentModel: ObservableObject {
    
    // List of Modules
    @Published var modules = [Module]()
    
    // Current Module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    @Published var currentLesson: Lessons?
    var currentLessonIndex = 0
    
    var styleData: Data?
    
    init() {
        getLocalData()
    }
    
    // MARK: - Data Methods
    func getLocalData() {
        
        // Get url of json file
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do{
            // read the file into data object
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            let jsonDecoder = JSONDecoder()
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            
            // Assign parsed modules into modules
            self.modules = modules
            
        }catch{
            print("Couldn't parse local data")
        }
        
        
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            let styleData = try Data(contentsOf: styleUrl!)
            
            self.styleData = styleData
            
        }catch {
            print("Couldn't parse style data")
        }
    }


    // MARK: - Module Navigation Methods
    func beginModule(_ moduleId:Int){
        
        // find current modules index
        for i in 0..<modules.count {
            if modules[i].id == moduleId{
                currentModuleIndex = i
                break
            }
        }
        
        currentModule = modules[currentModuleIndex]
    }
    
    // MARK: - Lesson Navigation Method
    func beginLesson(_ lessonIndex: Int) {
        
        if lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonIndex
        }else{
            currentLessonIndex = 0
        }
        
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        
    }
    
    func nextLesson() {
        currentLessonIndex += 1
        
        if currentLessonIndex < currentModule!.content.lessons.count {
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
        }else{
            currentLesson = nil
            currentLessonIndex = 0
        }
        
    }
    
    func hasNextLesson() -> Bool {
       
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
    }
}
