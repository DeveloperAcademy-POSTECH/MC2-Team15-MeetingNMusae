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
    @Environment(\.presentationMode) var presentationMode
    private let closebtnTopPadding = UIScreen.screenHeight * 0.014
    private let helpImageTopPadding = UIScreen.screenHeight * 0.073
    private let helpImagebottomPadding = UIScreen.screenHeight * 0.057
    private let bottomPadding = UIScreen.screenHeight * 0.116
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image("btn_close")
                        .resizable()
                        .frame(width: UIScreen.screenWidth * 0.0718, height: UIScreen.screenWidth * 0.0718)
                        .offset(x: -4, y: 0)
                })
                Spacer()
            }
            .padding(.leading, 24)
            .padding(.top, closebtnTopPadding)
            
            TabView(selection: $currentTab) {
                ForEach(1...6, id: \.self) { i in
                    Image("help-\(i)")
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom, helpImagebottomPadding)
                }

                
            }
            .transition(.slide)
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .never))
            .onAppear {
                setupAppearance()
            }
            .onChange(of: currentTab) { _ in
                print("called")
                remainTime = 3
            }
            .padding(.bottom, bottomPadding)
            .task(timer)
        }
        .navigationBarHidden(true)
        
    }
    
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
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
