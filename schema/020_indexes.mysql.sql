-- Auto-generated from schema-map-mysql.yaml (map@sha1:09DF9CA612D1573E058190CC207FA257C05AEC1F)
-- engine: mysql
-- table:  rbac_user_permissions

CREATE INDEX idx_rbac_up_user ON rbac_user_permissions (user_id);

CREATE INDEX idx_rbac_up_perm ON rbac_user_permissions (permission_id);
