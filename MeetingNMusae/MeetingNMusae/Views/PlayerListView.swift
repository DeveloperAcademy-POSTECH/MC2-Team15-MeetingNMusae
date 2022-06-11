//
//  PlayerListView.swift
//  MeetingNMusae
//
//  Created by taekkim on 2022/06/09.
//

import SwiftUI

struct PlayerListView: View {
    let roomCode: String
    @State var users: [User] = []
    @ObservedObject var userViewModel = UserViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            Text("참여자 (\(userViewModel.users.count))")
                .font(.title3)
                .fontWeight(.heavy)
                .padding()
                .padding(.horizontal)
            Line()
                .stroke(style: StrokeStyle(lineWidth: 3, dash: [10]))
                .frame(height: 1)
            VStack(alignment: .leading, spacing: 0) {
                ForEach(userViewModel.users) { user in
                    Text("• " + user.nickname)
                        .fontWeight(.bold)
                        .padding()
                }
            }
            .padding(.all)
        }
        .background(RoundedRectangle(cornerRadius: 20.0).stroke(Color.black))
        .frame(width: UIScreen.screenWidth * 0.9)
        .onAppear {
            self.userViewModel.fetchData(roomCode: roomCode)
        }
    }
}

struct PlayerListView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            Rectangle()
            PlayerListView(roomCode: "9MCMPK")
                .background(Color.green)
            Rectangle()
        }
    }
}
