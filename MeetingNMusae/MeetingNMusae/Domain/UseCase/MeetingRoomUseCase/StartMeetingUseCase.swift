//
//  StartMeetingUseCase.swift
//  MeetingNMusaeRebuild
//
//  Created by JiwKang on 2023/03/11.
//

import Foundation

protocol StartMeeting {
    func execute() async -> MeetingRoomUseCaseError?
}

struct StartMeetingUseCase: StartMeeting {
    var repo: MeetingRoomRepository!
    
    func execute() async -> MeetingRoomUseCaseError? {
        do {
            try await repo.startMeeting()
        } catch {
            return .startFail
        }
        return nil
    }
    
    
}
