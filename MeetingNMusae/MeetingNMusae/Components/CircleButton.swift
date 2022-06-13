//
//  CircleButton.swift
//  MeetingNMusae
//
//  Created by 김태호 on 2022/06/13.
//

import SwiftUI

struct CircleButton: View {
    @Binding var text: String
    
    var body: some View {
        Circle()
            .foregroundColor(text.isEmpty ? .gray : .black)
            .frame(width: 64, height: 64)
            .overlay(
                Image(systemName: "arrow.right")
                    .foregroundColor(.white)
            )
    }
}
