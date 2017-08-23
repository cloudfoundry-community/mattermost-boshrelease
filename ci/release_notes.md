* New bosh2 deployment manifests at `manifests/mattermost.yml` and operator modifications at `manifests/operators/`
* `mattermost` job can consume `type: postgresql` link to discover database credentials
* `mattermost.SqlSettings.DriverName` no longer defaults to `mysql` - either provide it explicitly or use BOSH links
