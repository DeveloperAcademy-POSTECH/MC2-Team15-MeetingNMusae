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
    enum CodingKeys: String, CodingKey {
        case content
        case from
        case to
        case roomCode = "room_code"
    }
    init(content: String, from: String, to: String, roomCode: String) {
        self.content = content
        self.from = from
        self.to = to
        self.roomCode = roomCode
    }
}
