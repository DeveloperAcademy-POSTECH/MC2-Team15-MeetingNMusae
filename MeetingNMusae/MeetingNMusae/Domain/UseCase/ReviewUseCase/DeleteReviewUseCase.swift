//
//  DeleteReviewUseCase.swift
//  MeetingNMusaeRebuild
//
//  Created by JiwKang on 2023/03/11.
//

import Foundation

protocol DeleteAllReview {
    func execute() async -> ReviewError?
}

struct DeleteReviewAllUseCase: DeleteAllReview {
    var repo: ReviewRepository!
    
    func execute() async -> ReviewError? {
        do {
            try await repo.deleteAllReview()
        } catch {
            return .deleteFail
        }
        return nil
    }
}
