#!/bin/bash

set -euxo pipefail

export UWSGI_PROFILE="${RECIPE_DIR}/uwsgi_config.ini"
export UWSGI_INCLUDES="${PREFIX}/include,${PREFIX}/include/openssl"
export LDFLAGS="-L${PREFIX}/lib ${LDFLAGS}"

if [[ "${target_platform}" == linux-* ]]; then
  export LDFLAGS="${LDFLAGS} -Wl,--no-as-needed"
  export UWSGI_PROFILE="${RECIPE_DIR}/uwsgi_config_linux.ini"
fi

UWSGI_EMBED_PLUGINS=stats_pusher_statsd ${PYTHON} -m pip install . --no-deps -vv
