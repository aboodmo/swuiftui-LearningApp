//
//  LearningAppApp.swift
//  LearningApp
//
//  Created by Abdelrahman Mohammad on 6/2/22.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
