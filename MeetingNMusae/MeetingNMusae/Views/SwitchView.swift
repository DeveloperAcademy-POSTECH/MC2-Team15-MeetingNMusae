//
//  SwitchView.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/17.
//

import SwiftUI

struct SwitchView: View {
    @State var remainTime = 2
    
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
                    RoleSelectView()
                } else if meetingRoom.isRoleSelectCompleted {
                    // 회의 진행 화면으로 전환
                    VStack {
                        Text("회의 진행중")
                        
                        if isOwner {
                            Button(action: {
                                meetingRoomViewModel.endMeeting(roomCode: roomCode)
                            }, label: {
                                Text("회의 종료")
                            })
                        }
                    }
                } else if meetingRoom.isEnded {
                    if remainTime != 0 {
                        MeetingEndingView().task(timer)
                    } else {
                        BestPlayerSelectView()
                    }
                } else if meetingRoom.isBestRoleSelected {
                    BestPlayerShowingView(roomCode: roomCode)
                        .navigationBarHidden(true)
                } else if meetingRoom.isReviewStarted {
                    ReviewShowingView(roomCode: roomCode)
                        .navigationBarHidden(true)
                } else {
                    PlayerListView(roomCode: roomCode, isOwner: isOwner)
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    func timer() async {
        while remainTime > 0 {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            remainTime -= 1
        }
    }
}
