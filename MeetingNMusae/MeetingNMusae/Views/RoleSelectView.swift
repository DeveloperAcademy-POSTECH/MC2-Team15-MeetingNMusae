//
//  RoleSelectView.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/09.
//

import SwiftUI

let imageWidthSize: CGFloat = 128
let imageHeightSize: CGFloat = 86

struct RoleSelectView: View {
    @State var columns: [GridItem] = [
        GridItem(),
        GridItem()
    ]
    
    @State var roomCode: String
    
    @State var roles: [Role] = []
    
    @State var roleImages: [Image] = [
        Image("진행무새"),
        Image("기록무새"),
        Image("타임무새"),
        Image("주제무새"),
        Image("이해무새"),
        Image("왜무새"),
        Image("삐딱무새"),
        Image("좋아무새"),
        Image("발언권무새"),
        Image("금고무새")
    ]
    
    @ObservedObject var roleViewModel = RoleViewModel()
    
    init(roomCode: String) {
        self.roomCode = roomCode
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("역할을 골라주세요").font(.headline).padding(.leading)
            HStack{
                Image(systemName: "star.circle.fill")
                Text("필수 역할입니다")
//                Button(action: {
//                    for role in roles {
//                        print("\(role.roleName)", terminator: " ")
//                    }
//                }, label: {
//                    Text("show all roles")
//                })
            }
            .padding(.leading)
            .font(.subheadline)
            .foregroundColor(Color.gray)
            
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(roleViewModel.roles) { role in
//                        roles.append(role)
                        RoleItem(roles: $roles, role: role)
                    }
                }
                .onAppear() {
                    self.roleViewModel.fetchData()
                }
                .padding()
            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    
                }, label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right").rotationEffect(.degrees(180))
                })
                .foregroundColor(.black)
            }
        }
    }
}

struct RoleItem: View {
    @Binding var roles: [Role]
    @State var isModalShown = false
    @State var role: Role
    
    var body: some View {
        Button(action: {
            roles.append(role)
            isModalShown = true
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black)
                VStack {
                    Image("\(role.roleName)")
                        .resizable()
                        .scaledToFill()
                        .frame(width: imageWidthSize, height: imageHeightSize)
                    Text("\(role.roleName)").padding(.bottom).foregroundColor(.black)
                }
                if role.id < 3 {
                    VStack {
                        HStack {
                            Image(systemName: "star.circle.fill")
                                .foregroundColor(Color.black)
                                .padding(10)
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }
        }.sheet(isPresented: $isModalShown) {
            NavigationView {
                EmptyView(role: role)
            }
        }
        .padding(.leading)
        .padding(.trailing)
    }
}

//struct RoleSelectView_Previews: PreviewProvider {
//    static var previews: some View {
//        RoleSelectView(roomCode: "1Q2W3E")
//    }
//}
