BOSH Release for mattermost-platform
====================================

Usage
-----

To use this BOSH release, first upload it to your BOSH:

```
bosh upload release https://bosh.io/d/github.com/cloudfoundry-community/route-registrar-boshrelease
bosh upload release https://bosh.io/releases/github.com/cloudfoundry-community/mattermost-platform-boshrelease
```

For [bosh-lite](https://github.com/cloudfoundry/bosh-lite), you can quickly create a deployment manifest & deploy a cluster:

```
./templates/make_manifest warden
bosh -n deploy
```
