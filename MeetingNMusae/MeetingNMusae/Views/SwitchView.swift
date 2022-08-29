//
//  SwitchView.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/17.
//

import SwiftUI

struct SwitchView: View {
    @State var isRootActive: Binding<Bool>
    @State var remainTime = 2
    
    @State var roomCode: String
    @State var isOwner: Bool
    @State var isReviewFinished: Bool = false
    @ObservedObject var meetingRoomViewModel = MeetingRoomViewModel()
    
    init(roomCode: String, isOwner: Bool, isRootActive: Binding<Bool>) {
        self.roomCode = roomCode
        self.isOwner = isOwner
        self.isRootActive = isRootActive
        meetingRoomViewModel.fetchData(roomCode: roomCode)
    }
    
    var body: some View {
        NavigationView {
            ForEach(meetingRoomViewModel.meetingRooms) { meetingRoom in
                if meetingRoom.isStarted {
                    RoleSelectView()
                } else if meetingRoom.isRoleSelectCompleted {
                    // 회의 진행 화면으로 전환
                    MissionView()
                        .navigationBarHidden(true)
                } else if meetingRoom.isEnded {
                    if remainTime != 0 {
                        MeetingEndingView().task(timer)
                    } else {
                        BestPlayerSelectView()
                            .navigationBarHidden(true)
                    }
                } else if meetingRoom.isBestRoleSelected {
                    BestPlayerShowingView(roomCode: roomCode)
                        .navigationBarHidden(true)
                } else if meetingRoom.isReviewStarted {
                    if isReviewFinished {
                        ReviewShowingView(roomCode: roomCode, isRootActive: isRootActive)
                            .navigationBarHidden(true)
                    } else {
                        ReviewWritingView(roomCode: roomCode, isReviewFinished: $isReviewFinished)
                            .navigationBarHidden(true)
                    }
                } else {
                    PlayerListView(roomCode: roomCode, isOwner: isOwner)
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    @Sendable private func timer() async {
        while remainTime > 0 {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            remainTime -= 1
        }
    }
}
