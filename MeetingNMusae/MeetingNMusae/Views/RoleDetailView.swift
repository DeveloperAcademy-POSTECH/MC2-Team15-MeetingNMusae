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
    @Binding var roleId: Int
    @State var roomCode = UserDefaults.standard.string(forKey: "roomCode") ?? ""
    @State var nickname = UserDefaults.standard.string(forKey: "nickname") ?? ""
    @Binding var isModalShown: Bool
    @ObservedObject var meetingRoomViewModel: MeetingRoomViewModel
    @ObservedObject var userViewModel = UserViewModel()
    private let horizontalPadding = UIScreen.screenWidth * 0.0718

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()
            VStack(spacing: 0) {
                Image("\(Role.roles[roleId].roleName)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.screenHeight * 0.237, height: UIScreen.screenHeight * 0.237)
                Text("\(Role.roles[roleId].roleName)")
                    .font(.title2)
                    .bold()
            }.alignmentGuide(.leading) { context in
                return -1 * ((UIScreen.screenWidth - context.width) / 2 - horizontalPadding)
            }
            Spacer()
            VStack(alignment: .leading, spacing: 6) {
                ForEach(Role.roles[roleId].description.components(separatedBy: "\n"), id: \.self) { sentence in
                    HStack(alignment: .top) {
                        Text("•")
                        Text("\(sentence)")
                            .font(.callout)
                            .lineSpacing(6.0)
                    }
                }
            }
            Spacer()
            Image("dotted_line")
            Spacer()
            Group {
                Text("이런 사람에게 추천해요!")
                    .font(.system(size: 18, weight: .bold))
                    .padding(.bottom, 20)
                VStack(alignment: .leading, spacing: 6) {
                    ForEach(Role.roles[roleId].recommendation.components(separatedBy: "\n"), id: \.self) { sentence in
                        HStack(alignment: .top) {
                            Text("•")
                            Text("\(sentence)")
                                .font(.callout)
                                .lineSpacing(6.0)
                        }
                    }
                }
            }
            Spacer()

            if meetingRoomViewModel.meetingRooms[0].roleSelectUsers[Role.roles[roleId].id - 1].isEmpty {
                Button {
                    UserDefaults.standard.set(Role.roles[roleId].id, forKey: "roleId")
                    userViewModel.updateUserRole(roomCode: roomCode, roleId: Role.roles[roleId].id, nickname: nickname, isSelect: true)
                    meetingRoomViewModel.updateRoleSelectUser(roomCode: roomCode, roleId: Role.roles[roleId].id, nickname: nickname, isSelect: true)
                    isModalShown = false
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12).foregroundColor(.black).frame(height: 64)
                        Text("선택하기").foregroundColor(.white).bold()
                    }
                }
                .padding(.bottom, UIDevice.hasSafeArea ? 42 : 28)
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 12).foregroundColor(.buttonGray).frame(height: 64)
                    Text("이미 선택된 역할입니다").foregroundColor(.white).bold()
                }
                .padding(.bottom, UIDevice.hasSafeArea ? 42 : 28)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    // todo
                    // 방 선택뷰로 이동하는 기능
                    isModalShown = false
                }, label: {
                    Image("btnclose").rotationEffect(.degrees(180))
                })
                .padding(.top, horizontalPadding)
                .foregroundColor(.black)
            }
        }
        .padding(.horizontal, horizontalPadding)
    }
}
