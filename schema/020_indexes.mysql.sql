-- Auto-generated from schema-map-mysql.psd1 (map@mtime:2025-11-27T15:13:14Z)
-- engine: mysql
-- table:  rbac_user_permissions

CREATE INDEX idx_rbac_up_user ON rbac_user_permissions (user_id);

CREATE INDEX idx_rbac_up_perm ON rbac_user_permissions (permission_id);
