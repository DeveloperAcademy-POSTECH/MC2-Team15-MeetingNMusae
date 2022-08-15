//
//  Date+Reviewee.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/08/03.
//

import Foundation

extension Date {
    // index: 유저인덱스
    // num: 총 사람 명수
    static func getRevieweeIndex(index: Int, num: Int) -> Int {
        var revieweeIndex = (index + ((Int(Date.now.timeIntervalSince1970) / (60 * 60 * 24)) % num)) % num

        if revieweeIndex == index {
            revieweeIndex = (revieweeIndex + 1) % num
        }
        return revieweeIndex
    }
}
