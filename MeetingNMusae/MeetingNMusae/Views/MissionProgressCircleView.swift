import SwiftUI

// ref: https://sarunw.com/posts/swiftui-circular-progress-bar/

struct MissionProgressCircleView: View {
    // 받을 데이터: 참여자별 역할, 닉네임, 미션 달성도
    // 받을 데이터: 프로그레스 바 두께 (혹은 전역변수에서 가져옴)
    
    // MARK: 뷰 리프레시 어쩌라고 싶다.. 파이어베이스쪽에서 바뀌는데!
    /*@State */var user: User
    var lineWidth: CGFloat
//    @State var progress: Double
//    var progress: Double = user.getMissionProgress()
//    let roleColor = //
    
//    @Binding var prog: Double
    // dynamically after design fix
//    let linewidth = 5.0

//    let strokecolor = Color.pink
//    let roleName = "금고무새"
//    let imageName = "금고무새"
//    let nicname = "NicName"

    let textheight = 20.0

    var body: some View {
        var progress = user.getMissionProgress()
        let roleId = user.roleId
        let roleName = Role.roles[roleId].roleName
        let roleColor = Role.getRoleColor(roleId: roleId)//

        VStack {
            ZStack {
                Circle()
                    .stroke(
                        Color(.systemGray4),
                        lineWidth: lineWidth
                    )
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        roleColor,
                        style: StrokeStyle(
                            lineWidth: lineWidth,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                    // easeOut: 시작과 끝 천천히 <-> easeIn(시작과 끝 빨리), linear(등속)
                    .animation(.easeOut, value: progress)

                Image(roleName)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
            }
            // stroke는 반은 영역 벗어나서 패딩추가함
            .padding(lineWidth*0.5)

            // 역할
            Text(roleName)
                // 폰트 추가 예정

            // 닉네임
            Text(nickname)
                // 폰트 추가 예정

        }
    }
}
//
//struct CircleProgBarView_Previews: PreviewProvider {
//    let user = User(missionIds: [0,1,2], nickname: "e", roomCode: roomCode)
//    static var previews: some View {
//        MissionProgressCircleView(user: user, lineWidth: 5.0)
//    }
//}
