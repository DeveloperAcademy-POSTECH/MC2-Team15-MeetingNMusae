import FirebaseFirestore
import FirebaseFirestoreSwift

class MissionViewModel: ObservableObject {
    var missions: [Mission]
    let roleId: Int
    
    init() {
        missions = [Mission]()
        roleId = 0 // default
        
        print("mVM init before fetchData")
        
        self.fetchData(roleId: roleId)
        
        print("mVM init out")
    }

    private var db = Firestore.firestore()

    func fetchData(roleId: Int) {
        print("mVM fetchdata in")
        print("mVM missions.count \(missions.count)")
        db.collection("missions")
            .whereField(
                "role_id", isEqualTo: roleId)
            .addSnapshotListener { (querySnapshot, err) in
                
                print("mVM fetchdata query in")
                
            guard let documents = querySnapshot?.documents else {
                print("no documents")
                return
            }

                print("test mVM.fetchData")
                
            self.missions = documents.compactMap { (queryDocumentSnapshot) -> Mission? in
                
                print("missions init. missions.count: \(self.missions.count)")
                print("missions init. missions[0]: \(self.missions[0])")

                return try? queryDocumentSnapshot.data(as: Mission.self)
            }
            print("mVM err: \(err)")
        }
        print("mVM missions.count \(missions.count)")
        print("mVM fetchdata out")
    }
    
    func updateMissionProgress(missionId: Int) {

        db.collection("meeting_rooms").document("\(roomCode)").collection("users").document("\(nickname)")
            .addSnapshotListener { DocumentSnapshot, error in
                guard let document = DocumentSnapshot else {
                    print("Error fetching document: \(String(describing: error))")
                    return
                }
                guard var data = document["mission_progress"] as? [Bool] else {
                    return
                }
                data[missionId] = !data[missionId]
            }
    }
    
    func getMissionsStr(roleId: Int) -> [String] {
        self.fetchData(roleId: roleId)
        var missionsStr: [String] = []
        print("missions count: \(self.missions.count)")
        for mission in self.missions {
            missionsStr.append(mission.getMission())
        }
        return missionsStr
    }

}
