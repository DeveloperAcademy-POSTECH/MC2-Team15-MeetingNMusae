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
    //@Published var ifChange: Bool
    
    init() {
        users = [User]()
        self.fetchData(roomCode: roomCode)
        self.fetchDatum(roomCode: roomCode)
    }

    private var db = Firestore.firestore()

    func fetchData(roomCode: String) {
        db.collection("test_meeting_rooms").document("ROOMCODE1").collection("test_users").addSnapshotListener { (querySnapshot, _) in
            print("uVM fD2 .")
            guard let documents = querySnapshot?.documents else {
                print("no documents")
                return
            }
            print("uVM fD2 ..")
            self.users = documents.compactMap { (queryDocumentSnapshot) -> User? in
                return try? queryDocumentSnapshot.data(as: User.self)
            }
            print("uVM fD2 ... ")
        }
        print("uVM fD2 users.count: \(users.count)")
    }
    
    // for card view only
    func fetchDatum(roomCode: String) {
        // different collection
        // 이거 결과가 비동기로 늦게 나오는 것 같음..
        
        // 1인용으로 바꿔둠 -> 다시 바꿀 필요
        
        db.collection("test_meeting_room").document("ROOMCODE1").collection("test_users").document("TESTUSER1")
            .addSnapshotListener { (documentSnapshot, _) in
                print("uVM fD listener in")
                guard let document = documentSnapshot else {
                    print("doc = documentSnapshot fail")
                    return
                }
                print("uVM fD listener mid")
                guard let data = document.data() else {
                    print("doc data empty")
                    return
                }
                print("\(String(describing: data["nickname"]))")
                // 이게 "Optional(Nick1)로 나옴
//                self.users =
        }
        print("uVM fD listener out")
        print("users.count: \(users.count)")
    }

    func addUser(roomCode: String, user: User) {
        do {
            _ = try db.collection("test_meeting_room").document("\(roomCode)").collection("users").document("\(user.nickname)").setData(from: user)
        } catch {
            print(error)
            return
        }
    }
    
    func getUser( _ nickname: String) -> User? {
//        self.fetchData()
        for user in users where user.nickname == nickname {
            return user
        }
        print("user does not exist")
        return nil // should not happen
    }
}
