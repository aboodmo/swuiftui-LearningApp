//
//  RectangleCardView.swift
//  LearningApp
//
//  Created by Abdelrahman Mohammad on 8/4/22.
//

import SwiftUI

struct RectangleCardView: View {
    var body: some View {
        Rectangle()
            .frame(height: 48)
            .foregroundColor(Color.green)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

struct RectangleCardView_Previews: PreviewProvider {
    static var previews: some View {
        RectangleCardView()
    }
}
