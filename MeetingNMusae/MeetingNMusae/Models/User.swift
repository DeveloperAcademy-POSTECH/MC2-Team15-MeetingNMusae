//
//  User.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/09.
//
import FirebaseFirestoreSwift
import Foundation

class User: Codable, Identifiable {
    var isReady: Bool
    let missionIds: [Int]
    var missionProgress: [Bool]
    var roleId: Int
    let roomCode: String
    var nickname: String
    var votedCount: Int
    var reviewee: String

    enum CodingKeys: String, CodingKey {
        case isReady = "is_ready"
        case missionIds = "mission_ids"
        case missionProgress = "mission_progress"
        case roleId = "role_id"
        case roomCode = "room_code"
        case nickname
        case votedCount = "voted_count"
        case reviewee
    }

    init(missionIds: [Int], nickname: String, roomCode: String) {
        self.isReady = false
        self.missionIds = missionIds
        self.missionProgress = [false, false, false]
        self.nickname = nickname
        self.roleId = 0
        self.roomCode = roomCode
        self.votedCount = 0
        self.reviewee = ""
    }
}
