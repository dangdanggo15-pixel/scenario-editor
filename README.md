# Scenario Editor v0.1

웹에서 비주얼노벨/로드레일형 게임 시나리오를 쓰기 위한 초보자용 에디터.

## 들어있는 기능

- 캐릭터 등록 및 이름 수정
- 2열 대본 편집: CHARACTER / DIALOGUE
- `(독백)` 지원
- 대사 칸에서 `Tab`을 누르면 새 대사가 생성되고 **바로 이전 대사의 캐릭터가 자동 상속**됨
- 생성된 다음 행의 대사 칸으로 자동 포커스
- 선택지 블록과 Scene/Ending 연결
- 엔딩 라이브러리 (BAD END 20개 이상 확장 가능)
- 웹 안에서 간단한 분기 미리보기
- JSON 저장/불러오기
- Ink(`.ink`) export
- Unity용 zip export
- 기본적으로 브라우저 로컬 저장
- Supabase를 연결하면 계정 기반 PC ↔ 모바일 동기화

## 1. 실행

Node.js 20.19+ 환경에서:

```bash
npm install
npm run dev
```

개발 서버가 뜨면 표시된 주소를 브라우저에서 연다.

## 2. Replit에서 실행

이 폴더를 GitHub에 올린 뒤 Replit에서 GitHub 저장소를 Import하거나, zip을 업로드한다.

설치 후 Run 명령은:

```bash
npm run dev -- --host 0.0.0.0
```

Replit에서 포트 5173을 웹뷰로 연결하면 된다.

## 3. PC ↔ 모바일 동기화

지금 상태 그대로도 편집과 export는 사용 가능하지만, 브라우저 로컬 저장은 기기별이다.

동기화를 쓰려면 Supabase 프로젝트를 하나 만든 후 `supabase/schema.sql` 내용을 SQL Editor에서 한 번 실행한다.

그 다음 `.env.local`을 만들고:

```env
VITE_SUPABASE_URL=여기에_Project_URL
VITE_SUPABASE_PUBLISHABLE_KEY=여기에_Publishable_Key
```

를 넣는다.

Supabase Dashboard의 Connect 정보에서 Project URL과 publishable key를 확인할 수 있다.

앱 재실행 후 회원가입/로그인을 하면 같은 계정에서 프로젝트를 불러온다.

## 4. Unity 연결

`Unity Export .zip`을 누르면 아래 파일이 포함된다.

- `scenario.ink` : 시나리오 소스
- `scenario.json` : 에디터 원본 데이터 백업
- `characters.json` : 등장인물 목록
- `README_Unity.txt`

Ink의 공식 Unity integration은 `.ink` 파일을 Unity에서 자동 import/compile할 수 있다. 실제 게임 화면, 스탠딩 일러스트, 저장 UI 같은 최종 연출은 Unity 쪽 런타임에서 한 번 만들어야 한다.

## 5. 추천 개발 순서

1차 버전: 시나리오 작성기 + 클라우드 저장 + export

2차 버전: 이미지/표정 등록 + 스탠딩 자동 연결

3차 버전: Unity용 런타임 패키지까지 자동 생성해서 `scenario.ink`와 캐릭터 데이터를 넣으면 바로 게임 화면에서 재생

## GitHub Pages

This project includes a GitHub Actions workflow for GitHub Pages deployment.
After pushing the project to a repository's `main` branch:

1. Open **Settings → Pages**.
2. Under **Build and deployment → Source**, select **GitHub Actions**.
3. Pushes to `main` will build and deploy the Vite app.

The app uses a relative Vite base path so it works as a GitHub Pages project site.
