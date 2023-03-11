//
//  ReviewRepository.swift
//  MeetingNMusaeRebuild
//
//  Created by JiwKang on 2023/03/11.
//

import Foundation

protocol ReviewRepository {
    func fetch() async throws -> [Review]
    func deleteAllReview() async throws
}
