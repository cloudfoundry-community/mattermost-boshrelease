* New bosh2 deployment manifests at `manifests/mattermost.yml` and operator modifications at `manifests/operators/`

    Note: if you are not using credhub for credentials, you must provide a `mattermost-sql-atrestencryptkey` variable that is 32+ characters long. Currently the `bosh` CLI will not generate a long enough random string. [[bosh-cli#302](https://github.com/cloudfoundry/bosh-cli/issues/302)]

    ```
    atrestencryptionkey=$(LC_ALL=C cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-32} | head -n 1)
    bosh deploy manifests/mattermost.yml -v "mattermost-sql-atrestencryptkey=${atrestencryptionkey}"
    ```

* `mattermost` job can consume `type: postgresql` link to discover database credentials
* `mattermost.SqlSettings.DriverName` no longer defaults to `mysql` - either provide it explicitly or use BOSH links
* Mattermost v4.1.0 https://docs.mattermost.com/administration/changelog.html#release-v4-1-0
