//
//  NameBox.swift
//  MeetingNMusae
//
//  Created by taekkim on 2022/06/13.
//

import SwiftUI

struct NameBox: View {
    let user: String

    var body: some View {
        RoundedRectangle(cornerRadius: 6.0)
        .fill(Color.black)
        .frame(minWidth: UIScreen.screenWidth * 0.103, maxWidth: UIScreen.screenWidth * 0.174,
               maxHeight: UIScreen.screenHeight * 0.0296)
        .overlay(
            Text("\(user)")
                .font(.callout)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal, 6)
                .padding(.vertical, 1)
        )
    }
}
