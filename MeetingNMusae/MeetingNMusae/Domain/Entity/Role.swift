//
//  Role.swift
//  MeetingNMusaeRebuild
//
//  Created by JiwKang on 2023/03/11.
//

import Foundation

struct Role {
    let id: Int
    let roleName: String
    let description: String
    let recommendation: String
    let mission: [Mission]
}

extension Role: Hashable {
    static func == (lhs: Role, rhs: Role) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct RoleDTO {
    let id: Int
    let roleName: String
    
    // ...
}
