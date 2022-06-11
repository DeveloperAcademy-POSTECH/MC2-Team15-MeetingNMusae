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
