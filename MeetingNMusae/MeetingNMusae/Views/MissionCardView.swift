//
//  MissionCardView.swift
//  MeetingNMusae
//
//  Created by Hyorim Nam on 2022/06/15.
//

import SwiftUI

// 커스텀 init이 필요해서 다시 스트럭트로 교체
struct MissionCardView: View {
    // 서버에서 받을 데이터: 현재 역할, 미션, 미션 수행 했는지
    // 서버에 보낼 데이터: 미션 수행 했는지
    @ObservedObject var userViewModel = UserViewModel()
    @ObservedObject var missionViewModel = MissionViewModel()
    @State var isChanged = false
    @State var progress: [Bool] = [false, false,false]
    let roomCode = UserDefaults.standard.string(forKey: "roomCode") ?? ""
    let nickname = UserDefaults.standard.string(forKey: "nickname") ?? ""
    let roleId = UserDefaults.standard.integer(forKey: "roleId")
    
    var body: some View {
        let roleName: String = Role.getRoleName(roleId: roleId)
        let imageName: String = roleName
        VStack {
            // 추후 이미지 크기 조정 필요
            Image(imageName)
                .resizable()
                .scaledToFit()
            Text(roleName)
//                .font(.largeTitle).bold() // 이런 류는 나중에 시간 있으면
                .font(.system(size: 24, weight: .bold))
                .padding(20)

            // 코지의 라인 익스텐션 사용
            Line().stroke(style: StrokeStyle(lineWidth: 3, dash: [10]))
                .frame(height: 1)
                .padding(.vertical, 16)
            
            // 아래부분 회색 넣기는 나중에..? checkbox에 foreground로 하거나 clipped로 될까?
            
            HStack {
                Text("**미션**")
                    .font(.system(size: 18, weight: .bold)) // MARK: here (extrabold 여야함)

                Spacer()
            }
            .padding(.vertical, 12.735)
            .padding(.horizontal)
            
            // 따로 뷰로 빼서 CheckBoxView와 옆에 텍스트 같이 뒀더니 미션이 안 보여서 되돌림
            ForEach(0...2, id: \.self) { ind in
                HStack {
                    // MARK: 모르겠음: userViewModel.deviceUser?가 항상 nil이 나옴
                    Text("\(Image(systemName: progress[ind] ? "checkmark.square.fill" : "square"))")
                        .bold()
                        .foregroundColor(Color(UIColor.black))

                    Text((self.missionViewModel.missionStrs.count > ind) ? self.missionViewModel.missionStrs[ind] : "mcnt: \(self.missionViewModel.missionStrs.count)")
                        .font(.system(size: 16, weight: .medium))
                    Spacer()
                }
                .padding(.vertical, 6.1)
                .padding(.horizontal)
                .onTapGesture {
                    progress[ind].toggle()
                    // 파이어베이스 update
                    userViewModel.updateMissionProgress(roomCode: roomCode, missionId: ind, nickname: nickname)
                }
            }
        }
        .onAppear {
            self.missionViewModel.fetchMissions(roleId: roleId)
            progress = userViewModel.deviceUser?.missionProgress ?? [false, false, false]
        }
        .padding()
        .padding(.bottom)
        .background(
            CharacterBox(roleIndex: roleId)
            // 회색 넣는 용도
            // 추후 검색 해보자
//                .overlay(
//                    VStack {
//                        Color.white//.frame(height: UIScreen.screenHeight*0.5)
//                        Color.bgGray
//                    }
//                        .clipShape(RoundedRectangle(cornerRadius: 12))
//                )
        )
    }
}

 struct MissionCardView_Previews: PreviewProvider {
    static var previews: some View {
        MissionCardView()
    }
 }
