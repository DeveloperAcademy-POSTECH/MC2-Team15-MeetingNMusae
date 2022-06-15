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
        Text("\(user)")
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(1)
            .padding(.horizontal, 5)
            .background(RoundedRectangle(cornerRadius: 6.0)
                .fill(Color.black)
                .frame(minWidth: UIScreen.screenWidth * 0.1027)
            )
    }
}

