//
//  UserViewModel.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/09.
//

/**
현재 있으나 쓰이지 않음
 */


import FirebaseFirestore
import FirebaseFirestoreSwift

class UserViewModel: ObservableObject {
    @Published var users: [User]

    init() {
        users = [User]()
    }

    private var db = Firestore.firestore()

    func fetchData(roomCode: String) {
        db.collection("users").whereField("room_code", isEqualTo: roomCode).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("no documents")
                return
            }

            self.users = documents.compactMap { (queryDocumentSnapshot) -> User? in
                return try? queryDocumentSnapshot.data(as: User.self)
            }
        }
    }
}
