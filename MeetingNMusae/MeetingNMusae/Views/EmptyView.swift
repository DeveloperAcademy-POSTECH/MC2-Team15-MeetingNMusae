//
//  EmptyView.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/10.
//

import SwiftUI

struct EmptyView: View {
    @State var role: Role
    var body: some View {
        NavigationView {
            VStack {
                Image("\(role.roleName)").resizable().scaledToFit()
                Button(action: {
                    
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20).foregroundColor(.black)
                        Text("선택하기").foregroundColor(.white)
                    }
                }.padding()
            }
        }
        .navigationTitle("\(role.roleName)")
        .navigationBarTitleDisplayMode(.inline)
    }
}
