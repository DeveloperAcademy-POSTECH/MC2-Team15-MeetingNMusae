//
//  NameBox.swift
//  MeetingNMusae
//
//  Created by taekkim on 2022/06/13.
//
//
//import SwiftUI
//
//struct NameBox: View {
//    let isDark: Bool
//    var description: String
//
//    var body: some View {
//        ZStack {
//            RoundedRectangle(cornerRadius: 12)
//                .foregroundColor(isDark ? .black : .white)
//            Text(description)
//                .font(.headline)
//                .fontWeight(.bold)
//                .foregroundColor(isDark ? .white : .black)
//            RoundedRectangle(cornerRadius: 12)
//                .stroke(Color.black, lineWidth: 3)
//
//        }
//        .frame(height: 65)
//        .padding(.horizontal, 28)
//    }
//}
//

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
