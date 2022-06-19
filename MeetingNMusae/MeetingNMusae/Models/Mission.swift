//
//  Mission.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/10.
//
import FirebaseFirestoreSwift

class Mission: Codable, Comparable {
    /*private*/ var content: String
    var id: Int
    var roleId: Int

    enum CodingKeys: String, CodingKey {
        case content
        case id
        case roleId = "role_id"
    }

    init(id: Int, content: String, roleId: Int) {
        self.id = id
        self.content = content
        self.roleId = roleId
    }
    
    // 미션 정렬을 위해 Comparable 프로토콜 사용
    static func < (lhs: Mission, rhs: Mission) -> Bool {
        return lhs.id < rhs.id
    }
    static func == (lhs: Mission, rhs: Mission) -> Bool {
        return lhs.id == rhs.id
    }
    
    func getMission() -> String {
        return content
    }
}
