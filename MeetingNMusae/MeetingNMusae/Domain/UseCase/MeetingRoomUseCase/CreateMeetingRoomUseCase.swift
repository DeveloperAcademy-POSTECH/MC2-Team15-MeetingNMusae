//
//  CreateMeetingRoomUseCase.swift
//  MeetingNMusaeRebuild
//
//  Created by JiwKang on 2023/03/11.
//

import Foundation

protocol CreateMeetingRoom {
    func execute() async -> MeetingRoomUseCaseError?
}

struct CreateMeetingRoomUseCase: CreateMeetingRoom {
    var repo: MeetingRoomRepository!
    
    func execute() async -> MeetingRoomUseCaseError? {
        do {
            try await repo.createMeetingRoom()
        } catch {
            return .createRoomFail
        }
        return nil
    }
}
