## Release updates

* New `sanity-test` errand that initially just pings the endpoint to confirm it returns non-JavaScript text
* Bumped https://github.com/starkandwayne/mattermost-releases to v5.9.0

## Changes to Team Edition and Enterprise Edition (release v5.4 .. v5.7):

* Under SqlSettings:” in config.json:
  * Added "EnablePublicChannelsMaterialization": true, to increase channel search performance in the channel switcher (CTRL/CMD+K), channel autocomplete (~) and elsewhere in the UI.
* The `mattermost-hostname` BOSH variable has been renamed to `mattermost-siteurl` to more closely map to Mattermost configuration naming.

