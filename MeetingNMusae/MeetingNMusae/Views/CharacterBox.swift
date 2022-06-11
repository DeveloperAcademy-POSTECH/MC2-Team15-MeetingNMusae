//
//  CharacterBox.swift
//  MeetingNMusae
//
//  Created by 김태호 on 2022/06/11.
//

import Foundation
import SwiftUI

struct CharacterBox: View {
    let width: CGFloat?
    let height: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .foregroundColor(.white)
            .frame(width: width, height: height)
            .shadow(color: .black, radius: 0,  x: 8, y: 8)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.black, lineWidth: 3)
            )
    }
}
