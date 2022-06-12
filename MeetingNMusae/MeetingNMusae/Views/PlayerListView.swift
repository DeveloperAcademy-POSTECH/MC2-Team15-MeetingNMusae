//
//  PlayerListView.swift
//  MeetingNMusae
//
//  Created by taekkim on 2022/06/09.
//

import SwiftUI

//temp
struct CharacterBox: View {
    let width: CGFloat?
    let height: CGFloat?

    init(width: CGFloat? = nil, height: CGFloat? = nil) {
        self.width = width
        self.height = height
    }

    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .foregroundColor(.white)
            .shadow(color: .black, radius: 0, x: 8, y: 8)
            .frame(width: width, height: height)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.black, lineWidth: 3)
            )
    }
}

struct PlayerListView: View {

    let roomCode: String
    @State var users: [User] = []
    @ObservedObject var userViewModel = UserViewModel()

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Text(roomCode)
                    .fontWeight(.bold)
                    .underline()
                    .padding(.vertical, UIScreen.screenHeight * 0.0178)
                    .padding(.bottom, UIScreen.screenHeight * 0.0083)
            }
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    Button(action: action) {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundColor(Color.black)
                    }
                        .padding(.leading, UIScreen.screenHeight * 0.02843)
                }
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("참여자 (\(userViewModel.users.count))")
                        .font(.title3)
                        .fontWeight(.heavy)
                        .padding(.all, UIScreen.screenHeight * 0.0284)
                    Line()
                        .stroke(style: StrokeStyle(lineWidth: 3, dash: [10]))
                        .frame(height: 1)
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(userViewModel.users) { user in
                            Text("• " + user.nickname)
                                .fontWeight(.bold)
                                .padding(.all, UIScreen.screenHeight * 0.0178)
                        }
                    }
                        .padding(.all, UIScreen.screenHeight * 0.0178)
                }
                    .background(CharacterBox())
                    .onAppear {
                        self.userViewModel.fetchData(roomCode: roomCode)
                }
                Spacer()
                Button(action: action) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(.black)
                        Text("회의 시작")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                        .frame(height: UIScreen.screenHeight * 0.076)
                }
                .padding(.bottom, 8)
            }
                .padding(.vertical, UIScreen.screenWidth * 0.08)
        }
    }

    func action() {
    }
}

struct PlayerListView_Previews: PreviewProvider {
    static var previews: some View {
//        PlayerListView(roomCode: "9MCMPK")
//            .previewDevice("iPhone 13 (mini)")
//        PlayerListView(roomCode: "9MCMPK")
//            .previewDevice("iPhone 13 Pro Max")
        PlayerListView(roomCode: "9MCMPK")
            .previewDevice("iPhone 13")
//        PlayerListView(roomCode: "9MCMPK")
//            .previewDevice("iPad Air (5th generation)")
    }
}
