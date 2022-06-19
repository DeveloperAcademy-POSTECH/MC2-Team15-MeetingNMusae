import SwiftUI

// ref: https://sarunw.com/posts/swiftui-circular-progress-bar/

struct MissionProgressCircleView: View {
    // 받을 데이터: 참여자별 역할, 닉네임, 미션 달성도
    // 받을 데이터: 프로그레스 바 두께 (혹은 전역변수에서 가져옴)
    
    var user: User
    var lineWidth: CGFloat

    let textheight = 20.0

    var body: some View {
        let progress = user.getMissionProgress()
        let roleId = user.roleId
        let roleName = Role.getRoleName(roleId: roleId)
        let roleColor = Role.getRoleColor(roleId: roleId)//

        VStack {
            ZStack {
                Circle()
                    .stroke(
                        Color.circleGray,
                        lineWidth: lineWidth
                    )
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        roleColor,
                        style: StrokeStyle(
                            lineWidth: lineWidth,
                            lineCap: .butt
                        )
                    )
                    .rotationEffect(.degrees(-90))
                    // easeOut: 시작과 끝 천천히 <-> easeIn(시작과 끝 빨리), linear(등속)
                    .animation(.easeOut, value: progress)

                Image("원_\(roleName)")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
            }
            // stroke는 반은 영역 벗어나서 패딩추가함
            .padding(lineWidth*0.5)

            // 역할
            Text(roleName)
//                .font(.title3).bold() // 이런 류는 나중에 시간 있으면
                .font(.system(size: 14, weight: .bold))

            // 닉네임
            Text(user.nickname)
//                .font(.title3).medium() // 이런 류는 나중에 시간 있으면
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.subTextGray)

        }
    }
}
//
// struct CircleProgBarView_Previews: PreviewProvider {
//    let user = User(missionIds: [0,1,2], nickname: "e", roomCode: roomCode)
//    static var previews: some View {
//        MissionProgressCircleView(user: self.user, lineWidth: 5.0)
//    }
// }
