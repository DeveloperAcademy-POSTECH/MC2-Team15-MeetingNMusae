//
//  CheckExistUserNickname.swift
//  MeetingNMusaeRebuild
//
//  Created by JiwKang on 2023/03/11.
//

import Foundation

protocol CheckExistUser {
    func execute(nickname: String) async -> MeetingRoomUseCaseError?
}

struct CheckExistUserUseCase: CheckExistUser {
    var repo: MeetingRoomRepository!
    
    func execute(nickname: String) async -> MeetingRoomUseCaseError? {
        do {
            try await repo.checkExistNickname(nickname: nickname)
        } catch {
            return .checkExistRoomFail
        }
        return nil
    }
}
