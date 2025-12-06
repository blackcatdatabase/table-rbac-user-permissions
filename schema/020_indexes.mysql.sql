-- Auto-generated from schema-map-mysql.yaml (map@sha1:5E62933580349BE7C623D119AC9D1301A62F03EF)
-- engine: mysql
-- table:  rbac_user_permissions

CREATE INDEX idx_rbac_up_user ON rbac_user_permissions (user_id);

CREATE INDEX idx_rbac_up_perm ON rbac_user_permissions (permission_id);
