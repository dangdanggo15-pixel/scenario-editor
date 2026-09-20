-- Only needed when you already ran the older v0.2 schema.
-- Safe for existing UUID values: uuid -> text.

alter table if exists public.projects
  alter column id type text using id::text;

alter table if exists public.projects enable row level security;

revoke all on table public.projects from anon;
grant select, insert, update, delete on table public.projects to authenticated;

drop policy if exists "Users can read their projects" on public.projects;
create policy "Users can read their projects"
on public.projects for select
to authenticated
using ((select auth.uid()) = user_id);

drop policy if exists "Users can insert their projects" on public.projects;
create policy "Users can insert their projects"
on public.projects for insert
to authenticated
with check ((select auth.uid()) = user_id);

drop policy if exists "Users can update their projects" on public.projects;
create policy "Users can update their projects"
on public.projects for update
to authenticated
using ((select auth.uid()) = user_id)
with check ((select auth.uid()) = user_id);

drop policy if exists "Users can delete their projects" on public.projects;
create policy "Users can delete their projects"
on public.projects for delete
to authenticated
using ((select auth.uid()) = user_id);
