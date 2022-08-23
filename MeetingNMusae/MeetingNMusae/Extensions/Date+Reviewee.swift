//
//  Date+Reviewee.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/08/03.
//

import Foundation

extension Date {
    // userIndex: 유저인덱스
    // totalUsers: 총 사람 명수
    static func getRevieweeIndex(userIndex: Int, totalUsers: Int) -> Int {
        var revieweeIndex = (userIndex + ((Int(Date.now.timeIntervalSince1970) / (60 * 60 * 24)) % totalUsers)) % totalUsers

        if revieweeIndex == userIndex {
            revieweeIndex = (revieweeIndex + 1) % totalUsers
        }
        return revieweeIndex
    }
}
