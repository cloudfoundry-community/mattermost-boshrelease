# mattermost

* added a pre-start script to create the needed plugin directories under /var/vcap/store and set permissions on them.  This allows the plugin system to work properly
* removed mattermost.PluginSettings.Directory and mattermost.PluginSettings.ClientDirectory  These are now hard coded toensure consistency with the startup script
