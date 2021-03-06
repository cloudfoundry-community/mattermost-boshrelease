# Deploy Mattermost to BOSH

[Mattermost](https://about.mattermost.com/) is a self-hosted Slack-alternative - a modern communication, behind your firewall, running on BOSH in AWS, vSphere, GCE, Azure, OpenStack and more.

One of the fastest ways to get [mattermost](https://about.mattermost.com/) running on any infrastructure is to deploy this bosh release.

* [Concourse CI](https://ci.starkandwayne.com/teams/main/pipelines/mattermost-boshrelease?groups=mattermost-boshrelease)
* Pull requests will be automatically tested against a bosh-lite (see `testflight-pr` job)
* New versions of [mattermost](https://about.mattermost.com/) will be automatically added as the latest blob
* Discussions and CI notifications at [#mattermost channel](https://cloudfoundry.slack.com/messages/C6T7KPKF0/) on https://slack.cloudfoundry.org

## Usage

To use this bosh release, first upload it to your bosh:

```plain
export BOSH_ENVIRONMENT=<alias>
export BOSH_DEPLOYMENT=mattermost

git clone https://github.com/cloudfoundry-community/mattermost-boshrelease.git
cd mattermost-boshrelease
bosh deploy manifests/mattermost.yml \
  -v mattermost-siteurl=https://mattermost.system.ourcompany.com
```

If your BOSH does not have Credhub/Config Server, then remember ` --vars-store` to allow generation of passwords and certificates.

Also, without Credhub you will need to explicitly provide a 32-character at-rest encryption key:

```plain
atrestencryptionkey=$(LC_ALL=C cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-32} | head -n 1)
bosh deploy manifests/mattermost.yml -v "mattermost-sql-atrestencryptkey=${atrestencryptionkey}"
```

To allocate a `vip` static IP (e.g. an Elastic IP on AWS) and run Mattermost inside your `dmz` network, try the `manifests/operators/dmz_vip.yml` operator:

```plain
export BOSH_ENVIRONMENT=<bosh-alias>
export BOSH_DEPLOYMENT=mattermost

bosh deploy manifests/mattermost.yml \
  -o manifests/operators/dmz_vip.yml \
  -v vip=1.2.3.4 \
  -v mattermost-siteurl=http://1-2-3-4.sslip.io
```


To register a route via your Cloud Foundry load balancer + router, you can use `manifests/operators/routing.yml`. If your Cloud Foundry deployment name is `cf`, and your system domain is `system.ourcompany.com`:

```plain
export BOSH_ENVIRONMENT=<bosh-alias>
export BOSH_DEPLOYMENT=mattermost

# name of cf deployment in BOSH, e.g. 'cf'
cf_deployment=cf

system_domain=$(bosh -d $cf_deployment manifest | bosh int - --path /instance_groups/name=api/jobs/name=cloud_controller_ng/properties/system_domain)

bosh deploy manifests/mattermost.yml \
  -o manifests/operators/routing.yml \
  -v routing-nats-deployment=${cf_deployment} \
  -v mattermost-siteurl=https://mattermost.${system_domain}
```

You could also dynamically look up your system domain:

```plain
cf_deployment=cf
system_domain=$(bosh -d $cf_deployment manifest | bosh int - --path /instance_groups/name=api/jobs/name=cloud_controller_ng/properties/system_domain)

bosh deploy manifests/mattermost.yml \
   --vars-store tmp/creds.yml \
   -v "mattermost-sql-atrestencryptkey=${atrestencryptionkey:?required}" \
  -o manifests/operators/routing.yml \
  -v routing-nats-deployment=${cf_deployment:?required} \
  -v "mattermost-siteurl=https://mattermost.${system_domain:?required}"

open https://mattermost.$system_domain
```
