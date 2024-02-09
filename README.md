# 🎶 음악 검색

## 📖 목차
1. [소개](#-소개)
2. [파일 tree](#-파일-tree)
3. [타임라인](#-타임라인)
4. [실행 화면](#-실행-화면)
5. [고민한 점](#-고민한-점)
6. [트러블 슈팅](#-트러블-슈팅)
7. [참고 링크](#-참고-링크)

## 🌱 소개

`Mangdi`가 만든 `음악 검색 앱` 입니다.  
`iTunes Search API`를 이용해서 제작했습니다.  
사용자가 가수나 노래 제목을 검색할 수 있는 간단한 앱입니다.  
검색리스트는 최신순 혹은 오래된순으로 나열해서 볼 수 있으며  
상세화면에서는 제목, 가수, 앨범, 노래재생시간, 출시년도를 보여줍니다.  
[iTunes api 문서](https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/iTuneSearchAPI/Searching.html#//apple_ref/doc/uid/TP40017632-CH5-SW1)

- **KeyWords**
  - `UISearchController`, `UISearchResultsUpdating`
  - `URLSessionDataTask`, `NotificationCenter`
  - `UITableViewDataSource`, `UITableViewDelegate`
  - `UICollectionViewDataSource`, `UICollectionViewDelegate`

## 💻 개발환경 및 라이브러리
[![swift](https://img.shields.io/badge/swift-5.9.2-orange)]()
[![xcode](https://img.shields.io/badge/Xcode-15.2-blue)]()

## 🛒 사용 기술 스택
|UI구현|아키텍처|의존성관리도구|라이브러리
|:--:|:--:|:--:|:--:|
|UIKit|MVC|CocoaPods|SwiftLint|

## 🧑🏻‍💻 팀원
|<img src="https://avatars.githubusercontent.com/u/49121469" width=160>|
|:--:|
|[Mangdi](https://github.com/MangDi-L)|

## 🌲 파일 tree

```
.
├── MusicSearch
│   ├── Base.lproj
│   │   ├── LaunchScreen.storyboard
│   │   └── Main.storyboard
│   ├── MusicSearch
│   │   ├── AppDelegate.swift
│   │   ├── Controller
│   │   │   ├── DetailViewController.swift
│   │   │   ├── MainViewController.swift
│   │   │   └── SearchResultViewController.swift
│   │   ├── Info.plist
│   │   ├── Model
│   │   │   ├── Constants.swift
│   │   │   ├── Extension
│   │   │   │   └── UIColor+Extension.swift
│   │   │   ├── MusicModel.swift
│   │   │   ├── NetworkError.swift
│   │   │   └── NetworkManager.swift
│   │   ├── SceneDelegate.swift
│   │   └── View
│   │       ├── MainTableViewCell.swift
│   │       └── SearchResultCollectionViewCell.swift
│   ├── Podfile
│   ├── Podfile.lock
│   └── Pods
└── README.md


```
 
## ⏰ 타임라인

    
- **24/02/01**
    - 프로젝트 생성 및 .gitignore설정

- **24/02/02**
    - SwiftLint 라이브러리 적용 및 오류 해결

- **24/02/05**
    - 메인UITableView 구현
    - MainTableViewCell 커스텀셀 구현
    - JSON Decoing 모델 MusicModel 타입 구현
    - iTunes API와 통신하는 NetworkManager타입 구현
    - NetworkError타입 구현
    - 검색결과 보여주는 SearchResultVC 구현
    - UISearchResultsUpdating 채택 및 구현

- **24/02/06**
    - 음악 상세정보 보여주는 DetailVC 구현

- **24/02/07**
    - SearchResultCollectionViewCell 커스텀셀 구현
    - 음악리스트를 최신순 혹은 오래된순으로 정렬해서 볼수있도록 커스텀 rightBarButtonItem 구현
    - 메인테이블뷰랑 검색컬렉션뷰가 정렬 공유하도록 구현

- **24/02/08**
    - Xcode버전 업데이트후 시뮬레이터 키보드관련 오류 해결
    - UIColor확장파일 생성 및 hex값으로 색 넣도록 구현
    - detailVC에서 더보기버튼누를시 메인테이블뷰에서 검색하도록 구현
    - 이미지 받아올동안 loadingIndicator 돌아가도록 구현

- **24/02/09**
    - 키보드 올리고 내릴시 테이블뷰 및 컬렉션뷰 유연하게 바뀌도록 구현
    - 테이블셀들의 크기가 약간 달랐던이슈 해결
    


## 📱 실행 화면
추가예정
    

## 👀 고민한 점


- **검색리스트를 날짜순으로 보게해주는 버튼의 구현**  
  - 처음에 메인테이블뷰에서 음악리스트를 날짜순으로 보여주는것을 구현하는건 쉬웠습니다.  
  - 그런데 searchbar의 검색결과로 나타나는 컬렉션뷰의 음악리스트들을 날짜순으로 어떻게 나열해서 보여줄수 있을까 고민했습니다.
  - 게다가 메인테이블뷰와 검색결과인 컬렉션뷰가 같은 정렬을 공유해야하는데 이것에 대해서도 고민했습니다.  
  - 결국 몇번의 삽질 끝에 searchResultVC 인스턴스를 MainVC가 갖도록 만들고, 정렬 버튼을 누를때 둘다 동시에 정렬되게끔 구현할 수 있었습니다.

- **검색리스트를 날짜순으로 보게해주는 버튼의 위치**  
  - 처음 음악리스트를 보여주는 mainVC과 searchbar검색후에 음악리스트를 보여주는 searchResultVC 둘 다 날짜순으로 정렬하는걸 공유하는 버튼의 위치를 어디로 잡아야할지 고민했습니다.
  - 두 VC의 공통점이 같은 네비게이션바를 공유한다는점을 이용하여 네비게이션바에 UIBarButtonItem을 생성하여 구현해주었습니다.

    
## ❓ 트러블 슈팅

- **앱시뮬레이터의 searchbar 한글 모음자음이 떨어지는 이슈**  
  - 시뮬레이터로 searchbar에 한글로 검색하면 모음,자음이 떨어져나가는것을 확인했습니다.  
  - 이를 해결하려고 검색을 열심히했지만 해결방법이 나오지않았습니다.  
  - 결국 개발자모임방에 물어봐서 안 사실로 시뮬레이터 자체의 한계?점으로 한글을 붙여넣거나 또는 실기기에서 테스트하는것으로 해결할 수 있었습니다.

- **Xcode버전업데이트후 앱시뮬레이터 키보드 이슈**  
  - searchbar를 누르고 키보드가 올라올때 아래와같은 메시지와함께 멈추는 현상이 발생했습니다.  
  - `-[UIKeyboardTaskQueue lockWhenReadyForMainThread] timeout waiting for task on queue`   
  - 검색하고 알게된사실이 키보드의 '수정 제안' 부분에서 오류가 발생한 모양이었습니다.  
  - 아래와 같이 코드를 써주고나서 멈추는현상은 해결되었습니다.
  ```swift
  mainSearchController.searchBar.autocorrectionType = .no
  mainSearchController.searchBar.spellCheckingType = .no
  ```

- **UISearchController에 연결된 뷰컨에서 NavigationController로 push해서 화면 이동하는 방법**
  - searchbar검색후에 보여주는 VC에서 컬렉션뷰 셀 클릭시 detailVC으로 push이동하도록 구현하려고했는데 
  ```swift
  navigationController?.pushViewController(detailVC, animated: true)
  ```
  - 위와같은 코드가 동작하지않아서 UISearchController에 연결된 VC에는 다른방식으로 동작하는것인지 찾아보았습니다.
  ```swift
  presentingViewController?.navigationController?.pushViewController(detailVC, animated: true)
  ```
  - 결국 위 코드를 입력하여 문제를 해결했습니다.
  - UISearchController에 연결된 searchResultVC에서 자신을 나타내주는 presentingViewController를 호출해주어야 가능했습니다.




## 🔗 참고 링크
[Xcode버전업데이트후 앱시뮬레이터 키보드 이슈](https://jangsh9611.tistory.com/50)  
[인프런 - 앨런의 앱만들기강의](https://www.inflearn.com/course/%EC%8A%A4%EC%9C%84%ED%94%84%ED%8A%B8-%EB%AC%B8%EB%B2%95-%EB%A7%88%EC%8A%A4%ED%84%B0-%EC%8A%A4%EC%BF%A8-%EC%95%B1%EB%A7%8C%EB%93%A4%EA%B8%B0/dashboard)  
[StackOverFlow - UISearchController에 연결된 뷰컨에서 NavigationController로 push해서 화면 이동하는 방법](https://stackoverflow.com/questions/53983908/ios-swift-4-how-to-push-uisearchcontroller-in-a-navigationcontroller)

---

[🔝 맨 위로 이동하기](#-음악-검색)


---
