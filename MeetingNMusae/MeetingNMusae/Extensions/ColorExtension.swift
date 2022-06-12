//
//  ColorExtension.swift
//  MeetingNMusae
//
//  Created by 김태호 on 2022/06/12.
//

import SwiftUI

extension Color {
    init (hex: String) {
        // 문자열 파싱
        let scanner = Scanner(string: hex)
        // # 제거하는 부분
        _ = scanner.scanString("#")
        
        // 문자열을 Int64 타입으로 변환 후 rgb 변수 저장
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        // 문자열 추출 과정
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double((rgb >> 0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}

extension Color {
    static let musaeBlue = Color(hex: "67A4FF")
    static let musaeOrange = Color(hex: "FFAB7C")
    static let musaeMint = Color(hex: "8FEAC4")
    static let musaeGreen = Color(hex: "6ADE84")
    static let musaeLightGreen = Color(hex: "CBFF77")
    static let musaePurple = Color(hex: "C387FF")
    static let musaeSkyBlue = Color(hex: "9EE8FF")
    static let musaePink = Color(hex: "FFAED5")
    static let musaeRed = Color(hex: "FF8469")
    static let musaeMustard = Color(hex: "FFDE68")
}
