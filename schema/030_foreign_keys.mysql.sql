-- Auto-generated from schema-map-mysql.yaml (map@sha1:B9D3BE28A74392B9B389FDAFB493BD80FA1F6FA4)
-- engine: mysql
-- table:  rbac_user_permissions

ALTER TABLE rbac_user_permissions ADD CONSTRAINT fk_rbac_up_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;

ALTER TABLE rbac_user_permissions ADD CONSTRAINT fk_rbac_up_perm FOREIGN KEY (permission_id) REFERENCES permissions(id) ON DELETE CASCADE;

ALTER TABLE rbac_user_permissions ADD CONSTRAINT fk_rbac_up_grant FOREIGN KEY (granted_by) REFERENCES users(id) ON DELETE SET NULL;

ALTER TABLE rbac_user_permissions ADD CONSTRAINT fk_rbac_up_tenant FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE;
