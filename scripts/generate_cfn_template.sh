#!/bin/bash -e

REPOLIST=$1
OUTPUTFILE=cloudformation/deploy.yaml

if [ ! -f ${REPOLIST} ]; then
        echo "Usage: $0 <file containing a list of ECR repos to create>"
        exit 1
fi

cp template/header.yaml ${OUTPUTFILE}


while IFS='' read -r line || [[ -n "$line" ]]; do
  repo=$line
  resource_object=`echo "ECRR"${repo} | tr -d [\\\-/:]`

sed -e "s/XXRESOURCEOBJECTXX/${resource_object}/" \
  -e "s#XXECRREPOXX#${repo}#" template/body.yaml >> ${OUTPUTFILE}

done < "$REPOLIST"


cat template/footer.yaml  >> ${OUTPUTFILE}
