import FirebaseFirestore
import FirebaseFirestoreSwift

class MissionViewModel: ObservableObject {
    var missions: [Mission] // published 사실 불필요. 변경 없어.. 한 번 불러오면 끝인 건데. 굳이 필요한가? 사실 필요 없긴 한데.
    let roleId: Int
    
    init() {
        missions = [Mission]()
        roleId = 1 // default
        self.fetchData(roleId: roleId)
    }

    private var db = Firestore.firestore()

    func fetchData(roleId: Int) {
        print("mVM fD in")
        let _ = db.collection("missions").whereField("role_id", isEqualTo: roleId)
            .addSnapshotListener { (querySnapshot, _ ) in
                print("mVM listener in")
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
                print("mVM listener mid")
            self.missions = documents.compactMap { (queryDocumentSnapshot) -> Mission? in
                print("mVM listener good")
                return try? queryDocumentSnapshot.data(as: Mission.self)
            }
                print("mVM missions.count: \(self.missions.count)")
//                print("\(String(describing: data["content"]))")
                print("mVM listener what")
        }
        print("mVM listener out")
    }
    
    func updateMissionProgress(missionId: Int) {
        // 임시 (이대로 하면 취소 안 되고 이상해짐)
        var didMissions: [Bool] = [false, false, false]
        let doc =
        db.collection("test_meeting_room").document("\(roomCode)").collection("test_users").document("TESTUSER1")
        
        doc.addSnapshotListener { DocumentSnapshot, error in
                guard let document = DocumentSnapshot else {
                    print("Error fetching document: \(String(describing: error))")
                    return
                }
                guard var data = document["mission_progress"] as? [Bool] else {
                    print("mVM updateMProgress doc as bool fail")
                    return
                }
                // 비동기 처리 필요한 듯.. 이상하게 됨
                if data.count > missionId {
                    didMissions = data
//                    didMissions[missionId].toggle()
                }
            }
        didMissions[missionId].toggle()

        doc.updateData(["mission_progress":didMissions])
        
    }
    
    func getMissionsStr() -> [String] {
        print("getMissionStr in")
//        let _ = self.fetchData(roleId: roleId)
        var missionsStr: [String] = []
        print("missions.count: \(missions.count)")
        print("missions.getMission(): \(missions.first?.getMission())")
        for mission in self.missions {
            missionsStr.append(mission.getMission())
        }
        print("missionStr: \(missionsStr)")
        return missionsStr
    }

}
