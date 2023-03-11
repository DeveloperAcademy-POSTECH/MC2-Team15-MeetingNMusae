//
//  UserError.swift
//  MeetingNMusaeRebuild
//
//  Created by JiwKang on 2023/03/11.
//

import Foundation

enum UserError: Error {
    case createSuccess
    case createFail
    
    case selectRoleSuccess
    case selectRoleFail
    
    case voteSuccess
    case voteFail
    
    case setNicknameSuccess
    case setNicknameFail
    
    case attendMeetingRoomSuccess
    case attendMeetingRoomFail
    
    case missionCompleteSuccess
    case missionCompleteFail
    
    case writeReviewSuccess
    case writeReviewFail
}
