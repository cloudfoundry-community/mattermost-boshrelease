# Updates for Mattermost 4.4

## Changes to Team Edition and Enterprise Edition:

- Added "mattermost.ServiceSettings.CloseUnusedDirectMessages": false to set whether users have the option to automatically close direct and group message channels older than 7 days.

- Added "mattermost.TeamSettings.EnableConfirmNotificationsToChannel": true to set whether a confirmation is shown for channel wide (@-channel, @-all) mentions in channels with more than five members.

- Added "mattermost.PluginSettings.Enable": true to set whether plugins are enabled on the server.
- Added "mattermost.PluginSettings.EnableUploads": false to set whether manual plugin uploads are enabled on the server. Disabling will keep existing plugins, including pre-packaged Mattermost plugins, installed on the server.
- Added "mattermost.PluginSettings.Directory": "./plugins" to specify the directory of where plugins are stored.
- Added "mattermost.PluginSettings.Plugins": {} to list installed plugins on the Mattermost server.
- Added "mattermost.PluginSettings.PluginStates": {} to set whether an installed plugin is active or inactive on the Mattermost server.

## Additional Changes to Enterprise Edition:

- Added mattermost.LdapSettings.EnableSyncWithLdap: false to set whether SAML user attributes, including deactivation, are periodically synchronized from AD/LDAP.

- Added "mattermost.ElasticsearchSettings.LiveIndexingBatchSize": 1 to set how many new posts are batched together before they are added to the Elasticsearch index.
- Added "mattermost.ElasticsearchSettings.RequestTimeoutSeconds": 30 to set the timeout in seconds for Elasticseaerch calls.
- Added "mattermost.ElasticsearchSettings.BulkIndexingTimeWindowSeconds": 3600 to set the maximum time window for a batch of posts being indexed by the Bulk Indexer.


# Updates for Mattermost 4.5

## Changes to Team Edition and Enterprise Edition:

- Added "mattermost.ServiceSettings.EnablePreviewFeatures": true to hide the Advanced > Preview re-release features section from Account Settings.
- Added "mattermost.ServiceSettings.CloseUnusedDirectMessages": false to hide inactive direct message channels from the sidebar.
- Added "mattermost.ServiceSettings.ExperimentalEnableAuthenticationTransfer": true to set whether users can change authentication methods.
- Added "mattermost.EmailSettings.UseChannelInEmailNotifications": false to set whether email notifications contain the channel name in the subject line.
- Added "mattermost.PluginSettings.ClientDirectory": "./client/plugins" to set the location of client plugins.

## Additional Changes to Enterprise Edition:

- Added "mattermost.MessageExportSettings.EnableExport": false to enable message export.
- Added "mattermost.MessageExportSettings.DailyRunTime": "01:00" to set the time for the daily export job.
- Added "mattermost.MessageExportSettings.ExportFromTimestamp": 0 to set the timestamp for which posts to include in the message export.
- Added "mattermost.MessageExportSettings.FileLocation": "export" to set the message export location.
- Added "mattermost.MessageExportSettings.BatchSize": 10000 to set how many new posts are batched together to a compliance export file
