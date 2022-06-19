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
