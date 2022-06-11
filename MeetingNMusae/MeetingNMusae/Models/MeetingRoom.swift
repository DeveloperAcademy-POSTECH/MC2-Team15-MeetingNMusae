//
//  MeetingRoom.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/10.
//
import FirebaseFirestoreSwift

class MeetingRoom: Codable, Identifiable {
    private var roomCode: String
    private var isRoleSelected: [Bool]
    private var participantCount: Int
    private var readyCount: Int
    
    enum CodingKeys: String, CodingKey {
        case roomCode = "room_code"
        case isRoleSelected = "is_role_selected"
        case participantCount = "participant_conut"
        case readyCount = "ready_count"
    }
    
    init(roomCode: String, isRoleSelected: [Bool], participantCount: Int, readyCount: Int) {
        self.roomCode = roomCode
        self.isRoleSelected = isRoleSelected
        self.participantCount = participantCount
        self.readyCount = readyCount
    }
    
    func getIsSelected(index: Int) -> Bool {
        return self.isRoleSelected[index]
    }
}
