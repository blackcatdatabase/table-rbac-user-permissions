-- Auto-generated from schema-views-postgres.yaml (map@sha1:A35B3CB52780A1043442511D947A51BA2C27622C)
-- engine: postgres
-- table:  rbac_user_permissions

-- Contract view for [rbac_user_permissions]
CREATE OR REPLACE VIEW vw_rbac_user_permissions AS
SELECT
  id, user_id, permission_id, tenant_id, scope, effect, granted_by, granted_at, expires_at
FROM rbac_user_permissions;
