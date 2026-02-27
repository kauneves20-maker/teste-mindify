-- ============================================
-- Create Indexes for Performance
-- ============================================

-- Índices para tabela de pastas
CREATE INDEX IF NOT EXISTS idx_folders_workspace_id ON public.folders(workspace_id);
CREATE INDEX IF NOT EXISTS idx_folders_parent_id ON public.folders(parent_folder_id);
CREATE INDEX IF NOT EXISTS idx_folders_public_link ON public.folders(public_link_token);
CREATE INDEX IF NOT EXISTS idx_folders_created_by ON public.folders(created_by);
CREATE INDEX IF NOT EXISTS idx_folders_is_public ON public.folders(is_public);
CREATE INDEX IF NOT EXISTS idx_folders_created_at ON public.folders(created_at DESC);

-- Índices para tabela de arquivos
CREATE INDEX IF NOT EXISTS idx_files_folder_id ON public.files(folder_id);
CREATE INDEX IF NOT EXISTS idx_files_created_by ON public.files(created_by);
CREATE INDEX IF NOT EXISTS idx_files_created_at ON public.files(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_files_file_type ON public.files(file_type);

-- Índices para tabela de notas
CREATE INDEX IF NOT EXISTS idx_notes_workspace_id ON public.notes(workspace_id);
CREATE INDEX IF NOT EXISTS idx_notes_folder_id ON public.notes(folder_id);
CREATE INDEX IF NOT EXISTS idx_notes_created_by ON public.notes(created_by);
CREATE INDEX IF NOT EXISTS idx_notes_created_at ON public.notes(created_at DESC);

-- Índices para tabela de compartilhamentos
CREATE INDEX IF NOT EXISTS idx_folder_shares_folder_id ON public.folder_shares(folder_id);
CREATE INDEX IF NOT EXISTS idx_folder_shares_user_id ON public.folder_shares(shared_with_user_id);

-- Índices para tabela de logs de acesso
CREATE INDEX IF NOT EXISTS idx_folder_access_logs_folder_id ON public.folder_access_logs(folder_id);
CREATE INDEX IF NOT EXISTS idx_folder_access_logs_accessed_at ON public.folder_access_logs(accessed_at DESC);
CREATE INDEX IF NOT EXISTS idx_folder_access_logs_access_token ON public.folder_access_logs(access_token);

-- Índices compostos para queries comuns
CREATE INDEX IF NOT EXISTS idx_folders_workspace_created ON public.folders(workspace_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_files_folder_created ON public.files(folder_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_notes_workspace_created ON public.notes(workspace_id, created_at DESC);

SELECT 'Indexes created successfully' as status;
