//
//  String+Extension.swift
//  MusicSearch
//
//  Created by mangdi on 2/16/24.
//

import Foundation

extension String {
    var releaseDateToString: Self {
        guard let isoDate = ISO8601DateFormatter().date(from: self) else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: isoDate)
        return date
    }
}
