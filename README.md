# Scenario Editor v1.6

Visual-novel scenario writing/editor tool for branching stories.

## Current features
- Multiple projects per account
- Manual cloud save + 5-minute autosave
- Email/password + Google login via Supabase
- Read-only preview share URLs
- Player-name prompt at preview start
- `{user}` token replacement with the entered player name
- Character illustration library with numbered variants
- Dialogue Num. / left-right position / bounce controls
- Dialogue, choice, background and map blocks
- Scene move + scene duplication
- Chapter folders and scene organization
- Map editor with selectable locations and per-location scripts
- Preview with typing effect, illustrations, bounce, choices and maps
- JSON / TXT / Excel / Ink / Unity export

## Supabase
1. Keep the existing `supabase/schema.sql` setup and migrations.
2. Keep using the browser-safe Project URL + Publishable key in `public/supabase-config.js`.
3. `public/supabase-config.js` is intentionally not included in release ZIPs. Keep the local/project copy when replacing files.
4. Never put a Supabase secret/service_role key in the browser.

## Google login
In Supabase Dashboard, enable Google under Authentication Providers and use the GitHub Pages project URL as an allowed redirect URL.
