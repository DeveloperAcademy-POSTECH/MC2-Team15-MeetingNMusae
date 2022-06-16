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
    
    let collectionName = "test_meeting_room"

    init() {
        users = [User]()
        print("uVM init out")
    }

    private var db = Firestore.firestore()

    func fetchData(roomCode: String) {
        print("UVM.fetchData in")
        print("uVM users.count: \(users.count)")
        // different collection
        db.collection(collectionName).document("\(roomCode)").collection("test_users")/*.document("TESTUSER1")*/
            .whereField("room_code", isEqualTo: roomCode).addSnapshotListener { (querySnapshot, _) in
                print("uVM fetch snapshot in")
            guard let documents = querySnapshot?.documents else {
                print("no documents")
                return
            }
            print("test uVM")
            self.users = documents.compactMap { (queryDocumentSnapshot) -> User? in
                return try? queryDocumentSnapshot.data(as: User.self)
            }
        }
        print("uVM users.count: \(users.count)")
        print("UVM.fetchData out")
    }

    func addUser(roomCode: String, user: User) {
        do {
            _ = try db.collection(collectionName).document("\(roomCode)").collection("users").document("\(user.nickname)").setData(from: user)
        } catch {
            print(error)
            return
        }
    }
    
    func getUser( _ nickname: String) -> User? {
        self.fetchData(roomCode: roomCode)
        for user in users where user.nickname == nickname {
            return user
        }
        print("user does not exist")
        print("users.count: \(users.count)")
        return nil // should not happen
    }
}
