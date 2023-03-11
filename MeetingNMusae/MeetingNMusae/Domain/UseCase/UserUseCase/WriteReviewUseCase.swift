//
//  WriteReviewUseCase.swift
//  MeetingNMusaeRebuild
//
//  Created by JiwKang on 2023/03/11.
//

import Foundation

protocol WriteReview {
    func execute(review: Review) async -> UserError?
}

struct WriteReviewUseCase: WriteReview {
    var repo: UserRepository!
    
    func execute(review: Review) async -> UserError? {
        do {
            try await repo.writeReview(review: review)
        } catch {
            return .writeReviewFail
        }
        return nil
    }
}
