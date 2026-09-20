# Scenario Editor v0.3

웹에서 비주얼노벨/로드레일형 게임 시나리오를 쓰기 위한 에디터.

## 기능

- 캐릭터 등록 및 이름 수정
- 2열 대본 편집: CHARACTER / DIALOGUE
- `(독백)` 지원
- 대사 칸에서 `Tab` → 새 대사 생성 + 바로 이전 대사의 캐릭터 자동 상속 + 새 대사칸 포커스
- 선택지 블록과 Scene/Ending 연결
- **반응형 선택지**: 선택지마다 1줄의 즉시 반응 대사를 넣고 같은 방식으로 지정한 Scene/Ending으로 이어지게 할 수 있음
- 배드 엔딩 라이브러리
- 웹 안에서 분기 미리보기
- JSON 저장/불러오기
- Ink(`.ink`) export
- Unity용 zip export
- 기본 브라우저 로컬 저장
- **Supabase Auth + DB로 PC ↔ 모바일 클라우드 저장**
- 모바일 전용 메뉴/씬 선택/동기화 패널

## 개발 환경

Node.js 20.19+ 권장.

```bash
npm install
npm run dev
```

## Supabase 연결

Supabase 공식 React 가이드는 Vite 앱에서 `VITE_SUPABASE_URL`과 `VITE_SUPABASE_PUBLISHABLE_KEY`를 사용하도록 안내한다. 브라우저에 들어가는 키는 publishable/anon key만 사용하고 `service_role` key는 절대 넣지 않는다.

1. Supabase에서 새 프로젝트 생성.
2. Dashboard → SQL Editor에서 `supabase/schema.sql` 실행.
3. Dashboard → Connect에서 **Project URL**과 **Publishable key** 확인.
4. 저장소의 `public/supabase-config.js`를 열고 `url`과 `publishableKey`에 두 값을 넣는다. 이 파일은 브라우저에 공개되므로 **publishable key만** 넣어야 한다.
5. Supabase → Authentication → URL Configuration에서 Site URL을 GitHub Pages 주소로 설정. 예:

```text
https://YOUR_GITHUB_ID.github.io/scenario-editor/
```

6. 회원가입 이메일 확인을 사용하는 경우, 같은 주소를 Redirect URLs에도 추가.
7. `public/supabase-config.js`를 수정해 `main`에 push하면 그대로 Pages에 반영된다.
8. 배포된 사이트에서 회원가입 → 이메일 확인(프로젝트 설정에서 확인 메일을 사용하는 경우) → 로그인.

### GitHub Actions 변수 방식(선택)

대신 GitHub Actions Variables에 `VITE_SUPABASE_URL`과 `VITE_SUPABASE_PUBLISHABLE_KEY`를 넣어도 된다. 현재 workflow가 이 값을 빌드에 주입한다. GitHub configuration variables는 workflow에서 `${{ vars.NAME }}` 형태로 참조할 수 있다.

같은 계정으로 PC와 휴대폰에서 로그인하면 프로젝트의 JSON 데이터가 같은 Supabase `projects` 행에 자동 저장된다. 변경 후 약 0.7초의 저장 지연이 있다.

### v0.2에서 이미 옛 스키마를 실행했다면

`supabase/migrate_from_v0_2.sql`을 SQL Editor에서 한 번 실행해 `projects.id`를 text로 바꾼다. 새 프로젝트를 처음 연결하는 경우에는 `schema.sql`만 실행하면 된다.

## GitHub Pages

`Settings → Pages → Source: GitHub Actions`로 설정되어 있어야 한다.

`.github/workflows/deploy.yml`이 `main` push마다 Vite를 빌드하고 GitHub Pages에 배포한다.

## Unity

`Unity Export .zip`에는 아래가 포함된다.

- `scenario.ink`
- `scenario.json`
- `characters.json`
- `README_Unity.txt`

Ink의 공식 Unity integration을 사용하면 `.ink` 파일을 Unity에서 import/compile하는 흐름으로 연결할 수 있다. 실제 게임 화면과 스탠딩 일러스트 연출은 Unity 쪽 런타임에서 구현한다.
