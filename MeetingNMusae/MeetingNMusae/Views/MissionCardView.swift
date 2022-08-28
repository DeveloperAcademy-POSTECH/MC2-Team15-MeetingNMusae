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
    @State var progress: [Bool] = [false, false, false]
    let roomCode = UserDefaults.standard.string(forKey: "roomCode") ?? ""
    let nickname = UserDefaults.standard.string(forKey: "nickname") ?? ""
    let roleId = UserDefaults.standard.integer(forKey: "roleId")
    
    var body: some View {
        let roleName: String = Role.getRoleName(roleId: roleId)
        let imageName: String = roleName
        VStack(spacing: 0) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: UIScreen.screenWidth * 0.513, maxHeight: UIScreen.screenWidth * 0.513)
                .padding(.top)
            Text(roleName)
                .font(.title2)
                .bold()
                .padding(.bottom, UIScreen.screenHeight * 0.0438)

            ZStack {
                Rectangle()
                    .foregroundColor(Color.bgGray)
                    .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
                    .padding([.horizontal, .bottom], 1.5)
                VStack {
                    // 코지의 라인 익스텐션 사용
                    Line().stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round, dash: [8, 10]))
                        .frame(height: 1)
                    Spacer()
                }
                VStack(alignment: .leading) {
                    Text("미션")
                        .font(.headline)
                        .fontWeight(.black)

                    // 따로 뷰로 빼서 CheckBoxView와 옆에 텍스트 같이 뒀더니 미션이 안 보여서 되돌림
                    ForEach(0...2, id: \.self) { ind in
                        HStack(alignment: .firstTextBaseline) {
                            // MARK: 모르겠음: userViewModel.deviceUser?가 항상 nil이 나옴
                             Text("\(Image(systemName: progress[ind] ? "checkmark.square.fill" : "square"))")
                                .font(.title3)
                                .fontWeight(.heavy)
                                .minimumScaleFactor(0.5)
                                .foregroundColor(Color(UIColor.black))
                                .background(Color.white.padding(4))
                            Text((self.missionViewModel.missionStrs.count > ind) ? self.missionViewModel.missionStrs[ind] : "mcnt: \(self.missionViewModel.missionStrs.count)")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .baselineOffset(2)
                                .lineSpacing(2)
                            Spacer()
                        }
                        .padding(.vertical, 3)
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
                .padding(.horizontal, 26)
                .padding(.vertical)
            }
        }
        .background(
            CharacterBox(roleIndex: roleId)
        )
    }
}

// ref: https://stackoverflow.com/a/58606176/6183323
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct MissionCardView_Previews: PreviewProvider {
    static var previews: some View {
        MissionCardView()
    }
}
