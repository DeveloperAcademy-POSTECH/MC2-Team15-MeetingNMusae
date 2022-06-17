import FirebaseFirestore
import FirebaseFirestoreSwift

class MissionViewModel: ObservableObject {
    @Published var missions: [Mission] // 리스너로 받으려면 published 필요
    // @Published var roleId: Int
    
    init() {
        self.missions = [Mission]()
        // self.roleId = 0
        // self.fetchData(roleId: roleId)
    }

    private var db = Firestore.firestore()

    func fetchData(roleId: Int) {
//        self.roleId = roleId
        db.collection("missions").whereField("role_id", isEqualTo: roleId)
            .addSnapshotListener { (querySnapshot, _ ) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.missions = documents.compactMap { (queryDocumentSnapshot) -> Mission? in
                return try? queryDocumentSnapshot.data(as: Mission.self)
            }
            print("mVM listener ...")
        }
        print("mVM listener out")
    }
    
    func updateMissionProgress(missionId: Int) {
        print("updateMP called")
        var isChanged = false

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
            if !isChanged && (data.count > missionId) {
                isChanged = true
                data[missionId].toggle()
                doc.updateData(["mission_progress": data])
            }
        }
    }
    
    func getMissionsStr() -> [String] {
        print("getMissionStr in")
        var missionsStr: [String] = []
        print("missions.count: \(missions.count)")
        print("missions.getMission(): \(String(describing: missions.first?.getMission()))")
        for mission in self.missions {
            missionsStr.append(mission.getMission())
        }
        print("missionStr: \(missionsStr)")
        return missionsStr
    }

}
