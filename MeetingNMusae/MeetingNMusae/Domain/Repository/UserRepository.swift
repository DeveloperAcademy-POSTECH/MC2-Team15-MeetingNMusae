//
//  UserRepository.swift
//  MeetingNMusaeRebuild
//
//  Created by JiwKang on 2023/03/11.
//

import Foundation

protocol UserRepository {
    func createUser() async throws
    func selectRole(role: Role) async throws
    func vote(user: User) async throws
    func setNickname(nickname: String) async throws
    func attendMeeting(roomCode: String) async throws
    func missionComplete(id: Int) async throws
    func writeReview(review: Review) async throws
}
