//
//  Double+Extension.swift
//  MusicSearch
//
//  Created by mangdi on 2/15/24.
//

import Foundation

extension Double {
    func calculateMusicPlayTime() -> String {
        var seconds = roundl(self / TimeConstants.thousand)
        let minutes = seconds / TimeConstants.sixty
        seconds = Double(Int(seconds) % Int(TimeConstants.sixty))
        if Int(seconds) < Number.ten {
            return "\(Int(minutes)):0\(String(Int(seconds)))"
        } else {
            return "\(Int(minutes)):\(Int(seconds))"
        }
    }
}
