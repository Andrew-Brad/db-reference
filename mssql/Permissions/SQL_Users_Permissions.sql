SELECT DISTINCT pr.principal_id, 
                pr.NAME, 
                pr.type_desc, 
                pr.authentication_type_desc, 
                pe.state_desc, 
                pe.permission_name 
FROM sys.database_principals AS pr
JOIN sys.database_permissions AS pe ON pe.grantee_principal_id = pr.principal_id; 

    SELECT DP1.name AS DatabaseRoleName,
  isnull (DP2.name, 'No members') AS DatabaseUserName
FROM sys.database_role_members AS DRM
RIGHT OUTER JOIN sys.database_principals AS DP1
  ON DRM.role_principal_id = DP1.principal_id
LEFT OUTER JOIN sys.database_principals AS DP2
  ON DRM.member_principal_id = DP2.principal_id
WHERE DP1.type = 'R' --AND DP1.Name = 'db_owner'
ORDER BY DP1.name;




-- findPermissionsSpecificSchemaObjects.sql
----The following query joins sys.database_principals and sys.database_permissions
--to sys.objects and sys.schemas to list permissions granted or denied to specific schema objects.

SELECT pr.principal_id, pr.name, pr.type_desc,
   pr.authentication_type_desc, pe.state_desc,
   pe.permission_name, s.name + '.' + o.name AS ObjectName
FROM sys.database_principals AS pr
JOIN sys.database_permissions AS pe
   ON pe.grantee_principal_id = pr.principal_id
JOIN sys.objects AS o
   ON pe.major_id = o.object_id
JOIN sys.schemas AS s
   ON o.schema_id = s.schema_id
ORDER BY name

GRANT EXECUTE ON dbo.Table TO [App_User];
GRANT EXECUTE TO [App_User];

-- "I can't see sys tables"
GRANT VIEW DATABASE STATE TO [App_User];


