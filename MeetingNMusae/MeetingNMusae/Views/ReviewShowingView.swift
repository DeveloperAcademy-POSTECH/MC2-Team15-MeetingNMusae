//
//  ReviewShowingView.swift
//  MeetingNMusae
//
//  Created by 김태호 on 2022/06/17.
//

import SwiftUI

struct ReviewShowingView: View {
    //    roleIndex를 받아와서 ReviewBox에 넣어주시면 됩니다
    @ObservedObject var reviewViewModel = ReviewViewModel()
    
    var body: some View {
        VStack {
            TitleBox(description: "무새가 무새에게")
                .padding(.bottom, 28)
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(reviewViewModel.reviews) { review in
                        ReviewBox(user: review.to, role: Role.roles[review.revieweeRoleId].roleName, review: review.content, roleIndex: review.revieweeRoleId)
                    }
                }
            }
            .onAppear {
                reviewViewModel.fetchData(roomCode: "GXKXQ7")
            }
            SelectBox(isDark: true, description: "나가기")
                .padding(.top)
            Spacer()
        }
    }
}

//struct ReviewShowingView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReviewShowingView(roomCode: <#T##String#>)
//    }
//}
