//
//  UserViewModel.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/09.
//

import FirebaseFirestore

class UserViewModel: ObservableObject {
    @Published var users: [User]
    
    init() {
        users = [User]()
    }
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        db.collection("users").order(by: "id").addSnapshotListener { (querySnapshot, error) in
            guard let roleDocuments = querySnapshot?.documents else {
                print("no documents")
                return
            }
            
            self.users = roleDocuments.map { (queryDocumentSnapshot) -> User in
                let data = queryDocumentSnapshot.data()
                let missionsIds = data["missions_ids"] as? [Int] ?? []
                let missionProgress = data["mission_progress"] as? [Bool] ?? []
                let nickname = data["nickname"] as? String ?? ""
                let roleId = data["role_id"] as? Int ?? 0
                let roomCode = data["room_code"] as? String ?? ""
                
                return User(missionIds: missionsIds, missionProgress: missionProgress, nickname: nickname, roleId: roleId, roomCode: roomCode)
            }
        }
    }
}
