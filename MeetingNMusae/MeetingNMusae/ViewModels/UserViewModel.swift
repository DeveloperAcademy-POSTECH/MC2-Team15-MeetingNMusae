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
    @Published var user: User?
    
    init() {
        users = [User]()
    }

    private var db = Firestore.firestore()
    
    // 좀 자주 불림
    func fetchData(roomCode: String) {
        db.collection("test_meeting_room").document(roomCode).collection("test_users").addSnapshotListener { (querySnapshot, _) in
            guard let documents = querySnapshot?.documents else {
                print("no documents")
                return
            }
            self.users = documents.compactMap { (queryDocumentSnapshot) -> User? in
                print("\(String(describing: queryDocumentSnapshot.data()["nickname"]))----------------------------")
                return try? queryDocumentSnapshot.data(as: User.self)
            }
            print("uVM fD2 ... ")
            if self.users.count > 0 {
                for us in self.users where us.nickname == nickname {
                    self.user = us
                }
            }
        }
        print("uVM fD2 out ")
    }
    
    func addUser(roomCode: String, user: User) {
        do {
            _ = try db.collection("test_meeting_room").document("\(roomCode)").collection("users").document("\(user.nickname)").setData(from: user)
        } catch {
            print(error)
            return
        }
    }
    
//    func getUser(nickname: String) {
//        db.collection("test_meeting_room").document("ROOMCODE1").collection("users").whereField("nickname", isEqualTo: nickname).addSnapshotListener { (querySnapshot, _ ) in
//            guard let documents = querySnapshot?.documents else {
//                print("No documents")
//                return
//            }
//            self.users = documents.compactMap { (queryDocumentSnapshot) -> User? in
//                return try? queryDocumentSnapshot.data(as: User.self)
//            }
//            if self.users.count > 0 {
//                self.user = self.users[0]
//            } else {
//                self.user = nil
//            }
//        }
//    }
}
