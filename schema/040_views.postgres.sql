-- Auto-generated from schema-views-postgres.yaml (map@4ae85c5)
-- engine: postgres
-- table:  rbac_user_permissions

-- Contract view for [rbac_user_permissions]
CREATE OR REPLACE VIEW vw_rbac_user_permissions AS
SELECT
  id, user_id, permission_id, tenant_id, scope, effect, granted_by, granted_at, expires_at
FROM rbac_user_permissions;
