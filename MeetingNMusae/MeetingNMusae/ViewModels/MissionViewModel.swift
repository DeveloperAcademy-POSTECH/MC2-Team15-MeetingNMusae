import FirebaseFirestore
import FirebaseFirestoreSwift

class MissionViewModel: ObservableObject {
    // @Published var missions: [Mission] // 리스너로 받으려면 published 필요
    @Published var missionStrs: [String]
    
    init() {
//        self.missions = [Mission]()
        self.missionStrs = []
    }

    private var db = Firestore.firestore()

    func fetchMissions(roleId: Int) {
//        self.roleId = roleId
        db.collection("missions").whereField("role_id", isEqualTo: roleId)
            .addSnapshotListener { (querySnapshot, _ ) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                let missions: [Mission] = documents.compactMap { (queryDocumentSnapshot) -> Mission? in
//            self.missions = documents.compactMap { (queryDocumentSnapshot) -> Mission? in
                return try? queryDocumentSnapshot.data(as: Mission.self)
                }
                print("mVM fM missions.cnt: \(missions.count)")
                // MARK: 순서대로 가져오기를 위해 수정해야할 수 있음
                for mission in missions {
//                for mission in self.missions {
                    self.missionStrs.append(mission.getMission())
                }
                print("mVM listener ...")
                print("missionStrs[0]: \(self.missionStrs[0])")
            }
        print("mVM listener out")
    }
//
//    func updateMissionProgress(roomCode: String, missionId: Int, nickname: String) {
//        print("updateMP called")
//        var isChanged = false
//
//        let doc =
////        db.collection("test_meeting_room").document("\(roomCode)").collection("test_users").document("TESTUSER1")
//        db.collection("meeting_room").document(roomCode).collection("users").document(nickname)
//
//        doc.addSnapshotListener { DocumentSnapshot, error in
//            guard let document = DocumentSnapshot else {
//                print("Error fetching document: \(String(describing: error))")
//                return
//            }
//            guard var data = document["mission_progress"] as? [Bool] else {
//                print("mVM updateMProgress doc as bool fail")
//                return
//            }
//            if !isChanged && (data.count > missionId) {
//                isChanged = true
//                data[missionId].toggle()
//                doc.updateData(["mission_progress": data])
//            }
//        }
//    }

//    func getMissionsStr() -> [String] {
//        print("getMissionStr in")
//        var missionsStr: [String] = []
//        print("missions.count: \(missions.count)")
//        print("missions.getMission(): \(String(describing: missions.first?.getMission()))")
//        for mission in self.missions {
//            missionsStr.append(mission.getMission())
//        }
//        print("missionStr: \(missionsStr)")
//        return missionsStr
//    }

}
