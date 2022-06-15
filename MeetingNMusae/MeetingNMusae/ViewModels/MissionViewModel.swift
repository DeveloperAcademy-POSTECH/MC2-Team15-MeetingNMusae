import FirebaseFirestore
import FirebaseFirestoreSwift

class MissionViewModel: ObservableObject {
    var missions: [Mission]
    let roleId: Int
    
    init() {
        missions = [Mission]()
    }

    private var db = Firestore.firestore()

    func fetchData(roleId: Int) {
        db.collection("missions")
            .whereField(
                "role_id", isEqualTo: roleId)
            .addSnapshotListener { (querySnapshot, _) in
            guard let documents = querySnapshot?.documents else {
                print("no documents")
                return
            }

            self.missions = documents.compactMap { (queryDocumentSnapshot) -> Mission? in
                return try? queryDocumentSnapshot.data(as: Mission.self)
            }
        }
    }
    
    func updateMissionProgress(roomCode: String, nickname: String, missionId: Int)->() {
        do {
            // update 어떡하지
            _ = try db.collection("meeting_rooms").document("\(roomCode)").collection("users").document("\(nickname)").setData(["missionprogress":[true,-,-]]) // <- 인덱스 접근 필요함.. missionId 해당하는 애만 토클하기
        } catch {
            print(error)
            return
        }
    }

    // 파베 문서 특정 필드 업데이트 레퍼런스 복붙해옴
//    guard let key = ref.child("posts").childByAutoId().key else { return }
//    let post = ["uid": userID,
//                "author": username,
//                "title": title,
//                "body": body]
//    let childUpdates = ["/posts/\(key)": post,
//                        "/user-posts/\(userID)/\(key)/": post]
//    ref.updateChildValues(childUpdates)
    
    func getMissionsStr(roleId: Int)->[String]{
        var missionsStr: [String] = []
        for mission in missions {
            missionsStr.append(mission.getMission())
        }
        return missionsStr
    }

}
