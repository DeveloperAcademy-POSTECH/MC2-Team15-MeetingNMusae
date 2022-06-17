//
//  MeetingRoomViewModel.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/10.
//
import FirebaseFirestore
import FirebaseFirestoreSwift

class MeetingRoomViewModel: ObservableObject {
    @Published var meetingRooms: [MeetingRoom]
    @Published var isEnded: Bool

    init() {
        meetingRooms = [MeetingRoom]()
        isEnded = false
    }

    private var db = Firestore.firestore()

    func fetchData(roomCode: String) {
        db.collection("test_meeting_room").whereField("room_code", isEqualTo: "\(roomCode)").addSnapshotListener { (querySnapshot, _) in
//        db.collection("meeting_rooms").whereField("room_code", isEqualTo: "\(roomCode)").addSnapshotListener { (querySnapshot, _) in
            guard let documents = querySnapshot?.documents else {
                print("no documents")
                return
            }
        
            self.meetingRooms = documents.compactMap { (queryDocumentSnapshot) -> MeetingRoom? in
                return try? queryDocumentSnapshot.data(as: MeetingRoom.self)
            }
        }
    }
    
    func addMeetingRoom(meetingRoom: MeetingRoom) {
        do {
            _ = try db.collection("meeting_rooms").document("\(meetingRoom.roomCode)").setData(from: meetingRoom)
        } catch {
            print(error)
            return
        }
    }

    func enterMeetingRoom(roomCode: String, user: User) {
        UserViewModel().addUser(roomCode: roomCode, user: user)
    }

    // isSelect가 true인 경우 해당 역할 선택
    // isSelect가 false인 경우 해당 역할 선택 해제
    func updateRoleSelectUser(roomCode: String, roleId: Int, nickname: String, isSelect: Bool) {
        let path = db.collection("meeting_rooms")

        path.getDocuments { (snapshot, err) in
            if let err = err {
                print(err)
            } else {
                guard let snapshot = snapshot else { return }
                for document in snapshot.documents where document.documentID == "\(roomCode)" {
                    guard var data = document["role_select_users"] as? [String] else { return }

                    if isSelect { // 역할 선택인 경우
                        for i in 0..<data.count {
                            if data[i] == nickname { // nickname이 이미 역할을 선택했는지 확인
                                data[i] = "" // 만약 이전에 다른 역할을 선택했었다면 해당 역할을 선택한 nickname 지우기
                            }
                        }

                        data[roleId - 1] = nickname // 해당 역할에 nickname 지정
                    } else { // 역할 선택 해제인 경우
                        data[roleId - 1] = "" // 해당 역할에 지정되어 있는 nickname 지우기
                    }

                    path.document("\(roomCode)").updateData(["role_select_users": data])

                    if isSelect { // 역할 선택인 경우
                        path.document("\(roomCode)").collection("users").document("\(nickname)").updateData(["role_id": roleId]) // 유저의 역할 번호 지정
                    } else { // 역할 선택 해제인 경우
                        path.document("\(roomCode)").collection("users").document("\(nickname)").updateData(["role_id": 0]) // 유저의 역할 번호 0으로 초기화
                    }

                    
                }
            }
        }
    }
    
    func updateIsEnded(roomCode: String) {
        do {
            _ = try
        db.collection("test_meeting_room").document("ROOMCODE1").collection("test_users").document("TESTUSER1").updateData(["is_ended": true])
            isEnded = true
        } catch {
            print(error)
            return
        }
    }
}
