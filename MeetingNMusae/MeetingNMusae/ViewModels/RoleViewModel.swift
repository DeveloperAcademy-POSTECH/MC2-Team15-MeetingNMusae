//
//  RoleViewModel.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/09.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

/**
현재 있으나 쓰이지 않음
 */

class RoleViewModel: ObservableObject {
    @Published var roles: [Role]
    init() {
        roles = [Role]()
    }
    private var db = Firestore.firestore()
    func fetchData() {
        db.collection("roles").order(by: "id").addSnapshotListener { (querySnapshot, _) in
            guard let documents = querySnapshot?.documents else {
                print("no documents")
                return
            }
            self.roles = documents.compactMap { (queryDocumentSnapshot) -> Role? in
                return try? queryDocumentSnapshot.data(as: Role.self)
            }
        }
    }
}
