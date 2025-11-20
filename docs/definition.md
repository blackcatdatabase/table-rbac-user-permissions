<!-- Auto-generated from schema-map-postgres.psd1 @ 62c9c93 (2025-11-20T21:38:11+01:00) -->
# Definition – rbac_user_permissions

Direct permission grants to users (outside of roles).

## Columns
| Column | Type | Null | Default | Description | Notes |
|-------:|:-----|:----:|:--------|:------------|:------|
| id | BIGINT | — | AS | Surrogate primary key. |  |
| user_id | BIGINT | NO | — | User receiving the grant (FK users.id). |  |
| permission_id | BIGINT | NO | — | Permission id (FK permissions.id). |  |
| tenant_id | BIGINT | YES | — | Tenant scope, optional. |  |
| scope | VARCHAR(120) | YES | — | Additional scope qualifier (string). |  |
| effect | TEXT | NO | 'allow' | Allow or deny flag. | enum: allow, deny |
| granted_at | TIMESTAMPTZ(6) | NO | CURRENT_TIMESTAMP(6) | Grant timestamp (UTC). |  |
| expires_at | TIMESTAMPTZ(6) | YES | — | Optional expiration time (UTC). |  |