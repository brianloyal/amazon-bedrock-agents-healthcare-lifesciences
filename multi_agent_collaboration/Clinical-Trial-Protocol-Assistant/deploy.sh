#!/bin/bash

# Check required parameters
: "${BUCKET_NAME:?Need BUCKET_NAME as 1st argument}"
: "${NAME:?Need NAME as 2nd argument}"
: "${REGION:?Need REGION as 3rd argument}"
: "${BEDROCK_AGENT_SERVICE_ROLE_ARN:?Need BEDROCK_AGENT_SERVICE_ROLE_ARN as 4th argument}"
: "${CLINICAL_SEARCH_AGENT_ALIAS_ARN:?Need CLINICAL_SEARCH_AGENT_ALIAS_ARN as 5th argument}"
: "${CLINICAL_TRIAL_PROTOCOL_GENERATOR_AGENT_ALIAS_ARN:?Need CLINICAL_TRIAL_PROTOCOL_GENERATOR_AGENT_ALIAS_ARN as 6th argument}"

# Package
aws cloudformation package \
  --template-file clinical-trial-protocol-assistant-cfn.yaml \
  --s3-bucket "$BUCKET_NAME" \
  --output-template-file clinical-trial-protocol-assistant-packaged.yaml \
  --region "$REGION" \
  --force-upload

# Deploy
aws cloudformation deploy \
  --template-file clinical-trial-protocol-assistant-packaged.yaml \
  --stack-name "$NAME" \
  --region "$REGION" \
  --parameter-overrides \
    AgentAliasName="Latest" \
    AgentIAMRoleArn="$BEDROCK_AGENT_SERVICE_ROLE_ARN" \
    ClinicalStudySearchAgentAliasArn="$CLINICAL_SEARCH_AGENT_ALIAS_ARN" \
    ClinicalTrialProtocolGeneratorAgentAliasArn="$CLINICAL_TRIAL_PROTOCOL_GENERATOR_AGENT_ALIAS_ARN" \
  --capabilities CAPABILITY_IAM

