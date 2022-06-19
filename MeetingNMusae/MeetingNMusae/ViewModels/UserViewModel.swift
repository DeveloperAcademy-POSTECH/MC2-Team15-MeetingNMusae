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
    
    // nickname 입력시 users를 roleID에 따라 정렬하고, user에 해당 닉네임의 User 구조체도 저장함
    func fetchData(roomCode: String, nickname: String? = nil, sort: Bool = false) {
        db.collection("meeting_rooms").document(roomCode).collection("users").addSnapshotListener { (querySnapshot, _) in
            guard let documents = querySnapshot?.documents else {
                print("no documents")
                return
            }
            self.users = documents.compactMap { (queryDocumentSnapshot) -> User? in
                print("\(String(describing: queryDocumentSnapshot.data()["nickname"]))----------------------------")
                return try? queryDocumentSnapshot.data(as: User.self)
            }
                        
            
            // users의 순서를 roleID에 따라 정렬
            // MissionCardView에서 사용
            // PlayerListView에서는 안 씀
            if sort {
                self.users.sort()
            }
            
            // 닉네임을 가진 유저 구조체를 저장함
            // MissionCardView에서 사용
            if nickname != nil {
                if self.users.count > 0 {
                    for us in self.users where us.nickname == nickname {
                        self.user = us
                    }
                }
            }
        }
        // print("uVM fD2 out ")
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
    
    
    func updateMissionProgress(roomCode: String, missionId: Int, nickname: String) {
        print("updateMP called")
        var isChanged = false

        let doc =
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

