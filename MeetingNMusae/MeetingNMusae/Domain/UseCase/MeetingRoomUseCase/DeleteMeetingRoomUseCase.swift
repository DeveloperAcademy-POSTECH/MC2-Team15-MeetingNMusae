//
//  DeleteMeetingRoomUseCase.swift
//  MeetingNMusaeRebuild
//
//  Created by JiwKang on 2023/03/11.
//

import Foundation

protocol DeleteMeetingRoom {
    func execute() async -> MeetingRoomUseCaseError?
}

struct DeleteMeetingRoomUseCase: DeleteMeetingRoom {
    var repo: MeetingRoomRepository!
    
    func execute() async -> MeetingRoomUseCaseError? {
        do {
            try await repo.deleteMeetingRoom()
        } catch {
            return .deleteRoomFail
        }
        return nil
    }
}
