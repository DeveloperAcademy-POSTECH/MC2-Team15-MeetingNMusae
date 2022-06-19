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
    @Published var user: User

    init() {
        users = [User]()
        user = User(missionIds: [], nickname: "", roomCode: "")
    }

    private var db = Firestore.firestore()

    func fetchData(roomCode: String) {
        db.collection("meeting_rooms").document(roomCode).collection("users").addSnapshotListener { (querySnapshot, _) in
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
            _ = try db.collection("meeting_rooms").document(roomCode).collection("users").document("\(user.nickname)").setData(from: user)
        } catch {
            print(error)
            return
        }
    }
    
    func updateUserRole(roomCode: String, roleId: Int, nickname: String, isSelect: Bool) {
        db.collection("meeting_rooms").document("\(roomCode)").collection("users").document(nickname).updateData(["role_id": isSelect ? roleId : 0])
    }
    
    func voteUser(roomCode: String, nickname: String) {
        db.collection("meeting_rooms").document(roomCode).collection("users").document(nickname).updateData(["voted_count": FieldValue.increment(Int64(1))])
    }
    
    func getBestPlayer(roomCode: String) {
        var maxVotedCount: Int = 0
        
        db.collection("meeting_rooms").document(roomCode).collection("users").addSnapshotListener { (querySnapshot, _) in
            guard let documents = querySnapshot?.documents else {
                print("no documents")
                return
            }

            self.users = documents.compactMap { (queryDocumentSnapshot) -> User? in
                let data = try? queryDocumentSnapshot.data(as: User.self)
                
                if maxVotedCount < data!.votedCount {
                    maxVotedCount = data!.votedCount
                    self.user = data!
                }
                
                return try? queryDocumentSnapshot.data(as: User.self)
            }
        }
    }
    
    func deleteMeetingRoom(roomCode: String, nickname: String) {
        db.collection("meeting_rooms").document(roomCode).collection("users").document(nickname).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
}

