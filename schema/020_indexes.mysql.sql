-- Auto-generated from schema-map-mysql.yaml (map@94ebe6c)
-- engine: mysql
-- table:  rbac_user_permissions

CREATE INDEX idx_rbac_up_user ON rbac_user_permissions (user_id);

CREATE INDEX idx_rbac_up_perm ON rbac_user_permissions (permission_id);
