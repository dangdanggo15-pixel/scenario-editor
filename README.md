# Scenario Editor v0.5

## Added in v0.5
- Multiple projects per account
- Manual cloud save button + 5-minute autosave
- Google login button (enable Google provider in Supabase Auth)
- Read-only preview share URLs
- Character illustration library with multiple numbered variants
- Dialogue Num. selector and left/right illustration position buttons
- Preview renders the selected character illustration on the selected side
- Ending scripts use the same dialogue editor

## Supabase
1. Keep the existing `supabase/schema.sql` setup.
2. Run `supabase/migrate_v0_5.sql` once in Supabase SQL Editor.
3. Keep using the browser-safe Project URL + Publishable key in `public/supabase-config.js`.
4. Never put a Supabase secret/service_role key in the browser.

## Google login
In Supabase Dashboard, enable Google under Authentication Providers and add the GitHub Pages site URL as an allowed redirect URL.
