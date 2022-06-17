//
//  FireTestView.swift
//  MeetingNMusae
//
//  Created by Hyorim Nam on 2022/06/16.
//

// 각각 meetingroomviewmodel, userviewmodel, missionviewmodel 연결해보기

import SwiftUI

var cnt = 0

struct FireTestView: View {
    @ObservedObject var missionViewModel = MissionViewModel()

    var body: some View {
        
        let _ = missionViewModel.fetchData(roleId: 1)
        
        VStack {
            Text("count: \(missionViewModel.missions.count)")
//                .onChange(of: userViewModel.ifChange){
//                    //refresh
//                }
                .onAppear {
                    missionViewModel.fetchData(roleId: 1)
                }
            Text("content: \(missionViewModel.missions.first?.content ?? "nil")")
        }
//        .onAppear{
//            meetingRoomViewModel.fetchData(roomCode: roomCode)
//        }
    }
}

struct FireTestView_Previews: PreviewProvider {
    static var previews: some View {
        FireTestView()
    }
}
