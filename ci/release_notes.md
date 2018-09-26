========

v5.3
Changes to Enterprise Edition:
------------
* Under “SamlSettings”: in config.json:
  * Added "EnableSyncWithLdapIncludeAuth": false, to override the SAML ID attribute with the AD/LDAP ID attribute if configured, or override the SAML Email attribute with the AD/LDAP Email attribute if SAML ID attribute is not present. See documentation to learn more.
  * Added "IdAttribute": "", to set the attribute in the SAML Assertion that will be used to bind users from SAML to users in Mattermost.

========

v5.2
Changes to Team Edition and Enterprise Edition:
------------
* Under “ServiceSettings”: in config.json:
  * Added "CorsExposedHeaders": "", to add a whitelist of headers that will be accessible to the requester.
  * Added "CorsAllowCredentials": false, to allow requests that pass validation to include the Access-Control-Allow-Credentials header.
  * dded "CorsDebug": false, to print messages to the logs to help when developing an integration that uses CORS.
* Under “TeamSettings” in config.json:
  * Added "ViewArchivedChannels": true, to allow users to share permalinks and search for content of channels that have been archived.
  * Added "ExperimentalDefaultChannels": "", to allow choosing the default channels every user is added to automatically after joining a new team.

========
