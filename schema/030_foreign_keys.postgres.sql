-- Auto-generated from schema-map-postgres.psd1 (map@62c9c93)
-- engine: postgres
-- table:  rbac_user_permissions
ALTER TABLE rbac_user_permissions ADD CONSTRAINT fk_rbac_up_user  FOREIGN KEY (user_id)  REFERENCES users(id) ON DELETE CASCADE;

ALTER TABLE rbac_user_permissions ADD CONSTRAINT fk_rbac_up_perm  FOREIGN KEY (permission_id) REFERENCES permissions(id) ON DELETE CASCADE;

ALTER TABLE rbac_user_permissions ADD CONSTRAINT fk_rbac_up_grant FOREIGN KEY (granted_by) REFERENCES users(id) ON DELETE SET NULL;

ALTER TABLE rbac_user_permissions ADD CONSTRAINT fk_rbac_up_tenant FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE;
