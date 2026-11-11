-- 增加参数对比菜单权限
set @content_type_id=(select id from django_content_type where app_label='sql' and model='permission');
INSERT INTO auth_permission (name, content_type_id, codename) VALUES ('菜单 参数对比', @content_type_id, 'menu_param_compare');

-- MQTT/RabbitMQ mTLS 客户端凭证字段（Instance 新增列，升级既有库时需补齐，否则 Django 读写报未知列）
ALTER TABLE sql_instance ADD client_cert longtext COMMENT '客户端证书';
ALTER TABLE sql_instance ADD client_key longtext COMMENT '客户端密钥';
ALTER TABLE sql_instance ADD ca_cert longtext COMMENT 'CA证书';

-- 工单说明和审批标题长度扩展到150，升级仍为varchar(50)的数据库时执行
ALTER TABLE sql_workflow MODIFY workflow_name varchar(150) NOT NULL comment '工单说明';
ALTER TABLE workflow_audit MODIFY workflow_title varchar(150) NOT NULL comment '工单说明';
