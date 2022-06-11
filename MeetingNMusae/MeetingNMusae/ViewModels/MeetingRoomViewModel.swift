//
//  MeetingRoomViewModel.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/10.
//
import FirebaseFirestore

class MeetingRoomViewModel: ObservableObject {
    private var db = Firestore.firestore()
    private var roomCode: String
    var meetingRooms: [MeetingRoom]
    
    init(roomCode: String) {
        self.roomCode = roomCode
        meetingRooms = []
    }
    
    func fetchData() {
        db.collection("meeting_rooms").whereField("room_code", isEqualTo: roomCode).addSnapshotListener { (querySnapshot, error) in
            guard let meetingRoomDocuments = querySnapshot?.documents else {
                print("no documents")
                return
            }
            
            meetingRoomDocuments.map { (queryDocumentSnapshot) -> MeetingRoom in
                let data = queryDocumentSnapshot.data()
                let isRoleSelected = data["is_role_selected"] as? [Bool] ?? []
                let participantCount = data["participant_count"] as? Int ?? 0
                let readyCount = data["ready_count"] as? Int ?? 0
                
                return MeetingRoom(roomCode: self.roomCode, isRoleSelected: isRoleSelected, participantCount: participantCount, readyCount: readyCount)
            }
        }
    }
}
