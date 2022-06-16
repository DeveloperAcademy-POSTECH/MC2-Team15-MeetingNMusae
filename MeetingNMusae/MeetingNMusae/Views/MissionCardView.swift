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

    // roleId가 1애서 시작 (0은 미선택용)
    //var roleId: Int // 순서 때문에 위에 둠
    @ObservedObject var userViewModel = UserViewModel()
    var missionViewModel = MissionViewModel() // fetch까지.
    //@State var didMissions: [Bool] = [false, false, false]
    // roleId가 1애서 시작 (0은 미선택용)
    @State var isChanged = false
    
    var body: some View {
        let roleId: Int = userViewModel.getUser(nickname)?.roleId ?? 0
        let roleName: String =  Role.roles[roleId].roleName
        let imageName: String = roleName

        VStack {
            let _ = missionViewModel.fetchData(roleId: roleId)
            let missions: [String] = missionViewModel.getMissionsStr()
            
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
            ForEach(0...2, id: \.self) { ind in
                HStack {
                    CheckBoxView(missionId: ind, progress: userViewModel.getUser(nickname)?.missionProgress ?? [false, false, false], roleId: roleId ?? 0)
//                        .onChange(of: userViewModel.getUser(nickname), perform: { isChanged.toggle() })
//                    CheckBoxView(missionId: mission, checked: didMissions[mission], roleId: roleId, missionViewModel: missionViewModel)
                    
                    if missions.count > ind {
                        Text(missions[ind])
                    } else {
                        
                        Text("mcnt: \(missions.count)")
                    }
                    // 폰트 추가
                    Spacer()
                }
                    .padding()
            }
        }
        .onAppear{
            userViewModel.fetchDatum(roomCode: roomCode)
//            roleId = userViewModel.getUser(nickname)?.roleId ?? 0
            missionViewModel.fetchData(roleId: roleId)
            //didMissions = userViewModel.getUser(nickname)?.missionProgress as? [Bool] ?? [false, false, false]
        }
//        .onChange(of: userViewModel.users, perform: <#T##(V) -> Void#>)
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
    @State var progress: [Bool]
//    @State var checked: Bool
    let roleId: Int
//    @ObservedObject var missionViewModel: MissionViewModel
    let missionViewModel = MissionViewModel()

    var body: some View {
        Image(systemName: progress[missionId] ? "checkmark.square.fill" : "square")
            .foregroundColor(
                progress[missionId] ? Color(UIColor.black) : Color.secondary)
            .onTapGesture {
                progress[missionId].toggle()
                // MARK: 파이어베이스 update 하기
                // missionViewModel.fetchData(roleId: roleId)
                missionViewModel.updateMissionProgress(missionId: missionId)
            }
    }
}

//struct MissionCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        MissionCardView()
//    }
//}
