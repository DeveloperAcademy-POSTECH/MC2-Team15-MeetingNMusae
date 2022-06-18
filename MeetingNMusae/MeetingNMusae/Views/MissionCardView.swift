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
//    @State var missions: [String] = []
//    @State var progress: [Bool] = userViewModel.user?.missionProgress ?? [false, false,false]
    let roomCode = UserDefaults.standard.string(forKey: "roomCode") ?? ""
    let nickname = UserDefaults.standard.string(forKey: "nickname") ?? ""
    let roleId = UserDefaults.standard.integer(forKey: "roleId")
    
    var body: some View {
        let roleName: String = Role.getRoleName(roleId: roleId)
        let imageName: String = roleName
        VStack {
//            let roleId = userViewModel.user?.roleId ?? 0
            // var progress = userViewModel.user?.missionProgress ?? [false, false, false]
            //missions = missionViewModel.getMissionsStr()

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
                .padding(16)
            
            // 아래부분 회색 넣기는 나중에..? checkbox에 foreground로 하거나 clipped로 될까?
            
            HStack {
                Text("**미션**") // add font later
//                .font(.title).extraBold() // 이런 류는 나중에 시간 있으면
                    .font(.system(size: 18, weight: .bold)) // MARK: here (extrabold 여야함)

                Spacer()
            }
            .padding(.vertical, 12.735)
            .padding(.horizontal)
            
            // MARK: 따로 뷰로 빼서 CheckBoxView와 옆에 텍스트 같이 두자
            ForEach(0...2, id: \.self) { ind in
                HStack {
                    CheckBoxView(missionId: ind, progress: userViewModel.user?.missionProgress ?? [false, false, false], roleId: roleId)

                    Text((self.missionViewModel.missionStrs.count > ind) ? self.missionViewModel.missionStrs[ind] : "mcnt: \(self.missionViewModel.missionStrs.count)")
//                .font(.title3).medium() // 이런 류는 나중에 시간 있으면
                        .font(.system(size: 16, weight: .medium))
                    Spacer()
                }
                .padding(.vertical, 6.105)
                .padding(.horizontal)

            }
        }
//        .onAppear {
//            self.userViewModel.fetchData(roomCode: roomCode, nickname: nickname)
//            self.missionViewModel.fetchMissions(roleId: roleId)
//        }
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

// ref: https://stackoverflow.com/questions/58425829/how-can-i-create-a-text-with-checkbox-in-swiftui
struct CheckBoxView: View {
    let missionId: Int
    @State var progress: [Bool]
    let roleId: Int
//    let missionViewModel = MissionViewModel()
    let userViewModel = UserViewModel()

    let roomCode = UserDefaults.standard.string(forKey: "roomCode") ?? ""
    let nickname = UserDefaults.standard.string(forKey: "nickname") ?? ""

    var body: some View {
        Text("\(Image(systemName: progress[missionId] ? "checkmark.square.fill" : "square"))")
            .bold()
            .foregroundColor(Color(UIColor.black))
            .onTapGesture {
                progress[missionId].toggle()
                // MARK: 파이어베이스 update 하기
                // missionViewModel.fetchData(roleId: roleId)
                userViewModel.updateMissionProgress(roomCode: roomCode, missionId: missionId, nickname: nickname)
            }
    }
}

// struct MissionCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        MissionCardView(roleId: 1)
//    }
// }
