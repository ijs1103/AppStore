# AppStore

![Simulator Screen Recording - iPod touch (7th generation) - 2023-02-13 at 20 04 38](https://user-images.githubusercontent.com/42196410/218442620-5690ce8d-64e1-486a-911c-6e3ab4c2e466.gif)


## 🧩 개요

- PList 더미데이터 사용
- KingFisher, Snapkit 라이브러리 사용
- 코드로 UICollectionView  구현
- UIActivityViewController로 공유하기 기능 

## 🤔 배운 내용

### ✔️ 복잡한 레이아웃

- `UIScrollView > UIStackView > 2개의 UICollectionView` 구조

<img width="780" alt="image" src="https://user-images.githubusercontent.com/42196410/218444219-1693f901-b961-490d-b9d1-78c7f0ca7bdc.png">


### ✔️ 공유하기 기능

- AirDrop, SMS, 이메일 등 다른 앱으로 공유할 수 있는 `UIActivityViewController`를 사용

- `activityItems`는 앱에서 공유할 컨텐츠, `applicationActivities`는 공유될 목적지

```swift
init(activityItems: [Any], applicationActivities: [UIActivity]?)
```
