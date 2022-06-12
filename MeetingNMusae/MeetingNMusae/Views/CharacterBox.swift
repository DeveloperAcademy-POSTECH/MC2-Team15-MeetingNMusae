//
//  CharacterBox.swift
//  MeetingNMusae
//
//  Created by 김태호 on 2022/06/11.
//
import SwiftUI

struct CharacterBox: View {
    let colorList: [Color] = [.black, .musaeBlue, .musaeOrange, .musaeMint,
                              .musaeGreen, .musaeLightGreen, .musaePurple,
                              .musaeSkyBlue, .musaePink, .musaeRed, .musaeMustard]
    let width: CGFloat?
    let height: CGFloat?
    var roleIndex: Int
    
    init(width: CGFloat? = nil, height: CGFloat? = nil, roleIndex:Int = 0) {
        self.width = width
        self.height = height
        self.roleIndex = 0...10 ~= roleIndex ? roleIndex : 0
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .foregroundColor(.white)
            .frame(width: width, height: height)
            .shadow(color: colorList[roleIndex], radius: 0, x: 8, y: 8)
            .overlay(RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.black, lineWidth: 3)
            )
    }
}

