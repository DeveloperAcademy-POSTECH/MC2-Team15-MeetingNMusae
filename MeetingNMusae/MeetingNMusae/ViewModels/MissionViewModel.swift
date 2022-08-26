import FirebaseFirestore
import FirebaseFirestoreSwift

class MissionViewModel: ObservableObject {
    @Published var missionStrs: [String]
    
    init() {
        self.missionStrs = []
    }

    private var db = Firestore.firestore()

    func fetchMissions(roleId: Int) {
        db.collection("missions").whereField("role_id", isEqualTo: roleId)
            .addSnapshotListener { (querySnapshot, _ ) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                var missions: [Mission] = documents.compactMap { (queryDocumentSnapshot) -> Mission? in
                return try? queryDocumentSnapshot.data(as: Mission.self)
                }
                // id에 따라 순서 정렬
                missions.sort()
                self.missionStrs = []
                for mission in missions {
                    self.missionStrs.append(mission.getMission())
                }
            }
    }
}
