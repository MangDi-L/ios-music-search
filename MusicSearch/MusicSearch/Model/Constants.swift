//
//  Constants.swift
//  MusicSearch
//
//  Created by mangdi on 2/5/24.
//

import Foundation

enum UIConstants {
    static let defaultValue: CGFloat = 8
    static let highValue: CGFloat = 20
    static let defalutMultiplier: CGFloat = 1
    static let labelWidthMulitplier: CGFloat = 0.2
    static let imageViewHeightMultiplier: CGFloat = 0.3
}

enum NavigationBarText {
    static let title = "Music Search"
    static let rightBarButtonTitle = "최신순"
    static let searchBarPlaceHolder = "Enter the music title"
}

enum HTTPMethod {
    static let get = "GET"
}

enum Cell {
    static let mainTableViewCellIdentifier = "MainTableViewCell"
    static let searchResultCollectionViewCellIdentifier = "searchResultCollectionViewCell"
    static let cellHeightDevidingValue: CGFloat = 5
}

enum MusicApi {
    static let url = "https://itunes.apple.com/search?media=music&limit=200&country=KR&term="
}

enum MusicInformation {
    static let title = "Title"
    static let artist = "Artist"
    static let album = "Album"
    static let noExist = "-"
}

enum TimeConstants {
    static let thousand: Double = 1000
    static let sixty: Double = 60
}

enum Number {
    static let ten = 10
}

enum SystemImage {
    static let arrowUp = "arrowtriangle.up.square"
    static let arrowDown = "arrowtriangle.down.square"
}
