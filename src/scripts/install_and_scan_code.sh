#!/bin/bash
curl -L https://github.com/threatrix/threat-agent-dist/releases/download/latest/threat-agent.jar > /tmp/threatagent.jar
ls /tmp
whoami
curl icanhazip.com
java -jar /tmp/threatagent.jar --oid="${PARAM_OID}" --eid="${PARAM_EID}" --api-key="${PARAM_API_KEY}" "${PARAM_DIR}" --progress
java -jar /tmp/threatagent.jar --progress ./