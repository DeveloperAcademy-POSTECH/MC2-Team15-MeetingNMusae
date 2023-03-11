//
//  EndMeetingUseCase.swift
//  MeetingNMusaeRebuild
//
//  Created by JiwKang on 2023/03/11.
//

import Foundation

protocol EndMeetingRoom {
    func execute() async -> MeetingRoomUseCaseError?
}

struct EndMeetingRoomUseCase: EndMeetingRoom {
    var repo: MeetingRoomRepository!
    
    func execute() async -> MeetingRoomUseCaseError? {
        do {
            try await repo.endMeeting()
        } catch {
            return .endFail
        }
        return nil
    }
}
