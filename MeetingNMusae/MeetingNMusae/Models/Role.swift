//
//  Role.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/09.
//

import Foundation
import SwiftUI

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
            description: "진행무새가 되면 전체적인 회의 진행을 이끕니다.\n회의 안건, 주제, 목표를 소개합니다.\n안건 별로 중요도에 따라 목표 시간을 설정합니다.",
            recommendation: "자기가 추구하는 진행 방식이 뚜렷하게 있는 사람\n나온 의견들을 잘 종합할 수 있는 능력이 있는 사람\n진행병이 있는 사람"),
        Role(
            id: 2,
            roleName: "기록무새",
            description: "기록무새가 되면 회의의 진행 과정을 기록합니다.\n회의 내용을 요약하여 기록합니다.",
            recommendation: "평소 정리하는 것을 좋아하거나 잘 하는 사람\n메모하면서 회의에 활발하게 참여 가능한 멀티태스커\n회의 내용의 key point를 잘 캐치해낼 수 있는 사람"),
        Role(
            id: 3,
            roleName: "타임무새",
            description: "타임무새가 되면 진행자가 설정한 타임라인에 따라 시간을 관리합니다.\n타임라인으로 설정한 시간이 마감되기 10분 전 잔여 시간을 알려줍니다.\n집중도가 떨어졌다고 생각될 때는 쉬는 시간을 부여합니다.",
            recommendation: "시계를 폼으로 차고 다니지 않는 사람\n약속 시간에 늦어본 적이 없는 사람\n좌우명이 ‘시간은 금이다'인 사람"),
        Role(
            id: 4,
            roleName: "발언권무새",
            description: "발언권무새가 되면 회의 참여자의 모두의 발언시간을 지켜줍니다.\n자꾸 말이 잘리는 사람이 있다면 끝까지 말할 수 있도록 도와줍니다.",
            recommendation: "한 사람이 말을 너무 많이 하는 회의를 경험해본 사람\n모두의 의견을 공평하게 들어보고 싶은 사람\n상대방의 말을 끊는 게 불편하지 않은 사람"),
        Role(
            id: 5,
            roleName: "금고무새",
            description: "금고무새가 되면 회의의 현재 주제에서는 벗어났지만 후에 도움이 될 아이디어와 주제를 따로 기록해 주제를 원래대로 돌리고, 이후 필요한 부분에서 참고할 수 있게 합니다.",
            recommendation: "회의에서 벗어난 주제지만 도움이 될만한 내용이 마음에 걸리는 사람\n이전에 나왔던 내용이 이후에 도움이 될 것 같다는 느낌을 겪어본 사람"),
        Role(
            id: 6,
            roleName: "왜??무새",
            description: "왜??무새가 되면 회의 중 물음표를 던집니다.\n아이디어에 대해 더 넓고 깊은 생각을 할 수 있도록 도와줍니다.",
            recommendation: "한가지 주제에 대해 깊고 넓은 질문을 할 수 있는 사람\n창의력을 이용해 많은 질문을 할 수 있는 사람"),
        Role(
            id: 7,
            roleName: "좋아무새",
            description: "좋아무새가 되면 칭찬과 긍정적인 반응으로 말하기 편한 회의 분위기를 만들어줍니다.",
            recommendation: "리액션 하는 것이 즐거운 사람\n회의 참여자들을 격려해주고싶은 사람"),
        Role(
            id: 8,
            roleName: "주제무새",
            description: "주제무새가 되면 진행자의 역할을 보조합니다.\n회의가 산으로 갈 때 주제를 다시 말해줍니다.\n지금 안건의 목적에 대해서 알려줍니다.",
            recommendation: "말을 하다가 중간에 길을 잃지 않는 사람\n논리적인 흐름을 이해할 수 있는 사람"),
        Role(
            id: 9,
            roleName: "이해무새",
            description: "이해무새가 되면 참여자들의 이해를 확인합니다.\n참여자들의 이해를 위해 정리하여 말해줍니다.",
            recommendation: "눈치가 빠른 사람\n주변 상황을 잘 읽는 사람\n대화의 흐름을 잘 이해하는 사람"),
        Role(
            id: 10,
            roleName: "삐딱무새",
            description: "삐딱무새가 되면 다수의 의견에 이의를 제기합니다.\n타인의 주장에 반대되는 관점을 고려합니다.",
            recommendation: "반골기질이 있는 사람\n역할의 힘을 빌려 반대의견을 내고 싶은 사람\n반대 관점을 잘 떠올리는 사람")
    ]
    
    // id 시작을 어떻게 할지 (0인지 1인지) 확인 필요
    // swiftlint:disable cyclomatic_complexity
    static func getRoleColor(roleId: Int) -> Color {
        switch roleId {
        case 1: return .musaeBlue
        case 2: return .musaeOrange
        case 3: return .musaeMint
        case 4: return .musaeRed
        case 5: return .musaeMustard
        case 6: return .musaePurple
        case 7: return .musaePink
        case 8: return .musaeGreen
        case 9: return .musaeLightGreen
        case 10: return .musaeSkyBlue
        default: return .black
        }
    }
    // swiftlint:enable cyclomatic_complexity
    
    static func getRoleName(roleId: Int) -> String {
        if (roleId > 0) && (roleId <= 10) {
            return self.roles[roleId-1].roleName
        } else {
            return "no role"
        }
    }
}
