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
        print("mVM fD in")
        db.collection("missions").whereField("role_id", isEqualTo: roleId)
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
                print("mVM listener what")
        }
        print("mVM listener out")
    }
    
    func updateMissionProgress(missionId: Int) {
        print("updateMP called")
        var isChanged = false

        let doc =
        db.collection("test_meeting_room").document("\(roomCode)").collection("test_users").document("TESTUSER1")
        
        doc.addSnapshotListener { DocumentSnapshot, error in
            
            checkboxcnt[0] += 1
            
            guard let document = DocumentSnapshot else {
                print("Error fetching document: \(String(describing: error))")
                return
            }

            checkboxcnt[1] += 1

            guard var data = document["mission_progress"] as? [Bool] else {
                print("mVM updateMProgress doc as bool fail")
                return
            }

            checkboxcnt[2] += 1

            if !isChanged && (data.count > missionId) {
                isChanged = true
                data[missionId].toggle()
                doc.updateData(["mission_progress": data])
            }
            
            // 결과 계속 카운트 올라감 (숫자 셋은 동일)
            print("checkboxcnt: \(checkboxcnt[0]), \(checkboxcnt[1]), \(checkboxcnt[2])")
        }
        // 결과 모두 0으로 1번만 일어남
        print("uMP out checboxcnt: \(checkboxcnt[0]), \(checkboxcnt[1]), \(checkboxcnt[2])")
        
    }
    
    func getMissionsStr() -> [String] {
        print("getMissionStr in")
//        let _ = self.fetchData(roleId: roleId)
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
