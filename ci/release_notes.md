Changes to Team Edition and Enterprise Edition:
================

* Under ServiceSettings in config.json:
  * Added "ImageProxyType": "", "ImageProxyOptions": "", and "ImageProxyURL": "" to ensure posts served to the client will have their markdown modified such that all images are loaded through a proxy.
  * Added "ExperimentalGroupUnreadChannels": disabled to show an unread channel section in the webapp sidebar. The setting must first be enabled by the System Admin, by replacing disabled with either default_off or default_on.
  * Added "ExperimentalEnableDefaultChannelLeaveJoinMessages": true that allows disabling of leave/join messages in the default channel, usually Town Square.
* Under RateLimitingSettings in config.json:
  * Added "VaryByUser": false, a user-based rate limiting, to rate limit on token and on userID.
