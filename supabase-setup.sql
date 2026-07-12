-- Rob's Pool cloud database setup
create table if not exists pool_state (
  id text primary key,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table pool_state enable row level security;

drop policy if exists "public read pool state" on pool_state;
create policy "public read pool state"
on pool_state for select
to anon
using (true);

drop policy if exists "public insert pool state" on pool_state;
create policy "public insert pool state"
on pool_state for insert
to anon
with check (true);

drop policy if exists "public update pool state" on pool_state;
create policy "public update pool state"
on pool_state for update
to anon
using (true)
with check (true);

insert into pool_state (id, data)
values ('robs-pool', '{"tests":[],"maintenance":[],"equipment":[]}'::jsonb)
on conflict (id) do nothing;
