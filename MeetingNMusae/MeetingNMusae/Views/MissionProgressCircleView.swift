import SwiftUI

// ref: https://sarunw.com/posts/swiftui-circular-progress-bar/

struct CircleProgCircleView: View {
    // 받을 데이터: 참여자별 역할, 닉네임, 미션 달성도
    // 받을 데이터: 프로그레스 바 두께 (혹은 전역변수에서 가져옴)
    @Binding var prog: Double
    // dynamically after design fix
    let linewidth = 5.0

    let strokecolor = Color.pink
    let roleName = "금고무새"
    let imageName = "금고무새"
    let nicname = "NicName"

    let textheight = 20.0

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(
                        Color(.systemGray4),
                        lineWidth: linewidth
                    )
                Circle()
                    .trim(from: 0, to: prog)
                    .stroke(
                        strokecolor,
                        style: StrokeStyle(
                            lineWidth: linewidth,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                    // easeOut: 시작과 끝 천천히 <-> easeIn(시작과 끝 빨리), linear(등속)
                    .animation(.easeOut, value: prog)

                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
            }
            // stroke는 반은 영역 벗어나서 패딩추가함
            .padding(linewidth*0.5)

            // 역할
            Text(roleName)
                // 폰트 추가 예정

            // 닉네임
            Text(nicname)
                // 폰트 추가 예정

        }
    }
}

struct CircleProgBarView_Previews: PreviewProvider {
    static var previews: some View {
        CircleProgCircleView(prog: .constant(0.6))
    }
}
