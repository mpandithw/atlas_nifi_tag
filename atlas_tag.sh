#!/bin/bash
tag=$1
attr=$2
echo "the input arg is $tag"
curl -u admin:admin http://sandbox.hortonworks.com:21000/api/atlas/v2/types/typedefs -X POST -H 'Content-Type: application/json' --data-binary '{"classificationDefs":[{"name":"'$tag'","description":"test","superTypes":[],"attributeDefs":[{"name":"Source","typeName":"string","isOptional":true,"cardinality":"SINGLE","valuesMinCount":0,"valuesMaxCount":1,"isUnique":false,"isIndexable":false},{"name":"Location","typeName":"string","isOptional":true,"cardinality":"SINGLE","valuesMinCount":0,"valuesMaxCount":1,"isUnique":false,"isIndexable":false,"defaultValue":"'$attr'"}]}],"entityDefs":[],"enumDefs":[],"structDefs":[]}'

echo "Created the tag and now assign to right entity $1"

curl -u admin:admin http://sandbox.hortonworks.com:21000/api/atlas/entities/38dcf82f-aa67-4202-b13f-3781a47ea717/traits -X POST -H 'Content-Type: application/json' --data-binary '{"jsonClass":"org.apache.atlas.typesystem.json.InstanceSerialization$_Struct","typeName":"'$tag'","values":{"Source": "SharePoint","Location":"'$attr'"}}'