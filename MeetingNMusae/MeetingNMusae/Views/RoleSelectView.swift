//
//  RoleSelectView.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/09.
//

import SwiftUI

struct RoleSelectView: View {
    @State var roleImages: [Image] = [
        Image("진행무새"),
        Image("기록무새"),
        Image("타임무새"),
        Image("주제무새"),
        Image("이해무새"),
        Image("왜??무새"),
        Image("삐딱무새"),
        Image("좋아무새"),
        Image("발언권무새"),
        Image("금고무새")
    ]
    @State private var viewModel = RoleListViewModel()
    
    
    var body: some View {
        List(viewModel.roles) { role in
            RoleItem(roleImage: roleImages[role.id], roleName: role.roleName)
        }
        .onAppear() {
            self.viewModel.fetchData()
        }
    }
}

struct RoleItem: View {
    @State var roleImage: Image
    @State var roleName: String
    
    var body: some View {
        ZStack {
            VStack {
                roleImage.resizable().frame(width: 64, height: 64)
                Text("\(roleImage)")
            }
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.white)
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.red).padding(EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 0))
        }
    }
}

//struct RoleSelectView_Previews: PreviewProvider {
//    static var previews: some View {
//        RoleSelectView()
//    }
//}
