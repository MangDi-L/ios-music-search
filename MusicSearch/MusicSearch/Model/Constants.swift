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
    static let moreSingerButtonConerRadius: CGFloat = 15
}

enum NavigationBarText {
    static let firstTitle = "Music Search"
    static let secondTitle = "Favorite"
    static let rightBarButtonTitle = "최신순"
    static let searchBarPlaceHolder = "Enter the music title"
}

enum HTTPMethod {
    static let get = "GET"
}

enum Cell {
    static let mainTableViewCellIdentifier = "MainTableViewCell"
    static let searchResultCollectionViewCellIdentifier = "searchResultCollectionViewCell"
    static let tableCellHeightDevidingValue: CGFloat = 7
}

enum MusicApi {
    static let url = "https://itunes.apple.com/search?media=music&limit=200&country=KR&term="
}

enum Keys {
    static let searchbarTextKey = "searchbarTextKey"
}

enum MusicInformation {
    static let title = "Title"
    static let artist = "Artist"
    static let album = "Album"
    static let noExist = "-"
    static let moreSinger = "의 노래더보기"
}

enum TimeConstants {
    static let thousand: Double = 1000
    static let sixty: Double = 60
}

enum Number {
    static let one = 1
    static let two = 2
    static let three = 3
    static let fourPointFive = 4.5
    static let eight = 8
    static let ten = 10
}

enum SystemImage {
    static let arrowUp = "arrowtriangle.up.square"
    static let arrowDown = "arrowtriangle.down.square"
    static let search = "magnifyingglass"
    static let heart = "heart"
}

enum UIColorExtension {
    static let moreSingerButtonHex = "#34ebde"
    static let moreSingerButtonAlpha = 0.5
}

enum AnimationTimeConstants {
    static let basic = 0.2
}

enum TabbarItemTitle {
    static let first = "Music Search"
    static let second = "Favorite"
}
