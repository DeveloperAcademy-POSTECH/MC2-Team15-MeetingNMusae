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
    
    var missionViewModel = MissionViewModel()

    // roleId가 0 이상인지, 1에서 시작할 것ㅕㄴㄷㄱ 인지.. 파이어스토어에 0 있음
    var roleId: Int
    @State var didMissions: [Bool] // state 필요한가?

    var body: some View {
        let roleName: String =  Role.roles[roleId].roleName
        let imageName: String = roleName
        let _ = missionViewModel.fetchData(roleId: roleId)
        let missions: [String] = missionViewModel.getMissionsStr(roleId: roleId)

        VStack {
            // 추후 이미지 크기 조정 필요
            Image(imageName)
                .resizable()
                .scaledToFit()
            Text(roleName)

            // 코지의 라인 익스텐션 사용
            Line().stroke(style: StrokeStyle(lineWidth: 3, dash: [10]))
                .frame(height: 1)

            HStack {
                Text("**미션**") // add font later
                Spacer()
            }
            .padding()
            ForEach(0...2, id: \.self) { mission in
                HStack {
                    CheckBoxView(missionId: mission, checked: didMissions[mission], roleId: roleId)
                    // 컬러만 바껴도 온체인지 걸리나?
//                        .onChange{
//
//                    }
                    Text(missions[mission])
                    // 폰트 추가
                    Spacer()
                }
                    .padding()
            }
        }
        .onAppear{
            userViewModel.fetchData(roomCode: roomCode)
//            roleId = userViewModel.getUser(nickname)?.roleId ?? 0
            missionViewModel.fetchData(roleId: roleId)
            didMissions = userViewModel.getUser(nickname)?.missionProgress as? [Bool] ?? [false, false, false]
        }
        .padding()
        .padding(.bottom)
        .background(
            CharacterBox(roleIndex: roleId)
        )
    }
}

// ref: https://stackoverflow.com/questions/58425829/how-can-i-create-a-text-with-checkbox-in-swiftui
struct CheckBoxView: View {
//    @Binding var checked: Bool
    let missionId: Int
    var checked: Bool
    let roleId: Int
    @ObservedObject var missionViewModel = MissionViewModel()

    var body: some View {
        Image(systemName: checked ? "checkmark.square.fill" : "square")
            .foregroundColor(
                checked ? Color(UIColor.black) : Color.secondary)
            .onTapGesture {
                // MARK: 파이어베이스 update 하기
                missionViewModel.fetchData(roleId: roleId)
                missionViewModel.updateMissionProgress(missionId: missionId)
            }
    }
}

//struct MissionCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        MissionCardView()
//    }
//}
