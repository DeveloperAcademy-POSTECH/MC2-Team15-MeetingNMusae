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
    func fetchData(roomCode: String, nickname: String? = nil) {
//        db.collection("test_meeting_room").document(roomCode).collection("test_users").addSnapshotListener { (querySnapshot, _) in
        db.collection("meeting_rooms").document(roomCode).collection("users").addSnapshotListener { (querySnapshot, _) in
            guard let documents = querySnapshot?.documents else {
                print("no documents")
                return
            }
            self.users = documents.compactMap { (queryDocumentSnapshot) -> User? in
                print("\(String(describing: queryDocumentSnapshot.data()["nickname"]))----------------------------")
                return try? queryDocumentSnapshot.data(as: User.self)
            }
            // MARK: 이거 나눠야겠다
            print("uVM fD2 ... ")
            if nickname != nil {
                if self.users.count > 0 {
                    for us in self.users where us.nickname == nickname {
                        self.user = us
                    }
                }
            }
        }
        print("uVM fD2 out ")
    }
    
    func addUser(roomCode: String, user: User) {
        do {
//            _ = try db.collection("test_meeting_room").document("\(roomCode)").collection("users").document("\(user.nickname)").setData(from: user)
            _ = try db.collection("meeting_rooms").document(roomCode).collection("users").document("\(user.nickname)").setData(from: user)
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

    func updateUserRole(roomCode: String, roleId: Int, nickname: String, isSelect: Bool) {
        db.collection("meeting_rooms").document("\(roomCode)").collection("users").document(nickname).updateData(["role_id": isSelect ? roleId : 0])
    }
    
    
    func updateMissionProgress(roomCode: String, missionId: Int, nickname: String) {
        print("updateMP called")
        var isChanged = false

        let doc =
//        db.collection("test_meeting_room").document("\(roomCode)").collection("test_users").document("TESTUSER1")
        db.collection("meeting_rooms").document(roomCode).collection("users").document(nickname)

        doc.addSnapshotListener { DocumentSnapshot, error in
            guard let document = DocumentSnapshot else {
                print("Error fetching document: \(String(describing: error))")
                return
            }
            guard var data = document["mission_progress"] as? [Bool] else {
                print("uVM updateMProgress doc as bool fail")
                return
            }
            if !isChanged && (data.count > missionId) {
                isChanged = true
                data[missionId].toggle()
                doc.updateData(["mission_progress": data])
            }
        }
    }
    
}

