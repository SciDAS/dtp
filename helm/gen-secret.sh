#!/bin/bash

# Get config

source config.sh

# iRODS

export IRODS_ENV=$(cat ${IRODS_ENV_FILE_PATH} | base64 | tr -d '\n')

cat > templates/irods-secret.yaml <<EOF
{{ if .Values.iRODS.Secrets }}
apiVersion: v1
kind: Secret
metadata:
  name: irods
type: Opaque
stringData:
    IRODS_PASSWORD: ${IRODS_PASS}
    IRODS_ENVIRONMENT_FILE: /etc/.irods/irods_environment.json
data:
  irods_environment.json: ${IRODS_ENV}
{{ end }}
EOF

echo "iRODS"
echo " "
cat templates/irods-secret.yaml
echo " "

# AWS

cat > templates/aws-secret.yaml <<EOF
{{ if .Values.S3.Secrets }}
apiVersion: v1
kind: Secret
metadata:
  name: aws
type: Opaque
stringData:
    AWS_ACCESS_KEY_ID: ${AWS_USER}
    AWS_SECRET_ACCESS_KEY: ${AWS_PASS}
{{ end }}
EOF

echo "AWS-S3"
echo " "
cat templates/aws-secret.yaml
echo " "

# Aspera

cat > templates/aspera-secret.yaml <<EOF
{{ if .Values.Aspera.Secrets }}
apiVersion: v1
kind: Secret
metadata:
  name: aspera
type: Opaque
stringData:
    ACLI_USERNAME: ${ACLI_USER}
    ACLI_PASSWORD: ${ACLI_PASS}
{{ end }}
EOF

echo "Aspera"
echo " "
cat templates/aspera-secret.yaml
echo " "
