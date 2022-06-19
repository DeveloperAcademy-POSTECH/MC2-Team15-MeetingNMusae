//
//  ReviewShowingView.swift
//  MeetingNMusae
//
//  Created by 김태호 on 2022/06/17.
//

import SwiftUI

struct ReviewShowingView: View {
//    roleIndex를 받아와서 ReviewBox에 넣어주시면 됩니다
    
    var body: some View {
        ScrollView(showsIndicators: false) {
                TitleBox(description: "무새가 무새에게")
                    .padding(.bottom, 28)
                VStack(alignment: .leading, spacing: 0) {
                    ReviewBox(user: "우기", role: "진행무새", review: "최고에요", roleIndex: 0)
                    ReviewBox(user: "유니스", role: "기록무새", review: "oo해서 회의에 도움이 되었어요!", roleIndex: 1)
                    ReviewBox(user: "닉", role: "타임무새", review: "oo해서 회의에 도움이 되었어요!", roleIndex: 2)
                    ReviewBox(user: "코지", role: "진행무새", review: "코지 코자", roleIndex: 3)
                    ReviewBox(user: "코지", role: "진행무새", review: "코지마 코지마 안마의자 코지마", roleIndex: 3)
                    ReviewBox(user: "코지", role: "진행무새", review: "매번 늦어도 이해할게", roleIndex: 3)
                    ReviewBox(user: "코지", role: "진행무새", review: "그대 기억이 지난 사랑이", roleIndex: 3)
                    SelectBox(isDark: true, description: "나가기")
                        .padding(.top)
                    Spacer()
                }
        }
    }
}

struct ReviewShowingView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewShowingView()
    }
}
