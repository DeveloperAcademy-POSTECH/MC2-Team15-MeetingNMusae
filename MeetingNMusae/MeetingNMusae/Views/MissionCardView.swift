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
//    @State var progress: [Bool] = userViewModel.user?.missionProgress ?? [false, false,false]
    let roleId: Int
    
    var body: some View {
        let roleName: String =  Role.roles[roleId].roleName
        let imageName: String = roleName
        VStack {
//            let roleId = userViewModel.user?.roleId ?? 0
            // var progress = userViewModel.user?.missionProgress ?? [false, false, false]
            let _ = print("test@@@")
            let missions: [String] = missionViewModel.getMissionsStr()
            let _ = print("test@@@@")

            // 추후 이미지 크기 조정 필요
            Image(imageName)
                .resizable()
                .scaledToFit()
            Text(roleName)

            // 코지의 라인 익스텐션 사용
            Line().stroke(style: StrokeStyle(lineWidth: 3, dash: [10]))
                .frame(height: 1)
            
            // 아래부분 회색 넣기는 나중에..? checkbox에 foreground로 하거나 clipped로 될까?
            
            HStack {
                Text("**미션**") // add font later
                Spacer()
            }
            .padding()
            
            ForEach(0...2, id: \.self) { ind in
                HStack {
                    CheckBoxView(missionId: ind, progress: userViewModel.user?.missionProgress ?? [false, false, false], roleId: roleId)
                    
                    if missions.count > ind {
                        Text(missions[ind])
                    } else {
                        Text("mcnt")
                    }
                    
//                    for mission in missionViewModel.missions where mission.id == ind {
//                        Text(mission.getMission())
//                    }
                    // 폰트 추가
                    Spacer()
                }
                    .padding()
            }
        }
        .onAppear {
            self.userViewModel.fetchData(roomCode: roomCode)
            self.missionViewModel.fetchData(roleId: roleId)
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
    let missionId: Int
    @State var progress: [Bool]
    let roleId: Int
    let missionViewModel = MissionViewModel()

    var body: some View {
        Text("\(Image(systemName: progress[missionId] ? "checkmark.square.fill" : "square"))")
            .bold()
            .foregroundColor(Color(UIColor.black))
            .onTapGesture {
                progress[missionId].toggle()
                // MARK: 파이어베이스 update 하기
                // missionViewModel.fetchData(roleId: roleId)
                cnt+=1
                print("debug cnt: \(cnt)")
                missionViewModel.updateMissionProgress(missionId: missionId)
            }
    }
}

var checkboxcnt = [0, 0, 0] // debug cnt

// struct MissionCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        MissionCardView(roleId: 1)
//    }
// }
