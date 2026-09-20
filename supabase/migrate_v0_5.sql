-- Scenario Editor v0.5
-- Run once in Supabase SQL Editor after the existing schema.
-- Projects already support multiple rows per user; this migration adds public, read-only preview links.

create table if not exists public.preview_shares (
  token text primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  project_name text not null default '미리보기',
  data jsonb not null,
  created_at timestamptz not null default now()
);

create index if not exists preview_shares_user_id_idx on public.preview_shares(user_id);

alter table public.preview_shares enable row level security;

revoke all on table public.preview_shares from anon;
revoke all on table public.preview_shares from authenticated;
grant select on table public.preview_shares to anon;
grant select, insert, update, delete on table public.preview_shares to authenticated;

drop policy if exists "Anyone can read preview shares by token" on public.preview_shares;
create policy "Anyone can read preview shares by token"
on public.preview_shares for select
to anon, authenticated
using (true);

drop policy if exists "Users can create own preview shares" on public.preview_shares;
create policy "Users can create own preview shares"
on public.preview_shares for insert
to authenticated
with check ((select auth.uid()) = user_id);

drop policy if exists "Users can update own preview shares" on public.preview_shares;
create policy "Users can update own preview shares"
on public.preview_shares for update
to authenticated
using ((select auth.uid()) = user_id)
with check ((select auth.uid()) = user_id);

drop policy if exists "Users can delete own preview shares" on public.preview_shares;
create policy "Users can delete own preview shares"
on public.preview_shares for delete
to authenticated
using ((select auth.uid()) = user_id);
