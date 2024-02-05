//
//  Constants.swift
//  MusicSearch
//
//  Created by mangdi on 2/5/24.
//

import Foundation

enum UIConstants {
    static let defaultValue: CGFloat = 8
}

enum HTTPMethod {
    static let get = "GET"
}

enum Cell {
    static let mainTableViewCellIdentifier = "MainTableViewCell"
    static let cellHeightDevidingValue: CGFloat = 5
}

enum MusicApi {
    static let url = "https://itunes.apple.com/search?media=music&term="
}
