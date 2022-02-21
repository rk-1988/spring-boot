#!/bin/sh -l

set -eu
cf_opts=
if ["x${INPUT_VALIDATE}" = "xfalse" ]; then
  cf_opts="--skip-ssl-validation"
fi
cf8 api ${INPUT_API} ${cf_opts}
CF_USERNAME=${INPUT_USERNAME} CF_PASSWORD=${INPUT_PASSWORD} cf8 auth
cf8 target -o ${INPUT_ORG} -s ${INPUT_SPACE}
cf8 login -a $INPUT_API -o $INPUT_ORG -s $INPUT_SPACE -u $INPUT_USERNAME -p $INPUT_PASSWORD
cf8 push -f ${INPUT_MANIFEST}

#starting cf8 cli
sh -c "cf8 $*"   
