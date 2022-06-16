//
//  SelectBox.swift
//  MeetingNMusae
//
//  Created by 김태호 on 2022/06/13.
//

import SwiftUI

struct SelectBox: View {
    let isDark: Bool
    var description: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(isDark ? .black : .white)
            Text(description)
                .font(.system(size: 18))
                .foregroundColor(isDark ? .white : .black)
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.black, lineWidth: 3)
            
        }
        .frame(height: 65)
        .padding(.horizontal, 24)
        
    }
}
