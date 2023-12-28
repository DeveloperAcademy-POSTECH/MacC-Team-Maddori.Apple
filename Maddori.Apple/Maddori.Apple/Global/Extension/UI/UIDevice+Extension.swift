//
//  UIDevice+Extension.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/25.
//

import AVFoundation
import UIKit

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(1519)
    }
}
