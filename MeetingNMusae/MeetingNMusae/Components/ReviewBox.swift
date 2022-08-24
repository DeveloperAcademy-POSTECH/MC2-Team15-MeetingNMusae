//
//  ReviewBox.swift
//  MeetingNMusae
//
//  Created by 김태호 on 2022/06/17.
//

import SwiftUI

struct ReviewBox: View {
    let user: String
    let role: String
    let review: String
    let roleIndex: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 0) {
                    NameBox(user: user)
                    Text(role)
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.leading, 8)
                    Spacer()
                }// HStack_Name_Role
                
                Text(review)
                    .font(.callout)
                    .foregroundColor(.gray)
                    .fixedSize(horizontal: false, vertical: true)
            }// VStack_Review
            .padding([.top, .leading, .bottom], 20)
            
            Spacer()
            
            VStack {
                Spacer()
                Image(Role.roles[roleIndex].roleName)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .padding(.trailing, 17)
                    .padding(.bottom, 4)
            }
        }// HStack
        .frame(width: UIScreen.screenWidth * 0.84)
        .background(
            CharacterBox(roleIndex: roleIndex)
                .padding(.trailing, 8)
        )
        .padding(.bottom, 20)
//        .padding(.leading, 28)
    }
}
