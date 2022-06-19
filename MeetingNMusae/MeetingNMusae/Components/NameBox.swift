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
            .bold()
            .padding(4)
            .foregroundColor(.white)
            .background(RoundedRectangle(cornerRadius: 6.0).fill(Color.black))
    }
}
