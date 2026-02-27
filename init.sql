-- ============================================
-- PostgreSQL Initialization for Easypanel
-- ============================================

-- Enable extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "unaccent";

-- Create schemas
CREATE SCHEMA IF NOT EXISTS core;
CREATE SCHEMA IF NOT EXISTS public;

-- Create immutable unaccent function
CREATE OR REPLACE FUNCTION public.unaccent_immutable(input text)
RETURNS text
LANGUAGE sql
IMMUTABLE
AS $$
SELECT public.unaccent('public.unaccent'::regdictionary, input)
$$;

-- Set search path
ALTER DATABASE twenty_crm SET search_path TO core, public, "$user";

SELECT 'PostgreSQL initialization completed' as status;
