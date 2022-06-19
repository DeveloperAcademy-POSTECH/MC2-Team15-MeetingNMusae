//
//  MeetingRoom.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/10.
//

import FirebaseFirestoreSwift
import Foundation

class MeetingRoom: Codable, Identifiable {
    var roomCode: String
    var roleSelectUsers: [String]
    var readyCount: Int
    var owner: String
    var isStarted: Bool
    var isEnded: Bool
    var isRoleSelectCompleted: Bool
    var isBestRoleSelected: Bool
    var isReviewStarted: Bool
    
    enum CodingKeys: String, CodingKey {
        case roomCode = "room_code"
        case roleSelectUsers = "role_select_users"
        case readyCount = "ready_count"
        case owner
        case isStarted = "is_started"
        case isEnded = "is_ended"
        case isRoleSelectCompleted = "is_role_select_completed"
        case isBestRoleSelected = "is_best_role_selected"
        case isReviewStarted = "is_review_started"
    }

    init(owner: String, roomCode: String) {
        self.roleSelectUsers = [String](repeating: "", count: 10)
        self.readyCount = 0
        self.owner = owner
        self.roomCode = roomCode
        self.isStarted = false
        self.isEnded = false
        self.isRoleSelectCompleted = false
        self.isBestRoleSelected = false
        self.isReviewStarted = false
    }
}
