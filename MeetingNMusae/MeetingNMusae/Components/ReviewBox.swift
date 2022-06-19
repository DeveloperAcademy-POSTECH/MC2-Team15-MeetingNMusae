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
            
            // 이미지에 role을 넣어주면 됩니다
            // 현재는 이미지가 없어서 "회의하는N무새" 임시로 배치했습니다
            Image(Role.roles[roleIndex].roleName)
                .resizable()
                .frame(width: 64, height: 64)
                .padding(.trailing, 17)
                .padding(.leading, 20)
        }// HStack
        .frame(width: UIScreen.screenWidth * 0.84)
        .background(
            CharacterBox(roleIndex: roleIndex)
                .padding(.horizontal, 8)
        )
        .padding(.bottom, 20)
//        .padding(.leading, 28)
    }
}
