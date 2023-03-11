//
//  GetBestMusaeUseCase.swift
//  MeetingNMusaeRebuild
//
//  Created by JiwKang on 2023/03/11.
//

import Foundation

protocol GetBestMusae {
    func execute() async -> Result<User, MeetingRoomUseCaseError>
}

struct GetBestMusaeUseCase: GetBestMusae {
    var repo: MeetingRoomRepository!
    
    func execute() async -> Result<User, MeetingRoomUseCaseError> {    
        do {
            let bestMusae = try await repo.getBestMusae()
            return .success(bestMusae)
        } catch {
            return .failure(.getBestMusaeFail)
        }
    }
}
