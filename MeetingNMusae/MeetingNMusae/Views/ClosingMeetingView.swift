//
//  ClosingMeetingView.swift
//  MeetingNMusae
//
//  Created by Heeji Sohn on 2022/06/11.
//

import SwiftUI

struct ClosingMeetingView: View {
    var body: some View {
        
        VStack{
            Image("endofmeetingMusaes")
            
            Text("회의가 종료되었습니다")
                .font(.title)
                .fontWeight(.bold)
        }
    }
}

struct ClosingMeetingView_Previews: PreviewProvider {
    static var previews: some View {
        ClosingMeetingView()
    }
}
