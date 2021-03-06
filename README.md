# inreach-nodeorm

Simple, quick app to save incoming data
from Garmin/DeLorme inReach Connect IPC Outbound service.
Uses Node.js, Express, and node-orm2.

Currently tested and running in production with node v14.

This app also displays the latest locations for each device
in a simple HTML table. We use other projects to process
and display the data in production and do not intend to
provide additional functionality to this app.

## Documentation

This app aims to implement the basics of the inReach web API, v2.0.
See `IPC_Outbound.pdf`:

  * https://support.garmin.com/en-US/?faq=Oa5mP2D5Zf7NZ8P17ATN58
  * https://support.garmin.com/en-GB/?faq=tdlDCyo1fJ5UxjUbA9rMY8
  * useless old links:
    * http://files.delorme.com/support/inreachwebdocs/IPC_Inbound.pdf
    * http://files.delorme.com/support/inreachwebdocs/IPC_Outbound.pdf
    * https://forums.garmin.com/forum/on-the-trail/inreach/inreach-web-api

## Deployment

See [INSTALL](doc/INSTALL.md)
