# TikTok 클론 앱

현대적인 Flutter 개발 방법론과 Firebase 백엔드 서비스를 활용하여 구축한 TikTok의 핵심 기능을 구현한 종합적인 Flutter 애플리케이션입니다.

## 📱 프로젝트 개요

이 프로젝트는 상태 관리, 반응형 디자인, 실시간 데이터 처리, 포괄적인 테스팅을 포함한 고급 Flutter 개발 개념을 보여주는 완전한 기능의 TikTok 클론입니다. 비디오 공유, 사용자 상호작용, 실시간 메시징을 제공하는 완전한 소셜 미디어 경험을 제공합니다.

## 🎯 학습 목표

이 프로젝트는 필수적인 Flutter 개발 개념들을 다룹니다:

- **Flutter Navigation**: 고급 라우팅 및 내비게이션 패턴
- **Responsive Design**: 다양한 화면 크기와 방향에 적응하는 UI
- **State Management**: 현대적인 패턴을 사용한 효율적인 앱 상태 관리
- **NoSQL Database**: Firestore를 활용한 실시간 데이터 관리
- **Architecture**: 깔끔하고 확장 가능한 앱 아키텍처
- **Testing**: Flutter 앱을 위한 포괄적인 테스팅 전략

## 🛠 기술 스택

### 핵심 기술

- **Flutter**: 크로스 플랫폼 모바일 개발 프레임워크
- **Firebase**: Backend-as-a-Service 플랫폼
- **Google Cloud Functions**: 서버리스 백엔드 로직
- **TypeScript**: Cloud Functions 개발

### 주요 패키지

- **Firebase Authentication**: 사용자 인증 및 권한 부여
- **Cloud Firestore**: NoSQL 실시간 데이터베이스
- **Cloud Storage**: 파일 및 미디어 저장소
- **Riverpod**: 현대적인 상태 관리 솔루션
- **GoRouter**: Flutter를 위한 선언적 라우팅
- **Camera**: 네이티브 카메라 통합
- **Firebase Messaging**: 푸시 알림

## ✨ 기능

### 👥 사용자 관리

- **이메일 인증**: 전통적인 이메일/비밀번호 로그인
- **소셜 로그인**: 소셜 플랫폼을 위한 OAuth 통합
- **커스텀 아바타**: 프로필 사진 업로드 및 관리
- **다이렉트 메시지**: 실시간 채팅 기능
- **푸시 알림**: 사용자 상호작용에 대한 즉시 알림

### 🎥 비디오 기능

- **커스텀 카메라**: 커스텀 컨트롤이 있는 네이티브 카메라 통합
- **비디오 녹화**: 편집 옵션이 있는 고품질 비디오 캡처
- **갤러리 선택기**: 기기 갤러리에서 미디어 선택
- **무한 스크롤**: 부드럽고 끝없는 비디오 피드
- **썸네일 추출**: 자동 비디오 썸네일 생성
- **좋아요 시스템**: 알림과 함께하는 실시간 좋아요/좋아요 취소 기능

### 🎨 향상된 사용자 경험

- **포괄적인 테스팅**: 단위, 위젯, 통합 테스트
- **부드러운 애니메이션**: 커스텀 애니메이션 및 전환 효과
- **반응형 디자인**: 휴대폰, 태블릿 및 다양한 방향에 최적화
- **국제화 (i18n)**: 다국어 지원
- **다크 모드**: 완전한 다크/라이트 테마 전환

## 🏗 아키텍처

앱은 명확한 관심사 분리와 함께 클린 아키텍처 원칙을 따릅니다:

```
lib/
├── features/           # 기능 기반 구조
│   ├── authentication/ # 사용자 인증 및 프로필 관리
│   ├── videos/         # 비디오 녹화, 재생 및 상호작용
│   ├── inbox/          # 다이렉트 메시징 및 알림
│   └── discover/       # 콘텐츠 발견 및 검색
├── common/             # 공유 유틸리티 및 위젯
├── constants/          # 앱 상수 및 구성
└── router/            # 내비게이션 및 라우팅 로직
```

## 🔥 Firebase 통합

### Cloud Functions

앱은 다음을 위해 서버리스 함수를 사용합니다:

- **좋아요 관리**: 자동 좋아요 수 업데이트
- **푸시 알림**: 실시간 알림 전달
- **데이터 검증**: 서버 측 데이터 무결성 검사

### Firestore 컬렉션

- `users/`: 사용자 프로필 및 환경설정
- `videos/`: 비디오 메타데이터 및 참여 지표
- `likes/`: 사용자-비디오 좋아요 관계
- `chats/`: 다이렉트 메시지 대화

## 🚀 시작하기

### 사전 요구사항

- Flutter SDK (최신 안정 버전)
- Firebase CLI
- Android Studio / VS Code
- Node.js (Cloud Functions용)

### 설치

1. **저장소 클론**

```bash
git clone https://github.com/yongyong-john/tiktokapp.git
cd tiktokapp
```

2. **Flutter 의존성 설치**

```bash
flutter pub get
```

3. **Firebase 설정**

```bash
firebase login
firebase init
```

4. **Flutter용 Firebase 구성**

```bash
flutterfire configure
```

5. **Cloud Functions 배포**

```bash
cd functions
npm install
firebase deploy --only functions
```

6. **애플리케이션 실행**

```bash
flutter run
```

## 📱 플랫폼 지원

- ✅ Android (API 23+)
- ✅ iOS (iOS 12.0+)
- 🔄 Web (개발 중)

## 🧪 테스팅

프로젝트는 포괄적인 테스팅을 포함합니다:

```bash
# 모든 테스트 실행
flutter test

# 커버리지와 함께 테스트 실행
flutter test --coverage

# 통합 테스트 실행
flutter drive --target=test_driver/app.dart
```

## 🌐 국제화

앱은 여러 언어를 지원합니다:

- 영어 (기본값)
- 한국어
- 추가 언어는 쉽게 추가할 수 있습니다

## 🎨 테마

- **라이트 모드**: 깔끔하고 현대적인 라이트 테마
- **다크 모드**: 적절한 대비를 가진 눈에 편한 다크 테마
- **반응형**: 시스템 환경설정에 적응

## 📚 참고 자료

- [Flutter 문서](https://docs.flutter.dev/)
- [Firebase 문서](https://firebase.google.com/docs)
- [Riverpod 문서](https://riverpod.dev/)
- [GoRouter 문서](https://pub.dev/packages/go_router)

---

**참고**: 이 프로젝트는 교육 목적이며 TikTok 또는 ByteDance와 관련이 없습니다.
