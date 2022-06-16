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
    /*private */var owner: String

    enum CodingKeys: String, CodingKey {
        case roleSelectUsers = "role_select_users"
        case readyCount = "ready_count"
        case owner = "owner"
        case roomCode = "room_code"
    }

    init(owner: String, roomCode: String) {
        self.roleSelectUsers = [String](repeating: "", count: 10)
        self.readyCount = 0
        self.owner = owner
        self.roomCode = roomCode
    }
}
