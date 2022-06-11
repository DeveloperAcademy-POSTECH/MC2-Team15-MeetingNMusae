//
//  Review.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/10.
//

class Review {
    private var content: String
    private var from: String
    private var to: String
    
    enum CodingKeys: String, CodingKey {
        case content
        case from
        case to
    }
    
    init(content: String, from: String, to: String) {
        self.content = content
        self.from = from
        self.to = to
    }
}
