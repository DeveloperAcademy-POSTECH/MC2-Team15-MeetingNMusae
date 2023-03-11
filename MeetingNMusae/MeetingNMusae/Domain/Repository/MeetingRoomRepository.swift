//
//  MeetingRoomRepository.swift
//  MeetingNMusaeRebuild
//
//  Created by JiwKang on 2023/03/11.
//

import Foundation

protocol MeetingRoomRepository {
    func createMeetingRoom() async throws
    func startMeeting() async throws
    func endMeeting() async throws
    func countUser() async throws -> Int
    func deleteMeetingRoom() async throws
    func checkExistRoom(roomCode: String) async throws
    func checkExistNickname(nickname: String) async throws
    func getBestMusae() async throws -> User
}
