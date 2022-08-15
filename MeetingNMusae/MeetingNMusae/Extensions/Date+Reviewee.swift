//
//  Date+Reviewee.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/08/03.
//

import Foundation

extension Date {
    static func getRevieweeIndex(index: Int, num: Int) -> Int {
        // 자정에 하면 클남
        
        var revieweeIndex = (index + Int(Date.now.timeIntervalSince1970)) / (60 * 60 * 24) % num
        
        while revieweeIndex == index {
            revieweeIndex = (index + Int(Date.now.timeIntervalSince1970)) / (60 * 60 * 24) % num
        }
        return revieweeIndex
    }
}
