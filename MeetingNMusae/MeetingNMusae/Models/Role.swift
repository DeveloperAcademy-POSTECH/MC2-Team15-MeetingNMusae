//
//  Role.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/09.
//

import Foundation

class Role: Identifiable {
    var id: Int
    var roleName: String
    var isSelected: Bool
    
    init(id: Int, roleName: String) {
        self.id = id
        self.roleName = roleName
        self.isSelected = false
    }
}
