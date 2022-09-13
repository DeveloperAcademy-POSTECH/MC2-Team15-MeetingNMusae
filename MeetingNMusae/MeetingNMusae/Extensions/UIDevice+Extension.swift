//
//  UIApplication+Extension.swift
//  MeetingNMusae
//
//  Created by taekkim on 2022/08/29.
//

import UIKit

extension UIDevice {
    /// Returns `true` if the device has a notch
    static var hasSafeArea: Bool {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first

        if UIDevice.current.orientation.isPortrait {
            return window?.safeAreaInsets.top ?? 0 >= 44
        } else {
            return window?.safeAreaInsets.left ?? 0 > 0 || window?.safeAreaInsets.right ?? 0 > 0
        }
    }
}
