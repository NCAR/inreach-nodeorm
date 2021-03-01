# Install notes

## Database

Create a database with schema from "db.sql"
and user with "select,insert,update" privileges

Set the example config file(s) in conf/
-- database connection info in `index.js`


## Running the code

Install node and make sure it's in your shell command path.

Install and update node modules (as your own normal system user):

    npm install --save --unsafe-perm=true
    npm audit fix
    (repeat)

Modules are committed to git. Some may need native compiled
code (esp. `fs-ext` or other system-interface modules)
and need rebuilding. When you try to start the app later,
npm should tell you if you need to `npm rebuild`, but you
can also do so anytime.

Set env vars:

    NODE_PATH=/path/to/inreach-portal-nodeorm/node_modules
    NODE_ENV=production

    npm_config_cache=/path/to/home/of/user/.npm
       => your home for dev, the daemon user for prod
       => not used when running but must be set

    TZ=UTC
    PATH=...(make sure node on the path)...

Optional env vars:

    INREACH_PORT=7997   (default 3000)

Setup database and its access config. Copy and edit `conf/index.js`

Run:

    npm start

TODO:
  * Try to get the npm cache out of user's homedir with env var, cmdline arg, .npmrc.


## Testing

The Garmin API uses a POST to send us data.
This app also responds to a GET request with simple HTML
listing the latest locations of each device.

Simple test:

    curl http://localhost:3000/inreach
    curl -d @doc/event.json -X POST -H 'Content-Type: application/json' http://localhost:3000/inreach
    curl http://localhost:3000/inreach

The first GET should return no events for a fresh database.
The example data file can be POSTed and then view in the final GET.


## Deploy

See `etc/inreach.service` for example systemd integration.

The example service file runs the app as the
system/daemon/nologin user/group "inreach".
This user needs to write to the log/ directory:

    chgrp inreach log

(Remember to remove any log files left from initial tests
before starting the service.)

This user also needs a real home directory for npm.
In addition to, or despite `npm_config_cache` it will
also write to `~/.config/configstore/update-notifier-npm.json`
and possibly more.

Deploy via "git push" can be accomplished with help
from `etc/hooks/post-receive`. If doing so, it is recommended
that sudo be configured to allow restart.


## Related services

You probably want a reverse proxy on your webserver
to expose this service to the world:

    # production Garmin/DeLorme InReach IPC Outbound service (w/disallow CORS)
    RewriteRule ^/inreach http://127.0.0.1:7997%{REQUEST_URI} [P,QSA,L,E=ORIGIN_DOMAIN:null,E=ALLOW_HEADER:null,E=ALLOW_METHOD:none]

You probably want to do something with the data other than
the basic HTML provided by this service. For NCAR/EOL,
the catalog `product_scripts` repo contains the script
`jja/inreach_kml` to create a KML file suitable for Catalog-Maps.
