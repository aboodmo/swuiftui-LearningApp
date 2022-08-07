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
    
    // Current Lesson
    @Published var currentLesson: Lessons?
    var currentLessonIndex = 0
    
    // Current Question
    @Published var currentQuestion: Questions?
    var currentQuestionIndex = 0
    
    // Current Lesson Description
    @Published var codeText = NSAttributedString()
    var styleData: Data?
    
    
    // Current selected content and test
    @Published var currentContentSelected: Int?    
    @Published var currentTestSelected: Int?
    
    init() {
        getLocalData()
        
        getRemoteData()
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
    
    func getRemoteData() {
        
        // String Path
        let urlString = "https://aboodmo.github.io/LearningApp-Data/data2.json"
        
        // Create url object
        let url = URL(string: urlString)
        
        guard url != nil else {
            return
        }
        
        // Create urlRequest object
        let request = URLRequest(url: url!)
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                
                let modules = try decoder.decode([Module].self, from: data!)
                
                DispatchQueue.main.async {
                    self.modules += modules
                }
                
                
            }catch {
                
            }
            
            
        }
        
        dataTask.resume()
        
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
        codeText = addStyling(currentLesson!.explanation)
    }
    
    func nextLesson() {
        // Advance the Lesson index
        currentLessonIndex += 1
        
        // Check if it is within the range of lessons
        if currentLessonIndex < currentModule!.content.lessons.count {
            
            // setting the current lesson
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
        }else{
            // Reset properties
            currentLesson = nil
            currentLessonIndex = 0
        }
        
    }
    
    func hasNextLesson() -> Bool {
       
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
    }
    
    func beginTest (_ moduleId: Int) {
        // Setting Current Module
        beginModule(moduleId)
        
        currentQuestionIndex = 0
        
        // setting the current question
        if currentModule?.test.questions.count ?? 0 > 0 {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion!.content)
        }
    }
    
    func nextQuestion (){
        // Advance the question index
        currentQuestionIndex += 1
        
        // Check if it is within the range of questions
        if currentQuestionIndex < currentModule!.test.questions.count {
            
            // Set the current question
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion!.content)
        }else{
            
            // Reset properties
            currentQuestion = nil
            currentQuestionIndex = 0
        }
    }
    
    // MARK: - Code Styling
    
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        
        var resultString = NSAttributedString()
        var data = Data()
        
        // Add the styling data
        if styleData != nil {
            data.append(styleData!)
        }
        
        // Add the html data
        data.append(Data(htmlString.utf8))
        
        // Convert to attributed string
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            
            resultString = attributedString
        }
        
        return resultString
    }
}
