//
//  SetNicknameUseCase.swift
//  MeetingNMusaeRebuild
//
//  Created by JiwKang on 2023/03/11.
//

import Foundation

protocol SetNickname {
    func execute(nickname: String) async -> UserError?
}

struct SetNicknameUseCase: SetNickname {
    var repo: UserRepository!
    
    func execute(nickname: String) async -> UserError? {
        do {
            try await repo.setNickname(nickname: nickname)
        } catch {
            return .setNicknameFail
        }
        return nil
    }
}
