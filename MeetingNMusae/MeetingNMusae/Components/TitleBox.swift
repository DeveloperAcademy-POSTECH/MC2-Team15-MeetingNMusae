//
//  TitleBox.swift
//  MeetingNMusae
//
//  Created by 김태호 on 2022/06/17.
//

import SwiftUI

struct TitleBox: View {
    var description: String
    var body: some View {
        Text(description)
            .font(.title)
            .fontWeight(.heavy)
            .padding(.top, 28)
    }
}
