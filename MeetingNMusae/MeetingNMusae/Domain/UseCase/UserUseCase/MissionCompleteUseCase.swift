//
//  MissionCompleteUseCase.swift
//  MeetingNMusaeRebuild
//
//  Created by JiwKang on 2023/03/11.
//

import Foundation

protocol MissionComplete {
    func execute(missionId: Int) async -> UserError?
}

struct MissionCompleteUseCase: MissionComplete {
    var repo: UserRepository!
    
    func execute(missionId: Int) async -> UserError? {
        do {
            try await repo.missionComplete(id: missionId)
        } catch {
            return .attendMeetingRoomFail
        }
        return nil
    }
}
