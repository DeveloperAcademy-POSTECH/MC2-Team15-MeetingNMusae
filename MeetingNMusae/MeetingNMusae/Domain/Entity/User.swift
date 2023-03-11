//
//  User.swift
//  MeetingNMusaeRebuild
//
//  Created by JiwKang on 2023/03/11.
//

import Foundation

struct User {
    let isOnwer: Bool
    let MissionProgress: [Bool]
    let role: Role?
    let roomCode: String
    let nickname: String
    let reviewee: String // <- User로 하고싶음...
}
