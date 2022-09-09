//
//  HelpView.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/09/07.
//

import SwiftUI

struct HelpView: View {
    @State var currentTab: Int = 1
    @State var remainTime: Int = 3
    
    var body: some View {
        TabView(selection: $currentTab) {
            ForEach(1...6, id: \.self) { i in
                Image("help-\(i)")
                    .ignoresSafeArea()
            }
        }
        .transition(.slide)
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    if currentTab < 6 {
                        currentTab += 1
                    }
                }, label: {
                    Text(currentTab >= 6 ? "Done" : "Next")
                })
                .disabled(currentTab >= 6)
            }
        }
        .task(timer)
    }
    
    @Sendable private func timer() async {
        while currentTab < 6 {
            remainTime = 3
            while remainTime > 0 {
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                remainTime -= 1
            }
            currentTab += 1
        }
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
