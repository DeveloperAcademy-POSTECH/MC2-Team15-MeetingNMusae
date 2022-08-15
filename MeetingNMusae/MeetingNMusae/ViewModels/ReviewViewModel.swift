//
//  ReviewViewModel.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/20.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

class ReviewViewModel: ObservableObject {
    @Published var reviews: [Review]

    init() {
        reviews = [Review]()
    }

    private var db = Firestore.firestore()

    func fetchData(roomCode: String) {
        db.collection("reviews").whereField("room_code", isEqualTo: roomCode).addSnapshotListener { (querySnapshot, _) in
            guard let documents = querySnapshot?.documents else {
                print("no documents")
                return
            }
            self.reviews = documents.compactMap { (queryDocumentSnapshot) -> Review? in
                return try? queryDocumentSnapshot.data(as: Review.self)
            }
        }
    }
    
    func getReviewee(roomCode: String, nickname: String) {
        db.collection("reviews").whereField("room_code", isEqualTo: roomCode).whereField("from", isEqualTo: "\(nickname)").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("Error Fetching document: \(error!)")
                return
            }
            
            self.reviews = documents.compactMap { (queryDocumentSnapshot) -> Review? in
                return try? queryDocumentSnapshot.data(as: Review.self)
            }
        }
    }
    
    func setReviewee(roomCode: String, nickname: String, review: Review) {
        try? db.collection("reviews").addDocument(from: review)
    }
    
    func deleteReviews(roomCode: String) {
        db.collection("reviews").whereField("room_code", isEqualTo: roomCode).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    document.reference.delete()
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
}
