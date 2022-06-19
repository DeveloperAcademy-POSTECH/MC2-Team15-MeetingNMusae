//
//  Review.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/10.
//
import FirebaseFirestoreSwift

class Review: Codable {
    private var content: String
    private var from: String
    private var to: String
    private var roomCode: String
    var revieweeRoleId: Int

    enum CodingKeys: String, CodingKey {
        case content
        case from
        case to
        case roomCode = "room_code"
        case revieweeRoleId = "reviewee_role_id"
    }

    init(content: String, from: String, to: String, roomCode: String, revieweeRoleId: Int) {
        self.content = content
        self.from = from
        self.to = to
        self.roomCode = roomCode
        self.revieweeRoleId = revieweeRoleId
    }
}
