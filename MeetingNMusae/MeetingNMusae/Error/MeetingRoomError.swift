//
//  MeetingRoomError.swift
//  MeetingNMusaeRebuild
//
//  Created by JiwKang on 2023/03/11.
//

import Foundation

enum MeetingRoomUseCaseError: Error {
    case createRoomSuccess
    case createRoomFail
    
    case startSuccess
    case startFail
    
    case endSuccess
    case endFail
    
    case countUserSuccess
    case countUserFail
    
    case deleteRoomSuccess
    case deleteRoomFail
    
    case checkExistRoomSuccess
    case checkExistRoomFail
    
    case checkExistNicknameSuccess
    case checkExistNicknameFail
    
    case getBestMusaeSuccess
    case getBestMusaeFail
}
