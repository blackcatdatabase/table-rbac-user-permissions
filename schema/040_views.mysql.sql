-- Auto-generated from schema-views-mysql.psd1 (map@62c9c93)
-- engine: mysql
-- table:  rbac_user_permissions_conflicts
-- Potential conflicts: same (user,perm,tenant,scope) both allowed and denied
CREATE OR REPLACE ALGORITHM=MERGE SQL SECURITY INVOKER VIEW vw_rbac_conflicts AS
WITH allowed AS (
  SELECT user_id, permission_id, tenant_id, scope FROM rbac_user_permissions WHERE effect='allow'
  UNION
  SELECT ur.user_id, rp.permission_id, ur.tenant_id, ur.scope
  FROM rbac_user_roles ur
  JOIN rbac_role_permissions rp ON rp.role_id = ur.role_id AND rp.effect='allow'
  WHERE ur.status='active' AND (ur.expires_at IS NULL OR ur.expires_at > NOW())
),
denied AS (
  SELECT user_id, permission_id, tenant_id, scope FROM rbac_user_permissions WHERE effect='deny'
  UNION
  SELECT ur.user_id, rp.permission_id, ur.tenant_id, ur.scope
  FROM rbac_user_roles ur
  JOIN rbac_role_permissions rp ON rp.role_id = ur.role_id AND rp.effect='deny'
  WHERE ur.status='active' AND (ur.expires_at IS NULL OR ur.expires_at > NOW())
)
SELECT DISTINCT
  a.user_id,
  a.permission_id,
  p.name AS permission_name,
  a.tenant_id,
  a.scope
FROM allowed a
JOIN denied d
  ON d.user_id = a.user_id
 AND d.permission_id = a.permission_id
 AND COALESCE(d.tenant_id, -1) = COALESCE(a.tenant_id, -1)
 AND COALESCE(d.scope, '') = COALESCE(a.scope, '')
JOIN permissions p ON p.id = a.permission_id;

-- Auto-generated from schema-views-mysql.psd1 (map@62c9c93)
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


-- Auto-generated from schema-views-mysql.psd1 (map@62c9c93)
-- engine: mysql
-- table:  rbac_user_permissions_effective
-- Effective permissions per user (Deny > Allow), including tenant/scope
CREATE OR REPLACE ALGORITHM=MERGE SQL SECURITY INVOKER VIEW vw_rbac_effective_permissions AS
WITH allowed AS (
  SELECT ur.user_id, rp.permission_id, ur.tenant_id, ur.scope
  FROM rbac_user_roles ur
  JOIN rbac_role_permissions rp ON rp.role_id = ur.role_id AND rp.effect = 'allow'
  WHERE ur.status = 'active' AND (ur.expires_at IS NULL OR ur.expires_at > NOW())
  UNION
  SELECT up.user_id, up.permission_id, up.tenant_id, up.scope
  FROM rbac_user_permissions up
  WHERE up.effect = 'allow' AND (up.expires_at IS NULL OR up.expires_at > NOW())
),
denied AS (
  SELECT ur.user_id, rp.permission_id, ur.tenant_id, ur.scope
  FROM rbac_user_roles ur
  JOIN rbac_role_permissions rp ON rp.role_id = ur.role_id AND rp.effect = 'deny'
  WHERE ur.status = 'active' AND (ur.expires_at IS NULL OR ur.expires_at > NOW())
  UNION
  SELECT up.user_id, up.permission_id, up.tenant_id, up.scope
  FROM rbac_user_permissions up
  WHERE up.effect = 'deny' AND (up.expires_at IS NULL OR up.expires_at > NOW())
)
SELECT
  a.user_id,
  a.permission_id,
  p.name AS permission_name,
  a.tenant_id,
  a.scope
FROM allowed a
JOIN permissions p ON p.id = a.permission_id
WHERE NOT EXISTS (
  SELECT 1
  FROM denied d
  WHERE d.user_id = a.user_id
    AND d.permission_id = a.permission_id
    AND COALESCE(d.tenant_id, -1) = COALESCE(a.tenant_id, -1)
    AND COALESCE(d.scope, '') = COALESCE(a.scope, '')
);

