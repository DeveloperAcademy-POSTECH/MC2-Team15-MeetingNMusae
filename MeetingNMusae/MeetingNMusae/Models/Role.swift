//
//  Role.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/09.
//
import FirebaseFirestoreSwift
import Foundation

class Role: Codable, Identifiable {
    var id: Int
    let roleName: String

    enum CodingKeys: String, CodingKey {
        case id
        case roleName = "role_name"
    }

    init(id: Int, roleName: String) {
        self.id = id
        self.roleName = roleName
    }
}

extension Role {
    static let roles: [Role] = [
        Role(id: 1, roleName: "진행무새"),
        Role(id: 2, roleName: "기록무새"),
        Role(id: 3, roleName: "타임무새"),
        Role(id: 4, roleName: "주제무새"),
        Role(id: 5, roleName: "이해무새"),
        Role(id: 6, roleName: "왜??무새"),
        Role(id: 7, roleName: "삐딱무새"),
        Role(id: 8, roleName: "좋아무새"),
        Role(id: 9, roleName: "발언권무새"),
        Role(id: 10, roleName: "금고무새")
    ]
}
