//
//  CreateUserUseCase.swift
//  MeetingNMusaeRebuild
//
//  Created by JiwKang on 2023/03/11.
//

import Foundation

protocol CreateUser {
    func execute() async -> UserError?
}

struct CreateUserUseCase: CreateUser {
    var repo: UserRepository!
    
    func execute() async -> UserError? {
        do {
            try await repo.createUser()
        } catch {
            return .createFail
        }
        return nil
    }
}
