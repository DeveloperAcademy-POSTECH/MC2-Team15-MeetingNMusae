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
    private var readyCount: Int
    private var owner: String
    var users: [String: User]
    enum CodingKeys: String, CodingKey {
        case roleSelectUsers = "role_select_users"
        case readyCount = "ready_count"
        case owner = "owner"
        case users = "users"
        case roomCode = "room_code"
    }
    init(owner: String, users: [String: User], roomCode: String) {
        self.roleSelectUsers = [String](repeating: "", count: 10)
        self.readyCount = 0
        self.owner = owner
        self.users = users
        self.roomCode = roomCode
    }
}
