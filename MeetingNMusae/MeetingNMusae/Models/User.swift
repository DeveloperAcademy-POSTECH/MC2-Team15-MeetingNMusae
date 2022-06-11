//
//  User.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/09.
//

import Foundation

class User: Codable, Identifiable {
    var isReady: Bool
    let missionIds: [Int]
    var missionProgress: [Bool]
    let nickname: String
    let roleId: Int
    let roomCode: String

    enum CodingKeys: String, CodingKey {
        case isReady = "is_ready"
        case missionIds = "mission_ids"
        case missionProgress = "mission_progress"
        case nickname
        case roleId = "role_id"
        case roomCode = "room_code"
    }

    init(missionIds: [Int], missionProgress: [Bool], nickname: String, roleId: Int, roomCode: String) {
        self.isReady = false
        self.missionIds = missionIds
        self.missionProgress = [false, false, false]
        self.nickname = nickname
        self.roleId = roleId
        self.roomCode = roomCode
    }
}
