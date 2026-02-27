-- ============================================
-- Create Tables for Folders, Files, and Notes
-- ============================================

-- Tabela de Pastas
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

-- Tabela de Arquivos
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

-- Tabela de Notas
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

-- Tabela de Compartilhamentos de Pasta
CREATE TABLE IF NOT EXISTS public.folder_shares (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    folder_id UUID NOT NULL REFERENCES public.folders(id) ON DELETE CASCADE,
    shared_with_user_id UUID NOT NULL,
    permission_level VARCHAR(50) DEFAULT 'view',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    CONSTRAINT check_permission_level CHECK (permission_level IN ('view', 'edit', 'admin')),
    CONSTRAINT unique_folder_share UNIQUE (folder_id, shared_with_user_id)
);

-- Tabela de Auditoria de Acessos
CREATE TABLE IF NOT EXISTS public.folder_access_logs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    folder_id UUID NOT NULL REFERENCES public.folders(id) ON DELETE CASCADE,
    accessed_by UUID,
    access_token VARCHAR(32),
    ip_address INET,
    user_agent TEXT,
    accessed_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

SELECT 'Tables created successfully' as status;
