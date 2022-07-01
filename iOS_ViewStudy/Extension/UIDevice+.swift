//
//  UIDevice+.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/07/01.
//

import UIKit
import AVFoundation

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
