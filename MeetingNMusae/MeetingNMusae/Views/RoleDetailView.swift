//
//  EmptyView.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/10.
//

// todo
// 선택 및 취소 기능만 구현된 상태

import SwiftUI

struct RoleDetailView: View {
    @State var role: Role
    @State var roomCode = UserDefaults.standard.string(forKey: "roomCode") ?? ""
    @State var nickname = UserDefaults.standard.string(forKey: "nickname") ?? ""
    @Binding var isModalShown: Bool
    @ObservedObject var meetingRoomViewModel = MeetingRoomViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Image("\(role.roleName)").resizable().scaledToFit()

                Button {
                    meetingRoomViewModel.updateRoleSelectUser(roomCode: roomCode, roleId: role.id, nickname: nickname, isSelect: true)
                    isModalShown = false
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20).foregroundColor(.black)
                        Text("선택하기").foregroundColor(.white)
                    }
                }.padding()

                Button {
                    meetingRoomViewModel.updateRoleSelectUser(roomCode: roomCode, roleId: role.id, nickname: nickname, isSelect: false)
                    isModalShown = false
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20).foregroundColor(.black)
                        Text("선택취소").foregroundColor(.white)
                    }
                }.padding()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        // todo
                        // 방 선택뷰로 이동하는 기능
                    }, label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right").rotationEffect(.degrees(180))
                    })
                    .foregroundColor(.black)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    
                }
            }
        }
        .navigationTitle("\(role.roleName)")
        .navigationBarTitleDisplayMode(.inline)
    }
}
