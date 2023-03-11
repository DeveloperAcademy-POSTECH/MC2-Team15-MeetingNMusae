//
//  VoteUseCase.swift
//  MeetingNMusaeRebuild
//
//  Created by JiwKang on 2023/03/11.
//

import Foundation

protocol Vote {
    func execute(user: User) async -> UserError?
}

struct VoteUseCase: Vote {
    var repo: UserRepository!
    
    func execute(user: User) async -> UserError? {
        do {
            try await repo.vote(user: user)
        } catch {
            return .voteFail
        }
        return nil
    }
}
