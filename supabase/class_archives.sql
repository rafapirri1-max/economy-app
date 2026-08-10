-- Run once in Supabase SQL Editor (Economy project).
-- Enables archiving classes with students, balances, and transaction history.

CREATE TABLE IF NOT EXISTS public.class_archives (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  class_name text NOT NULL,
  archived_at timestamptz NOT NULL DEFAULT now(),
  student_count integer NOT NULL DEFAULT 0,
  transaction_count integer NOT NULL DEFAULT 0,
  snapshot jsonb NOT NULL
);

ALTER TABLE public.class_archives ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "class_archives_anon_all" ON public.class_archives;
CREATE POLICY "class_archives_anon_all"
  ON public.class_archives
  FOR ALL
  TO anon, authenticated
  USING (true)
  WITH CHECK (true);

GRANT SELECT, INSERT ON public.class_archives TO anon, authenticated;

COMMENT ON TABLE public.class_archives IS 'Archived Classroom Economy classes with full student/transaction snapshots';
