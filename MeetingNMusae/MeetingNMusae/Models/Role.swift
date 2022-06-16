//
//  Role.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/09.
//

import Foundation

class Role: Identifiable {
    var id: Int
    let roleName: String
    let description: String
    let recommendation: String

    init(id: Int, roleName: String, description: String, recommendation: String) {
        self.id = id
        self.roleName = roleName
        self.description = description
        self.recommendation = recommendation
    }
}

extension Role {
    static let roles: [Role] = [
        Role(
            id: 1,
            roleName: "진행무새",
            description: "• 진행자가 되면 전체적인 회의 진행을 이끕니다.\n• 회의 안건, 주제, 목표를 소개합니다.\n• 안건 별로 중요도에 따라 목표 시간을 설정합니다.", recommendation: "• 자기가 추구하는 진행 방식이 뚜렷하게 있는 사람!\n• 다른 사람이 말할 때 홀린 듯 빠져들지 않고\n  중심을 잘 잡는 사람!\n• 나온 의견들을 잘 종합할 수 있는 능력이 있는 사람!\n• 진행병이 있는 사람\n• 레크레이션을 진행해본 적이 있는 사람"),
        Role(id: 2, roleName: "기록무새", description: "", recommendation: ""),
        Role(id: 3, roleName: "타임무새", description: "", recommendation: ""),
        Role(id: 4, roleName: "주제무새", description: "", recommendation: ""),
        Role(id: 5, roleName: "이해무새", description: "", recommendation: ""),
        Role(id: 6, roleName: "왜??무새", description: "", recommendation: ""),
        Role(id: 7, roleName: "삐딱무새", description: "", recommendation: ""),
        Role(id: 8, roleName: "좋아무새", description: "", recommendation: ""),
        Role(id: 9, roleName: "발언권무새", description: "", recommendation: ""),
        Role(id: 10, roleName: "금고무새", description: "", recommendation: "")
    ]
}
