//
//  Mission.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/10.
//
import FirebaseFirestoreSwift

class Mission: Codable {
    /*private*/ var content: String
    private var id: Int
    private var roleId: Int

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
    
    func getMission() -> String {
        
        return content
    }
}
