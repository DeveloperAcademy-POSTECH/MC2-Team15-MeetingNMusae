//
//  AttendMeetingUseCase.swift
//  MeetingNMusaeRebuild
//
//  Created by JiwKang on 2023/03/11.
//

import Foundation

protocol AttendMeeting {
    func execute(roomCode: String) async -> UserError?
}

struct AttendMeetingUseCase: AttendMeeting {
    var repo: UserRepository!
    
    func execute(roomCode: String) async -> UserError? {
        do {
            try await repo.attendMeeting(roomCode: roomCode)
        } catch {
            return .attendMeetingRoomFail
        }
        return nil
    }
}
