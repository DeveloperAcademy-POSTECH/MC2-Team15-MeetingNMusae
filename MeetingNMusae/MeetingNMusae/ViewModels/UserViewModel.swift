//
//  UserViewModel.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/09.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

class UserViewModel: ObservableObject {
    @Published var users: [User]

    init() {
        users = [User]()
    }

    private var db = Firestore.firestore()

    func fetchData(roomCode: String) {
        db.collection("users").whereField("room_code", isEqualTo: roomCode).addSnapshotListener { (querySnapshot, _) in
            guard let documents = querySnapshot?.documents else {
                print("no documents")
                return
            }

            self.users = documents.compactMap { (queryDocumentSnapshot) -> User? in
                return try? queryDocumentSnapshot.data(as: User.self)
            }
        }
    }

    func addUser(roomCode: String, user: User) {
        do {
            _ = try db.collection("meeting_rooms").document("\(roomCode)").collection("users").document("\(user.nickname)").setData(from: user)
        } catch {
            print(error)
            return
        }
    }
    
    func getUser( _ nickname: String) -> User? {
        for user in users where user.nickname == nickname {
            return user
        }
        print("user does not exist")
        return nil // should not happen
    }
}
