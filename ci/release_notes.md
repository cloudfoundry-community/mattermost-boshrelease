Updates for MM 5.1 compatibility
========

Changes to Team Edition and Enterprise Edition:
------------
* Under “ExperimentalSettings:” in config.json:
  * Added "ClientSideCertEnable": false,, to enable client-side certification for your Mattermost server.
  * Added "ClientSideCertCheck": "secondary", to control whether email and password are required following client-side certification.
* Under “ServiceSettings:” in config.json:
  * Added "ExperimentalLimitClientConfig": false, to limit the number of config settings sent to users prior to login. Supported on mobile apps v1.10 and later.
  * Added "EnableGifPicker": false,, "GfycatApiKey": 2_KtH_W5, and "GfycatApiSecret": 3wLVZPiswc3DnaiaFoLkDvB4X0IV6CpMkj4tf2inJRsBY6-FnkT08zGmppWFgeof, to enable a built-in GIF integration with Gfycat.
  * Added "EnableEmailInvitations": false, to disable email invitations on the system.
* Under “SqlSettings:” in config.json:
  * Added "ConnMaxLifetimeMilliseconds": 3600000,, to configure the maximum lifetime for a connection to the database.

Updates for MM 5.0 compatibility
========

Changes to Team Edition and Enterprise Edition:
------------
* Under ServiceSettings in config.json:
  * Added "EnableAPITeamDeletion": false, to disable the permanent APIv4 delete team parameter.
  * Added "ExperimentalEnableHardenedMode": false, to enable a hardened mode for Mattermost that makes user experience trade-offs in the interest of security.
* Under EmailSettings in config.json:
  * Added "EnablePreviewModeBanner": true, to allow Preview Mode banner to be displayed so users are aware that email notifications are disabled.
* Under "ClusterSettings": in config.json:
  * Added "MaxIdleConns": 100, to add the maximum number of idle connections held open from one server to all others in the cluster.
  * Added "MaxIdleConnsPerHost": 128, to add the maximum number of idle connections held open from one server to another server in the cluster.
  * Added "IdleConnTimeoutMilliseconds": 90000 to add the number of milliseconds to leave an idle connection open between servers in the cluster.  
* Under "TeamSettings": in config.json:
  * Added "ExperimentalHideTownSquareinLHS": false, to hide Town Square in the left-hand sidebar if there are no unread messages in the channel.
  * Under "DisplaySettings": in config.json:
  * Added "CustomUrlSchemes": [],, to add a list of URL schemes that are used for autolinking in message text.
  * Under "LdapSettings": in config.json:
  * Added "LoginIdAttribute": "", to add an attribute in the AD/LDAP server used to log in to Mattermost.  
