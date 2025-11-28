-- Auto-generated from schema-views-mysql.psd1 (map@mtime:2025-11-27T15:35:35Z)
-- engine: mysql
-- table:  rbac_user_permissions

-- Contract view for [rbac_user_permissions]
CREATE OR REPLACE ALGORITHM=MERGE SQL SECURITY INVOKER VIEW vw_rbac_user_permissions AS
SELECT
  id,
  user_id,
  permission_id,
  tenant_id,
  scope,
  effect,
  granted_by,
  granted_at,
  expires_at
FROM rbac_user_permissions;
