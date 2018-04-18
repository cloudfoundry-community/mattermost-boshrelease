Updates for MM 4.9 compatibility
========

Changes to Team Edition and Enterprise Edition:
------------

* Under MessageExportSettings in config.json:
  * Added "CustomerType": "A9", to allow selecting the type of Global Relay customer account the user’s organization has.
  * Added "EmailAddress": "", to allow selecting the email address the user’s Global Relay server monitors for incoming compliance exports.
* Under "SamlSettings" in config.json:
  * Added "ScopingIDPProviderId": "", to allow an authenticated user to skip the initial login page of their federated Azure AD server, and only require a password to log in.
  * Added "ScopingIDPName": "", to add the name associated with a user’s Scoping Identity Provider ID.
* Under DisplaySettings" in config.json:
  * Added "ExperimentalTimezone": false, to allow selecting the timezone used for timestamps in the user interface and email notifications.
