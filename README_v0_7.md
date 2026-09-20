# v0.7 update notes

- Google/email login UI is always visible; if the app says local mode, make sure `public/supabase-config.js` in GitHub contains your existing Supabase Project URL + Publishable key.
- IMPORTANT: `public/supabase-config.js` is intentionally NOT included in this ZIP so your existing configured file is not overwritten. Keep the one already in your GitHub repo.
- Export tools moved to the left `내보내기` tab.
- Top-right now only has 로그인/회원가입, 저장, 미리보기.
- Preview-only share link button moved inside the preview window.
- Google OAuth uses Supabase Auth's `signInWithOAuth({ provider: 'google' })` flow.
