//
//  User.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/09.
//
import FirebaseFirestoreSwift
import Foundation

class User: Codable, Identifiable, Comparable {
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
    
    // users: [User] 어레이를 userID에 따라 sort() 하기 위해 추가 (프로토콜 Comparable)
    // ref: https://babbab2.tistory.com/150
    static func < (lhs: User, rhs: User) -> Bool {
        return lhs.roleId < rhs.roleId
    }
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.roleId == rhs.roleId
    }
    
    func getMissionProgress() -> Double {
        var progress: Double = 0
        for didMission in missionProgress where didMission {
            progress += 1
        }
        // 미션 수 달라지면 Double(missionProgress.count)로 나누기
        return progress/3.0
    }
}
