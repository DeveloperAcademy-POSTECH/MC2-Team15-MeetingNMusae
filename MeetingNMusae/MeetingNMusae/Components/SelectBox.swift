//
//  SelectBox.swift
//  MeetingNMusae
//
//  Created by 김태호 on 2022/06/13.
//

import SwiftUI

struct SelectBox: View {
    private let horizontalPadding = UIScreen.screenWidth * 0.0718
    private let bottomPadding = 8.0
    private let boxHeight = UIScreen.screenHeight * 0.076
    let isDark: Bool
    var description: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(isDark ? .black : .white)
            Text(description)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(isDark ? .white : .black)
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.black, lineWidth: 3)
            
        }
        .frame(height: boxHeight)
        .padding(.horizontal, horizontalPadding)
        .padding(.bottom, bottomPadding)
    }
}
