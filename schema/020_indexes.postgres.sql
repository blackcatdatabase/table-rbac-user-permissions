-- Auto-generated from schema-map-postgres.yaml (map@sha1:6D9B52237D942B2B3855FD0F5500331B935A7C62)
-- engine: postgres
-- table:  rbac_user_permissions

CREATE INDEX IF NOT EXISTS idx_rbac_up_user ON rbac_user_permissions (user_id);

CREATE INDEX IF NOT EXISTS idx_rbac_up_perm ON rbac_user_permissions (permission_id);
