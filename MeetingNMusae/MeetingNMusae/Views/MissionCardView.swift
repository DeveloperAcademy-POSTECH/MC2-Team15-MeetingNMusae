//
//  MissionCardView.swift
//  MeetingNMusae
//
//  Created by Hyorim Nam on 2022/06/11.
//

import SwiftUI

struct MissionCardView: View {
    // 파이어베이스 연결할 때 프로퍼티 래퍼 사용할 것
    @State var role = "금고무새"
    @State var didMissions: [Bool] = [true, false, false]

    var body: some View {
        // 서버에서 받을 데이터: 현재 역할, 미션, 미션 수행 했는지
        // 서버에 보낼 데이터: 미션 수행 했는지
        let roleName = role
        let imageName = role
        let missions = ["미션1", "미션2", "미션3"]

        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
            Text(roleName)

            // will be changed to a custom line - based on 역할 선택 (상세) view
            Divider()

            HStack {
                Text("**미션**") // add font
                Spacer()
            }
            .padding()
            ForEach(0...2, id: \.self) { seq in
                HStack {
                    CheckBoxView(checked: $didMissions[seq])
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

struct MissionCardView_Previews: PreviewProvider {
    static var previews: some View {
        MissionCardView()
    }
}
