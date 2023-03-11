//
//  CheckExistRoomUseCase.swift
//  MeetingNMusaeRebuild
//
//  Created by JiwKang on 2023/03/11.
//

import Foundation

protocol CheckExistRoom {
    func execute(roomCode: String) async -> MeetingRoomUseCaseError?
}

struct CheckExistRoomUseCase: CheckExistRoom {
    var repo: MeetingRoomRepository!
    
    func execute(roomCode: String) async -> MeetingRoomUseCaseError? {
        do {
            try await repo.checkExistRoom(roomCode: roomCode)
        } catch {
            return .checkExistRoomFail
        }
        return nil
    }
}
