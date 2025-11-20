-- Auto-generated from schema-map-mysql.psd1 (map@62c9c93)
-- engine: mysql
-- table:  rbac_user_permissions
CREATE INDEX idx_rbac_up_user ON rbac_user_permissions (user_id);

CREATE INDEX idx_rbac_up_perm ON rbac_user_permissions (permission_id);
