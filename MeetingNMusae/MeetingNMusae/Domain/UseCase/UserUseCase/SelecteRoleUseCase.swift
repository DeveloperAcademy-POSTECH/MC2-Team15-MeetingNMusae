//
//  SelecteRoleUseCase.swift
//  MeetingNMusaeRebuild
//
//  Created by JiwKang on 2023/03/11.
//

import Foundation

protocol SelectRole {
    func execute(role: Role) async -> UserError?
}

struct SelectRoleUseCase: SelectRole {
    var repo: UserRepository!
    
    func execute(role: Role) async -> UserError? {
        do {
            try await repo.selectRole(role: role)
        } catch {
            return .selectRoleFail
        }
        return nil
    }
}
