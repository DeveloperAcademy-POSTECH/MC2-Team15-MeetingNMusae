//
//  SwitchView.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/17.
//

import SwiftUI

struct SwitchView: View {
    @Binding var isRootActive: Bool
    @State var remainTime = 2
    
    @State var isModalShown: Bool = false
    @State var selectedRoleId: Int = 0
    
    @State var roomCode: String
    @State var isOwner: Bool
    @State var isReviewFinished: Bool = false
    @ObservedObject var meetingRoomViewModel = MeetingRoomViewModel()
    
    init(roomCode: String, isOwner: Bool, isRootActive: Binding<Bool>) {
        self.roomCode = roomCode
        self.isOwner = isOwner
        self._isRootActive = isRootActive
        meetingRoomViewModel.fetchData(roomCode: roomCode)
    }
    
    var body: some View {
        NavigationView {
            ForEach(meetingRoomViewModel.meetingRooms) { meetingRoom in
                if meetingRoom.isStarted {
                    RoleSelectView(selectedRoleId: $selectedRoleId, isModalShown: $isModalShown, meetingRoomViewModel: meetingRoomViewModel)
                } else if meetingRoom.isRoleSelectCompleted {
                    // 회의 진행 화면으로 전환
                    MissionView(meetingRoomViewModel: meetingRoomViewModel)
                        .navigationBarHidden(true)
                } else if meetingRoom.isEnded {
                    if remainTime != 0 {
                        MeetingEndingView().task(timer)
                    } else {
                        BestPlayerSelectView()
                            .navigationBarHidden(true)
                    }
                } else if meetingRoom.isBestRoleSelected {
                    BestPlayerShowingView(roomCode: roomCode, meetingRoomViewModel: meetingRoomViewModel)
                        .navigationBarHidden(true)
                } else if meetingRoom.isReviewStarted {
                    if isReviewFinished {
                        ReviewShowingView(roomCode: roomCode, isRootActive: $isRootActive)
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
        .sheet(isPresented: $isModalShown) {
            NavigationView {
                RoleDetailView(roleId: $selectedRoleId, isModalShown: $isModalShown, meetingRoomViewModel: meetingRoomViewModel)
                    .navigationBarHidden(false)
                    .ignoresSafeArea()
            }
        }
    }
    
    @Sendable private func timer() async {
        while remainTime > 0 {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            remainTime -= 1
        }
    }
}
