-- Auto-generated from auth-rbac/joins-mysql.yaml (map@sha1:EE82A7850EC6293657D1C6EF6C7ED287EDF31EB3)
-- engine: mysql
-- view:   rbac_user_permissions_conflicts

-- Potential conflicts: same (user,perm,tenant,scope) both allowed and denied
CREATE OR REPLACE ALGORITHM=TEMPTABLE SQL SECURITY INVOKER VIEW vw_rbac_conflicts AS
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

-- Auto-generated from auth-rbac/joins-mysql.yaml (map@sha1:EE82A7850EC6293657D1C6EF6C7ED287EDF31EB3)
-- engine: mysql
-- view:   rbac_user_permissions_conflicts

-- Potential conflicts: same (user,perm,tenant,scope) both allowed and denied
CREATE OR REPLACE ALGORITHM=TEMPTABLE SQL SECURITY INVOKER VIEW vw_rbac_conflicts AS
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

-- Auto-generated from joins-mysql.yaml (map@sha1:EE82A7850EC6293657D1C6EF6C7ED287EDF31EB3)
-- engine: mysql
-- view:   rbac_user_permissions_effective

-- Effective permissions per user (allow minus deny)
CREATE OR REPLACE ALGORITHM=TEMPTABLE SQL SECURITY INVOKER VIEW vw_rbac_effective_permissions AS
WITH allows AS (
  SELECT ur.user_id, rp.permission_id, ur.tenant_id, ur.scope
  FROM rbac_user_roles ur
  JOIN rbac_role_permissions rp ON rp.role_id = ur.role_id AND rp.effect = 'allow'
  WHERE ur.status='active' AND (ur.expires_at IS NULL OR ur.expires_at > NOW())
  UNION
  SELECT up.user_id, up.permission_id, up.tenant_id, up.scope
  FROM rbac_user_permissions up WHERE up.effect = 'allow'
),
denies AS (
  SELECT ur.user_id, rp.permission_id, ur.tenant_id, ur.scope
  FROM rbac_user_roles ur
  JOIN rbac_role_permissions rp ON rp.role_id = ur.role_id AND rp.effect = 'deny'
  WHERE ur.status='active' AND (ur.expires_at IS NULL OR ur.expires_at > NOW())
  UNION
  SELECT up.user_id, up.permission_id, up.tenant_id, up.scope
  FROM rbac_user_permissions up WHERE up.effect = 'deny'
)
SELECT a.user_id, a.permission_id, a.tenant_id, a.scope
FROM allows a
LEFT JOIN denies d
  ON d.user_id = a.user_id
 AND d.permission_id = a.permission_id
 AND COALESCE(d.tenant_id, -1) = COALESCE(a.tenant_id, -1)
 AND COALESCE(d.scope, '') = COALESCE(a.scope, '')
WHERE d.permission_id IS NULL;


-- Auto-generated from core/joins-mysql.yaml (map@sha1:DA70105A5B799F72A56FEAB71A5171F946A770D2)
-- engine: mysql
-- view:   rbac_conflicts

CREATE OR REPLACE ALGORITHM=TEMPTABLE SQL SECURITY INVOKER VIEW vw_rbac_conflicts AS
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

