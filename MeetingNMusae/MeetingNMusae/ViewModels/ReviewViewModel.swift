import FirebaseFirestore
import FirebaseFirestoreSwift

class ReviewViewModel: ObservableObject {
    @Published var reviews: [Review]

    init() {
        reviews = [Review]()
    }

    private var db = Firestore.firestore()
    
//    func fetchData(roomCode: String) {
//        db.collection("reviews").document("YJ62iSRYbkAMIZ0DpJKp")
//            .addSnapshotListener { documentSnapshot, error in
//              guard let document = documentSnapshot else {
//                print("Error fetching document: \(error!)")
//                return
//              }
//              guard let data = document.data() else {
//                print("Document data was empty.")
//                return
//              }
//              print("Current data: \(data)")
//            }
//    }

    func fetchData(roomCode: String) {
        db.collection("reviews").whereField("room_code", isEqualTo: "\(roomCode)").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("Error Fetching document: \(error!)")
                return
            }

            self.reviews = documents.compactMap { (queryDocumentSnapshot) -> Review? in
                return try? queryDocumentSnapshot.data(as: Review.self)
            }
        }
    }
    
    func getReviewee(roomCode: String, nickname: String) {
        db.collection("reviews").whereField("from", isEqualTo: "\(nickname)").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("Error Fetching document: \(error!)")
                return
            }

            self.reviews = documents.compactMap { (queryDocumentSnapshot) -> Review? in
                return try? queryDocumentSnapshot.data(as: Review.self)
            }
        }
    }
    
    func addReview(review: Review) {
        do {
//            _ = try db.collection("reivews").document("\(review.roomCode)").setData(from: review)
            _ = try db.collection("reviews").addDocument(from: review)
        } catch {
            print(error)
            return
        }
    }
}
