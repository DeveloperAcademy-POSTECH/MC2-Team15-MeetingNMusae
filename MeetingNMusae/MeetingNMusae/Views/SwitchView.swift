//
//  SwitchView.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/17.
//

import SwiftUI

struct SwitchView: View {
    
    @State var roomCode: String
    @State var isOwner: Bool
    @ObservedObject var meetingRoomViewModel = MeetingRoomViewModel()
    
    init(roomCode: String, isOwner: Bool) {
        self.roomCode = roomCode
        self.isOwner = isOwner
        meetingRoomViewModel.fetchData(roomCode: roomCode)
    }
    
    var body: some View {
        NavigationView {
            ForEach(meetingRoomViewModel.meetingRooms) { meetingRoom in
                if meetingRoom.isStarted {
                    // 역할 선택 화면으로 전환
                    RoleSelectView()
                } else if meetingRoom.isRoleSelectCompleted {
                    // 회의 진행 화면으로 전환
                    
                } else if meetingRoom.isEnded {
                    // 회의 종료 화면으로 전환
                } else {
                    // 모두 아닌 경우 회의 대기실 화면으로 전환
                    PlayerListView(roomCode: roomCode, isOwner: isOwner)
                }
            }
        }
        .navigationBarHidden(true)
    }
}
