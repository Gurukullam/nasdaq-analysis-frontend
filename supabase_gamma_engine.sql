-- ============================================================
-- supabase_gamma_engine.sql  (v1.0.17)
-- Enables the ⚙️ Gamma_engine button in MarketTradingData.html:
--   1. Frontend reads the SQL text from gammapace_internal_mapping
--      (title = 'Gamma_engine in Intraday symbols list update from SQL_Anlysis', sno = 4)
--   2. Frontend executes it via rpc('execute_dynamic_sql', { query: <sql> })
--   3. Frontend reloads gammapace_intraday symbols into the text area
--
-- RUN ONCE in the Supabase SQL Editor (safe to re-run).
-- ============================================================

CREATE OR REPLACE FUNCTION public.execute_dynamic_sql(query TEXT)
RETURNS TEXT
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  -- Execute arbitrary SQL supplied by the app (e.g. the Gamma engine INSERT).
  -- SECURITY DEFINER runs with the function owner's rights so the anon/publishable
  -- key can execute engine statements even though RLS is enabled elsewhere.
  EXECUTE query;
  RETURN 'OK';
EXCEPTION WHEN OTHERS THEN
  RETURN 'ERROR: ' || SQLERRM;
END;
$$;

-- Allow the browser keys to call the function:
GRANT EXECUTE ON FUNCTION public.execute_dynamic_sql(TEXT) TO anon, authenticated;

-- The mapping table must be readable by the browser keys (RLS off):
ALTER TABLE gammapace_internal_mapping DISABLE ROW LEVEL SECURITY;

NOTIFY pgrst, 'reload schema';
