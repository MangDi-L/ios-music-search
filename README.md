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
  - `DiskCaching`, `MemoryCaching`
  - `CoreData`

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
│   ├── FavoriteMusicEntity+CoreDataClass.swift
│   ├── FavoriteMusicEntity+CoreDataProperties.swift
│   ├── FavoriteMusicModel.xcdatamodeld
│   │   └── FavoriteMusicModel.xcdatamodel
│   │       └── contents
│   ├── MusicSearch
│   │   ├── AppDelegate.swift
│   │   ├── Controller
│   │   │   ├── DetailViewController.swift
│   │   │   ├── FavoriteDetailViewController.swift
│   │   │   ├── FavoriteViewController.swift
│   │   │   ├── MainViewController.swift
│   │   │   └── SearchResultViewController.swift
│   │   ├── Info.plist
│   │   ├── Model
│   │   │   ├── Constants.swift
│   │   │   ├── CoreDataManager.swift
│   │   │   ├── Extension
│   │   │   │   ├── Double+Extension.swift
│   │   │   │   ├── String+Extension.swift
│   │   │   │   ├── UIColor+Extension.swift
│   │   │   │   └── UIImageView+Extension.swift
│   │   │   ├── FavoriteMusic.swift
│   │   │   ├── ImageCacheManager.swift
│   │   │   ├── MusicModel.swift
│   │   │   ├── NetworkError.swift
│   │   │   └── NetworkManager.swift
│   │   ├── SceneDelegate.swift
│   │   └── View
│   │       ├── FavoriteTableViewCell.swift
│   │       ├── MainTableViewCell.swift
│   │       └── SearchResultCollectionViewCell.swift
│   ├── Podfile
│   ├── Podfile.lock
│   └── Pods
└── README.md
```
 
## ⏰ 타임라인

<details>
<summary>2024년 02월 01일</summary>

- 프로젝트 생성 및 .gitignore설정
</details>

<details>
<summary>2024년 02월 02일</summary>

 - SwiftLint 라이브러리 적용 및 오류 해결
</details>

<details>
<summary>2024년 02월 05일</summary>

- 메인UITableView 구현
- MainTableViewCell 커스텀셀 구현
- JSON Decoing 모델 MusicModel 타입 구현
 - iTunes API와 통신하는 NetworkManager타입 구현
 - NetworkError타입 구현
 - 검색결과 보여주는 SearchResultVC 구현
 - UISearchResultsUpdating 채택 및 구현
</details>

<details>
<summary>2024년 02월 06일</summary>

- 음악 상세정보 보여주는 DetailVC 구현
</details>

<details>
<summary>2024년 02월 07일</summary>

- SearchResultCollectionViewCell 커스텀셀 구현
 - 음악리스트를 최신순 혹은 오래된순으로 정렬해서 볼수있도록 커스텀 rightBarButtonItem 구현
- 메인테이블뷰랑 검색컬렉션뷰가 정렬 공유하도록 구현
</details>

<details>
<summary>2024년 02월 08일</summary>

- Xcode버전 업데이트후 시뮬레이터 키보드관련 오류 해결
- UIColor확장파일 생성 및 hex값으로 색 넣도록 구현
- detailVC에서 더보기버튼누를시 메인테이블뷰에서 검색하도록 구현
- 이미지 받아올동안 loadingIndicator 돌아가도록 구현
</details>

<details>
<summary>2024년 02월 09일</summary>

- 키보드 올리고 내릴시 테이블뷰 및 컬렉션뷰 유연하게 바뀌도록 구현
- 테이블셀들의 크기가 약간 달랐던이슈 해결
</details>

<details>
<summary>2024년 02월 12일</summary>

- Api통신으로 받아온 이미지 메모리캐싱 및 디스크캐싱 구현
</details>

<details>
<summary>2024년 02월 13일</summary>

- 최근검색내역을 UserDefaults로 저장하고 앱실행시 기본검색하도록 구현
- 다크모드 지원하도록 구현
- favorite탭바 구현 및 FavoriteVC구현
- favorite에 추가한 음악전용 CoreDataModel 생성
</details>

<details>
<summary>2024년 02월 14일</summary>

- CoreDataManager 생성 및 Entity 데이터들 받도록 구현
</details>

<details>
<summary>2024년 02월 15일</summary>

- 원하는음악 favorite 코어데이터에 추가 및 삭제하도록 Insert, Delete 구현
- FavoriteDetailVC에서 노래더보기누르면 탭바이동후 MainVC에서 검색하도록 구현
</details>

<details>
<summary>2024년 02월 16일</summary>

- 코드 간결하게 리팩토리 진행
- favorite에 추가할때 토스트메시지보여주도록 구현
</details>
    


## 📱 실행 화면
추가예정
    

## 👀 고민한 점


- **검색리스트를 날짜순으로 보게해주는 버튼의 구현**  

  <details>
  <summary>내용</summary>

  - 처음에 메인테이블뷰에서 음악리스트를 날짜순으로 보여주는것을 구현하는건 쉬웠습니다.  
  - 그런데 searchbar의 검색결과로 나타나는 컬렉션뷰의 음악리스트들을 날짜순으로 어떻게 나열해서 보여줄수 있을까 고민했습니다.
  - 게다가 메인테이블뷰와 검색결과인 컬렉션뷰가 같은 정렬을 공유해야하는데 이것에 대해서도 고민했습니다.  
  - 결국 몇번의 삽질 끝에 searchResultVC 인스턴스를 MainVC가 갖도록 만들고, 정렬 버튼을 누를때 둘다 동시에 정렬되게끔 구현할 수 있었습니다.
  </details>


- **검색리스트를 날짜순으로 보게해주는 버튼의 위치**  

  <details>
  <summary>내용</summary>

  - 처음 음악리스트를 보여주는 mainVC과 searchbar검색후에 음악리스트를 보여주는 searchResultVC 둘 다 날짜순으로 정렬하는걸 공유하는 버튼의 위치를 어디로 잡아야할지 고민했습니다.
  - 두 VC의 공통점이 같은 네비게이션바를 공유한다는점을 이용하여 네비게이션바에 UIBarButtonItem을 생성하여 구현해주었습니다.
  
  </details>

- **코어데이터 이미지저장은 어떻게할건지에 대한 고민⭐⭐**
  - 노래 검색하면 API통신으로 받아온 이미지들은 디스크캐싱 및 메모리캐싱으로 해결했지만 즐겨찾기(favorite)에 추가한 노래들은 CoreDataModel이기때문에 이미지를 어떻게 처리해야할지 고민했습니다.
  - API통신으로 받아온이미지들을 처리한것과 동일하게 디스크캐싱 및 메모리캐싱으로 해결할 수 있었지만 CoreData를 사용하고있으니 이를 응용해서 새로운방법으로 처리하고싶었습니다.
  - 아래 링크에있는 문서를 참고하여 알아낸 바로, 이미지나 사운드같은 BLOB(Binary Large OBject)데이터들은 파일시스템의 리소스로 저장하여 해당 리소스에 대한 URL이나 Path같은 링크를 이용하는것을 추천했습니다. 위에서말한 디스크캐싱같은 방식을 말한것같습니다.   
[Apple CoreData Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreData/Performance.html#//apple_ref/doc/uid/TP40001075-CH25-SW11)
  - 하지만 코어데이터에 `Allows External Storage`라는 기능이 있습니다.  
이 기능은 IOS 5.0때부터 제공했던기능으로, 이미지 데이터의 크기를 직접 가늠하여 데이터베이스에 저장해야할지, 또는 URI를 관리하는 별도의 파일에 저장할지 결정합니다.  
이미지 썸네일같은 작은 데이터들은 데이터베이스에 효율적으로 저장할 수 있지만 4K이미지나 기타 미디어데이터같이 큰 데이터는 파일시스템에서 처리하는것이 가장 좋다고합니다.
  - 다행스럽게도 즐겨찾기(favorite)에서 다루는 이미지는 썸네일이미지면서도 작은 데이터( 10000Byte ~ 30000Byte  == 0.01Mb ~ 0.03Mb)를 다루었습니다.
  - 그렇다면 `Allows External Storage`를 이용한 코어데이터 데이터베이스에 이미지크기가 클경우와 작을경우 어떻게 저장될까 궁금하여 알아보았습니다.  
이미지크기가 작을경우 위에서 말한대로 데이터베이스에 저장되고(11017바이트)
![이미지가 작은경우](https://github.com/MangDi-L/ios-music-search/assets/49121469/d3662080-71d1-409e-bb87-ee474d642dab)  
이미지크기가 클경우 별도의 파일에 저장하여 그 경로를 참조하는 바이너리데이터가 저장된걸 알 수 있었습니다.(38바이트)
![이미지가 클경우](https://github.com/MangDi-L/ios-music-search/assets/49121469/4ae1e219-2161-40b7-895e-053e42f968f0)  
크기가 큰 이미지는 이 경로에 저장됩니다. (_EXTERNAL_DATA)
![이미지클경우 저장되는곳](https://github.com/MangDi-L/ios-music-search/assets/49121469/63f7b8ea-3b87-49b7-bf1d-29ac350c4af1)  
[이미지 출처](https://fluffy.es/store-image-coredata/)
  - 결론적으로 기존의 디스크캐싱방식이 아닌 새로운방식인 CoreData의 `Allows External Storage`기능을 이용하는것에 문제가 없다는것을 확인한 후 즐겨찾기(favorite)의 이미지처리를 했습니다. 


    
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

- **FavoriteDetailVC에서 노래더보기버튼 누를때 경고 나타나는 이슈**
  - 즐겨찾기(favorite)탭에 셀 클릭후 나타나는 detail화면에서 노래더보기 버튼 누를시 아래와 같은 경고가 출력되었습니다.
    <details>
    <summary>경고 콘솔</summary>

    `Warning once only: UITableView was told to layout its visible cells and other contents without being in the view hierarchy (the table view or one of its superviews has not been added to a window). This may cause bugs by forcing views inside the table view to load and perform layout without accurate information (e.g. table view bounds, trait collection, layout margins, safe area insets, etc), and will also cause unnecessary performance overhead due to extra layout passes. Make a symbolic breakpoint at UITableViewAlertForLayoutOutsideViewHierarchy to catch this in the debugger and see what caused this to occur, so you can avoid this action altogether if possible, or defer it until the table view has been added to a window. Table view: <UITableView: 0x105027800; frame = (0 201.667; 393 567.333); clipsToBounds = YES; gestureRecognizers = <NSArray: 0x600000ca0840>; backgroundColor = <UIDynamicSystemColor: 0x60000176fe00; name = tableBackgroundColor>; layer = <CALayer: 0x600000246140>; contentOffset: {0, 0}; contentSize: {393, 0}; adjustedContentInset: {0, 0, 0, 0}; dataSource: <MusicSearch.MainViewController: 0x10441a890>>`
  
     </details>
  - 이 버튼은 누를시 현재 2번째 탭바에서 1번째 탭바로 이동해서 MainVC의 SearchBar에 노래검색을 해주는데 그 과정에서 이런 경고창이 나타나는 이슈가 발생했습니다.
  - 경고창의 내용을 읽어보며 코드를 몇번 고치고 LLDB를 이용하며 실험한 결과 아래 코드가 경고를 유발하는것을 알게되었습니다.
    ```swift
    ...
    mainVC.mainTableView.reloadData()
    ```
  - favoriteDetailVC에서 mainVC의 테이블뷰에 reloadData()를 요청한것이 원인이었는데 그 이유는 아직 mainVC의 테이블뷰가 윈도우에 추가되지 않아서 테이블뷰 내부의 셀이 테이블뷰 자체가 불안정한 상태에서 레이아웃을 강제함으로써 버그를 유발할 수 있음을 경고콘솔로 알려주는것이었습니다.
  - 이 경고창이 떠도 정상작동은 하지만 좋은 현상은 아니기에 코드를 고쳐 이 이슈를 해결하였습니다.




## 🔗 참고 링크
[Xcode버전업데이트후 앱시뮬레이터 키보드 이슈](https://jangsh9611.tistory.com/50)  
[인프런 - 앨런의 앱만들기강의](https://www.inflearn.com/course/%EC%8A%A4%EC%9C%84%ED%94%84%ED%8A%B8-%EB%AC%B8%EB%B2%95-%EB%A7%88%EC%8A%A4%ED%84%B0-%EC%8A%A4%EC%BF%A8-%EC%95%B1%EB%A7%8C%EB%93%A4%EA%B8%B0/dashboard)  
[StackOverFlow - UISearchController에 연결된 뷰컨에서 NavigationController로 push해서 화면 이동하는 방법](https://stackoverflow.com/questions/53983908/ios-swift-4-how-to-push-uisearchcontroller-in-a-navigationcontroller)   
[Apple CoreData Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreData/Performance.html#//apple_ref/doc/uid/TP40001075-CH25-SW11)  
[How to store image into CoreData](https://fluffy.es/store-image-coredata/)

---

[🔝 맨 위로 이동하기](#-음악-검색)


---
