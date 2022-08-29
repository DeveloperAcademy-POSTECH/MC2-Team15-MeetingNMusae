//
//  CharacterBox.swift
//  MeetingNMusae
//
//  Created by 김태호 on 2022/06/11.
//
import SwiftUI

struct CharacterBox: View {
    let colorList: [Color] = [.black, .musaeBlue, .musaeOrange, .musaeMint,
                              .musaeRed, .musaeMustard, .musaePurple, .musaePink,
                              .musaeGreen, .musaeLightGreen, .musaeSkyBlue]
    let width: CGFloat?
    let height: CGFloat?
    let shadowWidth: CGFloat
    let strokeBorderWidth: CGFloat
    var roleIndex: Int

    init(width: CGFloat? = nil, height: CGFloat? = nil, roleIndex: Int = 0, shadowWidth: CGFloat = 8.0, strokeBorderWidth: CGFloat = 3.0) {
        self.width = width
        self.height = height
        self.roleIndex = 0...10 ~= roleIndex ? roleIndex : 0
        self.shadowWidth = 8.0
        self.strokeBorderWidth = 3.0
    }

    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .foregroundColor(.white)
            .frame(width: width, height: height)
            .shadow(color: colorList[roleIndex], radius: 0, x: shadowWidth, y: shadowWidth)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(Color.black, lineWidth: strokeBorderWidth)
            )
    }
}

