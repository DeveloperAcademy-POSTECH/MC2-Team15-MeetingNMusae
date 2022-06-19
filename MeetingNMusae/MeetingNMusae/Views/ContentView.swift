//
//  ContentView.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/09.
//

import SwiftUI
//Role(id: 1, roleName: "진행무새"),
//Role(id: 2, roleName: "기록무새"),
//Role(id: 3, roleName: "타임무새"),
//Role(id: 4, roleName: "주제무새"),
//Role(id: 5, roleName: "이해무새"),
//Role(id: 6, roleName: "왜??무새"),

struct ContentView: View {
    @ObservedObject var reviewViewModel = ReviewViewModel()
    
    var body: some View {
        VStack {
            Button {
                reviewViewModel.addReview(review: Review(content: "이해가 안되는 말이 있었는데 그 순간 나의 이해도를 파악하고 먼저 물어봐줘서 고마웠다", from: "박시개", to: "유니스", roomCode: "GXKXQ7", revieweeRoleId: 5)
                )} label: {
                    Text("버튼")
                }
            Button {
                reviewViewModel.addReview(review: Review(content: "자칫하면 모두 동의하고 넘어갈 수 있는 상황에 대해서도 질문을 던짐으로써 더 깊은 생각을 할 수 있게 도와줬다", from: "유니스", to: "쏘니", roomCode: "GXKXQ7", revieweeRoleId: 6)
                )} label: {
                    Text("버튼")
                }
            Button {
                reviewViewModel.addReview(review: Review(content: "주제가 벗어날 때마다 주제를 바로 잡아 주어서 회의가 산으로 가지 않고 제대로 된 방향으로 흘러 갈 수 있었다", from: "쏘니", to: "스킵", roomCode: "GXKXQ7", revieweeRoleId: 4)
                )} label: {
                    Text("버튼")
                }
            Button {
                reviewViewModel.addReview(review: Review(content: "각 주제 별로 시간을 제대로 지켜주셔서 회의가 빠르게 진행될 수 있었습니다.", from: "스킵", to: "우기", roomCode: "GXKXQ7", revieweeRoleId: 3)
                )} label: {
                    Text("버튼")
                }
            Button {
                reviewViewModel.addReview(review: Review(content: "회의 안건들과 의견들이 정리가 잘 되어서 나의 주장을 펼치기에 수월했다. 회의가 논리적으로 흘러간 것 같음", from: "우기", to: "닉", roomCode: "GXKXQ7", revieweeRoleId: 2)
                )} label: {
                    Text("버튼")
                }
            Button {
                reviewViewModel.addReview(review: Review(content: "진행을 매끄럽게 잘한 것 같다", from: "닉", to: "박시개", roomCode: "GXKXQ7", revieweeRoleId: 1)
                )} label: {
                    Text("버튼")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
