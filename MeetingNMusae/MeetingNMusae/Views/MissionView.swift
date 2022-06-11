import SwiftUI

struct MissionView: View {
    // 진행뷰에 넘길 데이터: 참여자별 역할, 닉네임, 미션 달성도
    // 진행뷰에 넘길 데이터: 프로그레스 바 두께 (혹은 전역변수에서 가져옴)
    @State var prog: [Double] = [0.0, 1.0, 0.6, 0.3, 0.3, 0.6]
    // 임시
    let roleName = "금고무새"
    @State var didMissions: [Bool] = [true, false, false]
    // 진행자인지
    let isFacilitator = true

    // 폰트 크기에 따라 수정 예정
    let textheight = 40.0

    var body: some View {
        VStack {
            // 다른 사람 역할 미션 프로필 보기
            ScrollView(.horizontal) {
                HStack {
                    // 내 역할 제외하기

                    ForEach($prog, id: \.self) { prog in
                        // 넘길 데이터: 참여자별 역할, 닉네임, 미션 달성도
                        // 넘길 데이터: 화면비 해당 프로그레스 바 두께
                            MissionProgressCircleView(prog: prog)
                    }
                }
                // 코지의 UIScreen+Extensions에 맞춤
                .frame(height: UIScreen.screenWidth*0.2+textheight)
                .padding()
            }
            // 넘길 데이터: 현재 역할
              // 현재 역할이 관리되는 방법에 따라 넘길 것이 없을 수도 있음
            // 넘길 데이터: 현재 역할의 미션과 진행도 -> didMissions는 변경 예정
              // ViewBuilder 사용시 내부에 property wrapper 안. 되는 듯하여 따로 넘겨야할 듯
              // 파이어베이스 연결하면서 ObservedObject 해보고 결정할. 예정
            missionCardView(role: roleName, didMissions: $didMissions)
                .padding()
            Spacer()
            if isFacilitator {
                Button(action: {}){
                    Text("회의 종료하기")
                        // 폰트 추후 수정
                        .foregroundColor(.pink)
                }
            }
        }
    }
}

@ViewBuilder
func missionCardView(role: String, didMissions: Binding<[Bool]>) -> some View {
    // 서버에서 받을 데이터: 현재 역할, 미션, 미션 수행 했는지
    // 서버에 보낼 데이터: 미션 수행 했는지
    let roleName = role
    let imageName = roleName
    let missions = ["미션1", "미션2", "미션3"]

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
            Text("**미션**") // add font
            Spacer()
        }
        .padding()
        ForEach(0...2, id: \.self) { seq in
            HStack {
                CheckBoxView(checked: didMissions[seq])
                Text(missions[seq])
                // 폰트 추가
                Spacer()
            }
                .padding()
        }
    }
    .padding()
    .padding(.bottom)
    .background(
        RoundedRectangle(cornerRadius: 30.0)
            .strokeBorder(
                lineWidth: 5
            )
    )
}

// ref: https://stackoverflow.com/questions/58425829/how-can-i-create-a-text-with-checkbox-in-swiftui
struct CheckBoxView: View {
    @Binding var checked: Bool

    var body: some View {
        Image(systemName: checked ? "checkmark.square.fill" : "square")
            .foregroundColor(
                checked ? Color(UIColor.black) : Color.secondary)
            .onTapGesture {
                self.checked.toggle()
            }
    }
}

struct MissionView_Previews: PreviewProvider {
    static var previews: some View {
        MissionView()
            .previewInterfaceOrientation(.portrait)
    }
}

// ref: 이하 코지의 UIScreen+Extensions 파일 내용. 프로젝트에 합칠 때 삭제할 부분
struct Line: Shape { func path(in rect: CGRect) -> Path {
         var path = Path()
         path.move(to: CGPoint(x: 0, y: 0))
         path.addLine(to: CGPoint(x: rect.width, y: 0))
         return path
     }
 }
extension UIScreen {
     static let screenWidth: CGFloat = UIScreen.main.bounds.size.width
     static let screenHeight: CGFloat = UIScreen.main.bounds.size.height
     static let screenSize: CGSize = UIScreen.main.bounds.size
 }
