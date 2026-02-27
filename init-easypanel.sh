#!/bin/bash

# ============================================
# Easypanel Initialization Script
# ============================================

set -e

echo "=========================================="
echo "Twenty CRM - Easypanel Initialization"
echo "=========================================="

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Check if DATABASE_URL is set
if [ -z "$DATABASE_URL" ]; then
    echo -e "${RED}Error: DATABASE_URL is not set${NC}"
    echo "Please set DATABASE_URL in Easypanel environment variables"
    exit 1
fi

echo -e "${YELLOW}Testing database connection...${NC}"
if psql "$DATABASE_URL" -c "SELECT 1" > /dev/null 2>&1; then
    echo -e "${GREEN}✓ Database connection successful${NC}"
else
    echo -e "${RED}✗ Database connection failed${NC}"
    exit 1
fi

echo -e "${YELLOW}Running database migrations...${NC}"
yarn typeorm migration:run -d src/database/typeorm/core/core.datasource.ts

echo -e "${YELLOW}Creating custom tables...${NC}"
psql "$DATABASE_URL" << 'EOF'

-- Create schemas
CREATE SCHEMA IF NOT EXISTS core;
CREATE SCHEMA IF NOT EXISTS public;

-- Enable extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "unaccent";

-- Create folders table
CREATE TABLE IF NOT EXISTS public.folders (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    workspace_id UUID NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    parent_folder_id UUID REFERENCES public.folders(id) ON DELETE CASCADE,
    created_by UUID NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    is_public BOOLEAN DEFAULT FALSE,
    public_link_token VARCHAR(32) UNIQUE,
    CONSTRAINT check_folder_name CHECK (name IS NOT NULL AND name != '')
);

-- Create files table
CREATE TABLE IF NOT EXISTS public.files (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    folder_id UUID NOT NULL REFERENCES public.folders(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    file_type VARCHAR(50),
    file_size BIGINT,
    file_path TEXT NOT NULL,
    mime_type VARCHAR(100),
    created_by UUID NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    CONSTRAINT check_file_name CHECK (name IS NOT NULL AND name != '')
);

-- Create notes table
CREATE TABLE IF NOT EXISTS public.notes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    workspace_id UUID NOT NULL,
    title VARCHAR(255) NOT NULL,
    content TEXT,
    folder_id UUID REFERENCES public.folders(id) ON DELETE SET NULL,
    created_by UUID NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    CONSTRAINT check_note_title CHECK (title IS NOT NULL AND title != '')
);

-- Create folder_shares table
CREATE TABLE IF NOT EXISTS public.folder_shares (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    folder_id UUID NOT NULL REFERENCES public.folders(id) ON DELETE CASCADE,
    shared_with_user_id UUID NOT NULL,
    permission_level VARCHAR(50) DEFAULT 'view',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    CONSTRAINT check_permission_level CHECK (permission_level IN ('view', 'edit', 'admin')),
    CONSTRAINT unique_folder_share UNIQUE (folder_id, shared_with_user_id)
);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_folders_workspace_id ON public.folders(workspace_id);
CREATE INDEX IF NOT EXISTS idx_folders_public_link ON public.folders(public_link_token);
CREATE INDEX IF NOT EXISTS idx_files_folder_id ON public.files(folder_id);
CREATE INDEX IF NOT EXISTS idx_notes_workspace_id ON public.notes(workspace_id);
CREATE INDEX IF NOT EXISTS idx_notes_folder_id ON public.notes(folder_id);
CREATE INDEX IF NOT EXISTS idx_folder_shares_folder_id ON public.folder_shares(folder_id);

EOF

echo -e "${GREEN}✓ Database initialization completed${NC}"
echo ""
echo -e "${GREEN}=========================================="
echo "Twenty CRM is ready!"
echo "=========================================="
echo ""
