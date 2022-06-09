//
//  RoleListViewModel.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/09.
//

import Foundation

import FirebaseFirestore

class RoleListViewModel: ObservableObject {
    @Published var roles: [Role]
    
    init() {
        roles = [Role]()
    }
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        db.collection("roles").order(by: "id").addSnapshotListener { (querySnapshot, error) in
            guard let roleDocuments = querySnapshot?.documents else {
                print("no documents")
                return
            }
            
            self.roles = roleDocuments.map { (queryDocumentSnapshot) -> Role in
                let data = queryDocumentSnapshot.data()
                let id = data["id"] as? Int ?? 0
                let roleName = data["role_name"] as? String ?? ""
                
                return Role(id: id, roleName: roleName)
            }
        }
    }
}
