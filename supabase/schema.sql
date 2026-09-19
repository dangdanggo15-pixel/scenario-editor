-- Scenario Editor cloud sync schema
-- Run this once in Supabase Dashboard > SQL Editor.

create table if not exists public.projects (
  id uuid primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null default '새 프로젝트',
  data jsonb not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists projects_user_id_idx on public.projects(user_id);

alter table public.projects enable row level security;

drop policy if exists "Users can read their projects" on public.projects;
create policy "Users can read their projects"
on public.projects for select
using (auth.uid() = user_id);

drop policy if exists "Users can insert their projects" on public.projects;
create policy "Users can insert their projects"
on public.projects for insert
with check (auth.uid() = user_id);

drop policy if exists "Users can update their projects" on public.projects;
create policy "Users can update their projects"
on public.projects for update
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

drop policy if exists "Users can delete their projects" on public.projects;
create policy "Users can delete their projects"
on public.projects for delete
using (auth.uid() = user_id);

create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists projects_set_updated_at on public.projects;
create trigger projects_set_updated_at
before update on public.projects
for each row execute function public.set_updated_at();
