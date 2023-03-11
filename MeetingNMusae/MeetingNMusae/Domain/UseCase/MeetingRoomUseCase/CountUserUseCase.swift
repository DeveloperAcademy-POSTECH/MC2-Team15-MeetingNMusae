//
//  CountUserUseCase.swift
//  MeetingNMusaeRebuild
//
//  Created by JiwKang on 2023/03/11.
//

import Foundation

protocol CountUser {
    func execute() async -> Result<Int, MeetingRoomUseCaseError>
}

struct CountUserUseCase: CountUser {
    var repo: MeetingRoomRepository!
    
    func execute() async -> Result<Int, MeetingRoomUseCaseError> {
        do {
            let count = try await repo.countUser()
            return .success(count)
        } catch {
            return .failure(.countUserFail)
        }
    }
}
