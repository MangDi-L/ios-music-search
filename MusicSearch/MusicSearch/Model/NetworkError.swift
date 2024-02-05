//
//  NetworkError.swift
//  MusicSearch
//
//  Created by mangdi on 2/5/24.
//

import Foundation

enum NetworkError: String, Error {
    case urlConvertError = "url변환 오류"
    case networkError = "네트워크 통신 오류"
    case responseError = "response 오류"
    case dataNilError = "데이터 오류"
    case decodeError = "디코딩 오류"
}
