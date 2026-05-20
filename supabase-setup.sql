-- Run this once in Supabase > SQL Editor

create table if not exists public.schedule_overrides (
  id text primary key,
  wing text not null,
  schedule_date date not null,
  activities jsonb not null default '[]'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.schedule_overrides enable row level security;

drop policy if exists "schedule read" on public.schedule_overrides;
drop policy if exists "schedule insert" on public.schedule_overrides;
drop policy if exists "schedule update" on public.schedule_overrides;
drop policy if exists "schedule delete" on public.schedule_overrides;

create policy "schedule read"
on public.schedule_overrides for select
to anon
using (true);

create policy "schedule insert"
on public.schedule_overrides for insert
to anon
with check (true);

create policy "schedule update"
on public.schedule_overrides for update
to anon
using (true)
with check (true);

create policy "schedule delete"
on public.schedule_overrides for delete
to anon
using (true);

-- Enable realtime for live display updates
alter publication supabase_realtime add table public.schedule_overrides;
