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
    @ObservedObject var meetingRoomViewModel: MeetingRoomViewModel
    @ObservedObject var userViewModel = UserViewModel()

    var body: some View {
        VStack {
            VStack(alignment: .center) {
                ZStack {
                    VStack {
                        Image("\(role.roleName)").resizable().scaledToFit()
                        Spacer()
                    }
                    VStack {
                        Spacer()
                        Text("\(role.roleName)").font(.title2).bold()
                            .padding(.bottom)
                    }
                }
            }
            
            VStack(alignment: .leading) {
                Text("\(role.description)").font(.footnote).padding(.bottom)
                
                Line()
                    .stroke(style: StrokeStyle(lineWidth: 3, dash: [10]))
                    .frame(height: 1)
                    .padding(.top)
                    .padding(.bottom)
                
                Text("이런 사람에게 추천해요!").font(.headline).padding(.bottom)
                Text("\(role.recommendation)").font(.footnote)
                
                Spacer()
                
                Button {
                    UserDefaults.standard.set(role.id, forKey: "roleId")
                    meetingRoomViewModel.updateRoleSelectUser(roomCode: roomCode, roleId: role.id, nickname: nickname, isSelect: true)
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12).foregroundColor(.black).frame(height: 64)
                        Text("선택하기").foregroundColor(.white).bold()
                    }
                }.padding(.top)
            }
            .padding(.top)
            .frame(height: UIScreen.screenHeight / 2)
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    // todo
                    // 방 선택뷰로 이동하는 기능
                    meetingRoomViewModel.updateRoleSelectUser(roomCode: roomCode, roleId: role.id, nickname: nickname, isSelect: false)
                }, label: {
                    Image(systemName: "xmark").rotationEffect(.degrees(180))
                })
                .foregroundColor(.black)
            }
        }
        .padding(.leading)
        .padding(.trailing)
    }
}
