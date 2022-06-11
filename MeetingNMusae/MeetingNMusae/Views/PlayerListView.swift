//
//  PlayerListView.swift
//  MeetingNMusae
//
//  Created by taekkim on 2022/06/09.
//

import SwiftUI

struct Line: Shape { func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

struct PlayerListView: View {
    let num: Int = 6
    let players: [String] = [
        "스킵",
        "코지",
        "유니스",
        "우기",
        "닉",
        "소니"
    ]

    var body: some View {
        VStack(alignment: .leading) {
            Text("참여자 (\(num))")
                .font(.title3)
                .fontWeight(.heavy)
                .padding()
                .padding(.horizontal)
            Line()
                .stroke(style: StrokeStyle(lineWidth: 3, dash: [10]))
                .frame(height: 1)
            VStack(alignment: .leading, spacing: 0) {
                ForEach(players, id: \.self) { player in
                    Text("• " + player)
                        .fontWeight(.bold)
                        .padding()
                }
            }
            .padding(.all)
            
            
        }
        .background(RoundedRectangle(cornerRadius: 20.0).stroke(Color.black))
        .background(Color.green)
        .frame(width: UIScreen.screenWidth * 0.9)
    }
}

struct PlayerListView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            PlayerListView()
        }
    }
}
