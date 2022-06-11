//
//  Mission.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/10.
//

class mission {
    private var content: String
    private var id: Int
    private var roleId: Int
    
    enum CodingKeys: String, CodingKey {
        case content
        case id
        case roloId = "role_id"
    }
    
    init(id: Int, content: String, roleId: Int) {
        self.id = id
        self.content = content
        self.roleId = roleId
    }
}
