import SwiftUI

struct MissionView: View {
    // 진행뷰에 넘길 데이터: 참여자별 역할, 닉네임, 미션 달성도
    // 진행뷰에 넘길 데이터: 프로그레스 바 두께 (혹은 전역변수에서 가져옴)
    @State var prog: [Double] = [0.0, 1.0, 0.6, 0.3, 0.3, 0.6]
    // 임시
    let roleName = "금고무새"

    let width = UIScreen.main.bounds.width

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
                .frame(height: width*0.2+textheight)
                .padding()
            }
            // 넘길 데이터: 현재 역할
              // 현재 역할이 관리되는 방법에 따라 넘길 것이 없을 수도 있음
            // 추후 이미지 크기 조정 필요
            MissionCardView()
                .padding()
            Spacer()
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static var previews: some View {
        MissionView()
            .previewInterfaceOrientation(.portrait)
    }
}
