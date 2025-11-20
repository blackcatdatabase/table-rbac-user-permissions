-- Auto-generated from schema-map-postgres.psd1 (map@9d3471b)
-- engine: postgres
-- table:  rbac_user_permissions
CREATE INDEX IF NOT EXISTS idx_rbac_up_user ON rbac_user_permissions (user_id);

CREATE INDEX IF NOT EXISTS idx_rbac_up_perm ON rbac_user_permissions (permission_id);
