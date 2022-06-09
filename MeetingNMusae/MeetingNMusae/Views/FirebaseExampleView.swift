//
//  FirebaseExampleView.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/09.
//

import SwiftUI

struct FirebaseExampleView: View {
    @ObservedObject private var viewModel = RoleListViewModel()
    var body: some View {
        Text("역할 리스트").font(.title)
        List(viewModel.roles) { role in
            RoleItem(id: role.id, roleName: role.roleName)
        }
        .onAppear() {
            self.viewModel.fetchData()
        }
    }
}

struct RoleItem: View {
    @State var id: Int
    @State var roleName: String
    var body: some View {
        HStack {
            Text("\(id)")
            Text("\(roleName)")
        }
    }
}

struct FirebaseExampleView_Previews: PreviewProvider {
    static var previews: some View {
        FirebaseExampleView()
    }
}
