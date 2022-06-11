//
//  RoleViewModel.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/09.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

class RoleViewModel: ObservableObject {
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
            
            self.roles = roleDocuments.compactMap { (queryDocumentSnapshot) -> Role? in
                return try? queryDocumentSnapshot.data(as: Role.self)
            }
        }
    }
}
