//
//  MeetingRoom.swift
//  MeetingNMusaeRebuild
//
//  Created by JiwKang on 2023/03/11.
//

import Foundation

enum RoomStep {
    case isStarted
    case isEnded
    case isRoleSelectCompleted
    case isBestRolSelected
    case isReviewStarted
}

struct MeetingRoom {
    let roomCode: String
    let rolesAssign: [Role: User?]
    let roomStep: RoomStep
}
