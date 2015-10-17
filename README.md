BOSH Release for mattermost
===========================

[Mattermost](http://www.mattermost.com/) is a self-hosted Slack-alternative - a modern communication, behind your firewall, running on BOSH in AWS, vSphere, GCE, Azure, OpenStack and more.

![sample1](https://raw.githubusercontent.com/drnic/mattermost-boshrelease/master/docs/images/mattermost-sample1.jpg)

Requirements
------------

In v1 there are some initial requirements that will be lifted in future BOSH releases.

-	You are running Cloud Foundry, including a public-facing load balancer, gorouter and NATS. The v1 BOSH release advertise a route via the CF router for users to be able to access the deployment. In future, the release will support running without CF router, and support direct access to public load balancers.
-	External SQL database - either type `postgres` or `mysql`. The v1 BOSH release does not include its own DB job. See section [External SQL database](#external_sql_database) for options for provisioning and getting the `url` for your DB. In future, the release will offer a built-in solution for convenience, but it may still be desirable to use a DB that is professionally managed and supported by a Cloud Foundry service broker.

Deployment
----------

After following the deployment instructions in this section, you will be presented with the initial admin configuration sequence:

![sample1](https://raw.githubusercontent.com/drnic/mattermost-boshrelease/master/docs/images/admin-start.jpg)

To use this BOSH release, first upload it to your BOSH:

```
bosh upload release https://bosh.io/d/github.com/cloudfoundry-community/route-registrar-boshrelease
bosh upload release https://bosh.io/d/github.com/cloudfoundry-community/mattermost-boshrelease
```

Next, you can use some Spruce templates to generate a deployment manifest.

```
git clone https://github.com/cloudfoundry-community/mattermost-boshrelease.git
```

Next, create a remote PostgreSQL DB to store your configuration, such as with [ElephantSQL](https://www.elephantsql.com/).

Create a `tmp/myconfig.yml` file:

```yaml
jobs:
  - name: mattermost
    properties:
      mattermost:
        sql:
          url: postgres://username:password@pellefant.db.elephantsql.com:5432/dbdbdbdbdb
```

Future versions of this BOSH release will offer a built-in SQL DB job.

For a local [bosh-lite](https://github.com/cloudfoundry/bosh-lite), you can quickly create a deployment manifest & deploy a cluster:

```
./templates/make_manifest warden tmp/myconfig.yml
bosh -n deploy
```

For a remote AWS bosh-lite, such as if you deploy your bosh-lite using https://github.com/cloudfoundry-community/boss-lite, you can override the base domain for the advertised URL.

Add `route_registrar.external_host` to your additional Spruce config file:

```yaml
jobs:
  - name: mattermost
    properties:
      mattermost:
        sql:
          driver_name: postgres
          url: postgres://username:password@pellefant.db.elephantsql.com:5432/dbdbdbdbdb
          max_connections: 5
      route_registrar:
        external_host: mattermost.54.1.2.3.xip.io
```

External SQL database
---------------------

This BOSH release prefers (nay, initially requires) that you use a SQL database that is professionally managed. Mattermost BOSH release will support either `mysql` or `postgres` service types.

One option is to provision a SQL service via your public or private Cloud Foundry.

### Pivotal Web Services

For example, [Pivotal Web Services](https://run.pivotal.io) includes a [PostgreSQL service ElephantSQL](https://console.run.pivotal.io/marketplace/elephantsql).

```
cf create-space mattermost2
cf t -s mattermost2
cf create-service elephantsql turtle mattermost
cf create-service-key mattermost mattermost-bosh
cf service-key mattermost mattermost-bosh
{
 "max_conns": "5",
 "uri": "postgres://username:password@pellefant.db.elephantsql.com:5432/dbdbdbdbdb"
}
```

These DB credentials are the ones used in the example `tmp/myconfig.yml` file in the [Usage](#usage) instructions above.

### Pivotal Elastic Runtime

Self-hosted [Pivotal Elastic Runtime](https://network.pivotal.io/) includes a [MySQL service broker](https://network.pivotal.io/products/p-mysql) offered by Pivotal.

```
cf create-space mattermost
cf t -s mattermost
cf create-service p-mysql free mattermost
cf create-service-key mattermost mattermost-bosh
cf service-key mattermost mattermost-bosh
{
 "max_conns": "20",
 "uri": "mysql://username:password@10.10.10.10:3306/dbdbdbdbdb"
}
```

Add these DB credentials into the `tmp/myconfig.yml` file in the [Usage](#usage) instructions above.

```yaml
jobs:
  - name: mattermost
    properties:
      mattermost:
        sql:
          driver_name: mysql
          url: mysql://username:password@10.10.10.10:3306/dbdbdbdbdb
          max_connections: 20
```

Resolving deployment errors
---------------------------

If you forget to provide configuration to your external DB, you will get a Spruce error:

```
$ ./templates/make_manifest warden
Acting as user 'admin' on 'Bosh Lite Director'
Bosh cpi 31bdfcc4-03a4-4bdf-baba-5cab5a768c77 bosh-warden-boshlite-ubuntu-trusty-go_agent
2015/10/17 09:44:57 error generating manifest: unresolved nodes: (( params "please provide DB url, such as postgres://mmuser:mmuser_password@10.10.10.1:5432/mattermost?sslmode=disable&connect_timeout=10" )) in ./templates/jobs.yml jobs.[0].properties.mattermost.sql.url ()
```

Read the [Usage](#usage) section above for the schema of a `tmp/myconfig.yml` file.
