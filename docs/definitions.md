# rbac_user_permissions

Direct permission grants to users (outside of roles).

## Columns
| Column | Type | Null | Default | Description | Crypto |
| --- | --- | --- | --- | --- | --- |
| id | BIGINT | NO |  | Surrogate primary key. |  |
| user_id | BIGINT | NO |  | User receiving the grant (FK users.id). |  |
| permission_id | BIGINT | NO |  | Permission id (FK permissions.id). |  |
| tenant_id | BIGINT | YES |  | Tenant scope, optional. |  |
| scope | VARCHAR(120) | YES |  | Additional scope qualifier (string). |  |
| effect | mysql: ENUM('allow','deny') / postgres: TEXT | NO | allow | Allow or deny flag. (enum: allow, deny) |  |
| granted_by | BIGINT | YES |  | User/admin who granted the permission. |  |
| granted_at | mysql: DATETIME(6) / postgres: TIMESTAMPTZ(6) | NO | CURRENT_TIMESTAMP(6) | Grant timestamp (UTC). |  |
| expires_at | mysql: DATETIME(6) / postgres: TIMESTAMPTZ(6) | YES |  | Optional expiration time (UTC). |  |

## Engine Details

### mysql

Unique keys:
| Name | Columns |
| --- | --- |
| uq_rbac_user_perm | user_id, permission_id, tenant_id, scope |

Indexes:
| Name | Columns | SQL |
| --- | --- | --- |
| idx_rbac_up_perm | permission_id | CREATE INDEX idx_rbac_up_perm ON rbac_user_permissions (permission_id) |
| idx_rbac_up_user | user_id | CREATE INDEX idx_rbac_up_user ON rbac_user_permissions (user_id) |
| uq_rbac_user_perm | user_id,permission_id,tenant_id,scope | UNIQUE KEY uq_rbac_user_perm (user_id, permission_id, tenant_id, scope) |

Foreign keys:
| Name | Columns | References | Actions |
| --- | --- | --- | --- |
| fk_rbac_up_grant | granted_by | users(id) | ON DELETE SET |
| fk_rbac_up_perm | permission_id | permissions(id) | ON DELETE CASCADE |
| fk_rbac_up_tenant | tenant_id | tenants(id) | ON DELETE CASCADE |
| fk_rbac_up_user | user_id | users(id) | ON DELETE CASCADE |

### postgres

Unique keys:
| Name | Columns |
| --- | --- |
| uq_rbac_user_perm | user_id, permission_id, tenant_id, scope |

Indexes:
| Name | Columns | SQL |
| --- | --- | --- |
| idx_rbac_up_perm | permission_id | CREATE INDEX IF NOT EXISTS idx_rbac_up_perm ON rbac_user_permissions (permission_id) |
| idx_rbac_up_user | user_id | CREATE INDEX IF NOT EXISTS idx_rbac_up_user ON rbac_user_permissions (user_id) |
| uq_rbac_user_perm | user_id,permission_id,tenant_id,scope | CONSTRAINT uq_rbac_user_perm UNIQUE (user_id, permission_id, tenant_id, scope) |

Foreign keys:
| Name | Columns | References | Actions |
| --- | --- | --- | --- |
| fk_rbac_up_grant | granted_by | users(id) | ON DELETE SET |
| fk_rbac_up_perm | permission_id | permissions(id) | ON DELETE CASCADE |
| fk_rbac_up_tenant | tenant_id | tenants(id) | ON DELETE CASCADE |
| fk_rbac_up_user | user_id | users(id) | ON DELETE CASCADE |

## Engine differences

## Views
| View | Engine | Flags | File |
| --- | --- | --- | --- |
| vw_rbac_conflicts | mysql | algorithm=TEMPTABLE, security=INVOKER | [../schema/040_views_joins.mysql.sql](../schema/040_views_joins.mysql.sql) |
| vw_rbac_effective_permissions | mysql | algorithm=TEMPTABLE, security=INVOKER | [../schema/040_views_joins.mysql.sql](../schema/040_views_joins.mysql.sql) |
| vw_rbac_user_permissions | mysql | algorithm=MERGE, security=INVOKER | [../schema/040_views.mysql.sql](../schema/040_views.mysql.sql) |
| vw_rbac_conflicts | postgres |  | [../schema/040_views_joins.postgres.sql](../schema/040_views_joins.postgres.sql) |
| vw_rbac_effective_permissions | postgres |  | [../schema/040_views_joins.postgres.sql](../schema/040_views_joins.postgres.sql) |
| vw_rbac_user_permissions | postgres |  | [../schema/040_views.postgres.sql](../schema/040_views.postgres.sql) |
