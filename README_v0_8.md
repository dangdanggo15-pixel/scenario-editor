# Scenario Editor v0.8

## v0.8 changes
- Fixed Supabase browser OAuth navigation for current publishable-key API behavior.
  - Project URL is normalized so a mistaken `/rest/v1/` suffix is removed.
  - Supabase client explicitly sends the publishable key as the `apikey` header.
  - Google OAuth is requested without automatic redirect first, then the returned authorization URL is given the publishable key as an `apikey` query parameter before navigation. This is needed because a browser navigation cannot attach a custom `apikey` header.
- Added cache-busting to `supabase-config.js` so GitHub Pages is less likely to keep an older config file.
- Dialogue input automatically converts three consecutive periods (`...`) to the single ellipsis character (`···`). This also applies to reactive choice response dialogue.

## Important
Keep your existing `public/supabase-config.js` with your own Supabase Project URL and Publishable Key. Do not put a Supabase secret/service_role key in the browser config.
