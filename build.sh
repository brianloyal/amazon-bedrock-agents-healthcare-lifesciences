#!/bin/bash

echo "Processing agent templates"
# Debug: Print current location and S3 bucket
echo "Current directory: $(pwd)"
echo "S3 Bucket: ${S3_BUCKET}"

# Process Subagent templates
cd agents || exit
echo "Processing agent templates..."
for agent_file in *.yaml; do
  if [ -f "${agent_file}" ]; then
    echo "Found agent file: ${agent_file}"
    agent_name=$(basename "${agent_file}" .yaml)
    echo "Packaging agent: ${agent_name}"
    aws cloudformation package \
      --template-file "${agent_file}" \
      --s3-bucket "${S3_BUCKET}" \
      --s3-prefix "public_assets_support_materials/hcls_agent_toolkit" \
      --output-template-file "../packaged_${agent_name}.yaml"

    # Copy to S3 immediately after packaging
    aws s3 cp "../packaged_${agent_name}.yaml" "s3://${S3_BUCKET}/public_assets_support_materials/hcls_agent_toolkit/packaged_${agent_name}.yaml"
    rm "../packaged_${agent_name}.yaml"
  fi
done
cd ..

# Process Supervisor agent template - note the quotes around directory name
cd SupervisorAgent || exit
echo "Processing supervisor agent template..."
if [ -f "supervisor_agent.yaml" ]; then
  echo "Packaging supervisor agent"
  aws cloudformation package \
    --template-file supervisor_agent.yaml \
    --s3-bucket "${S3_BUCKET}" \
    --s3-prefix "public_assets_support_materials/hcls_agent_toolkit" \
    --output-template-file "../packaged_supervisor_agent.yaml"

  # Copy to S3 immediately after packaging
  aws s3 cp "../packaged_supervisor_agent.yaml" "s3://${S3_BUCKET}/public_assets_support_materials/hcls_agent_toolkit/packaged_supervisor_agent.yaml"
  rm "../packaged_supervisor_agent.yaml"
fi
cd ..

# Process agent build template
echo "Processing agent build template..."
if [ -f "agent_build.yaml" ]; then
  echo "Packaging agent build template"
  aws cloudformation package \
    --template-file agent_build.yaml \
    --s3-bucket "${S3_BUCKET}" \
    --s3-prefix "public_assets_support_materials/hcls_agent_toolkit" \
    --output-template-file "packaged_agent_build.yaml"

  # Copy to S3
  aws s3 cp "packaged_agent_build.yaml" "s3://${S3_BUCKET}/public_assets_support_materials/hcls_agent_toolkit/packaged_agent_build.yaml"
  rm "packaged_agent_build.yaml"
fi

# Process streamlit app
if [ -d "streamlitapp" ] && [ -f "streamlitapp/streamlit_build.yaml" ]; then
  echo "Processing streamlit app..."
  cd streamlitapp || exit
  aws cloudformation package \
    --template-file streamlit_build.yaml \
    --s3-bucket "${S3_BUCKET}" \
    --s3-prefix "public_assets_support_materials/hcls_agent_toolkit" \
    --output-template-file "../packaged_streamlit_build.yaml"

  # Copy to S3
  aws s3 cp "../packaged_streamlit_build.yaml" "s3://${S3_BUCKET}/public_assets_support_materials/hcls_agent_toolkit/packaged_streamlit_build.yaml"
  rm "../packaged_streamlit_build.yaml"
  cd ..
fi

# Process agent catalog templates
cd agents_catalog || exit
echo "Processing agent templates..."
for agent_file in $(find . -type f -name "*.yaml"); do
  if [ -f "${agent_file}" ]; then
    echo "Found agent file: ${agent_file}"
    agent_name=$(basename "${agent_file}" .yaml)
    echo "Packaging agent: ${agent_name}"
    aws cloudformation package \
      --template-file "${agent_file}" \
      --s3-bucket "${S3_BUCKET}" \
      --s3-prefix "public_assets_support_materials/hcls_agent_toolkit" \
      --output-template-file "../packaged_${agent_name}.yaml"

    # Copy to S3 immediately after packaging
    aws s3 cp "../packaged_${agent_name}.yaml" "s3://${S3_BUCKET}/public_assets_support_materials/hcls_agent_toolkit/packaged_${agent_name}.yaml"
    rm "../packaged_${agent_name}.yaml"
  fi
done
cd ..

# Process multi-agent catalog templates
cd multi_agent_collaboration || exit
echo "Processing multi-agent templates..."
for agent_file in $(find . -type f -name "*.yaml"); do
  if [ -f "${agent_file}" ]; then
    echo "Found agent file: ${agent_file}"
    agent_name=$(basename "${agent_file}" .yaml)
    echo "Packaging agent: ${agent_name}"
    aws cloudformation package \
      --template-file "${agent_file}" \
      --s3-bucket "${S3_BUCKET}" \
      --s3-prefix "public_assets_support_materials/hcls_agent_toolkit" \
      --output-template-file "../packaged_${agent_name}.yaml"

    # Copy to S3 immediately after packaging
    aws s3 cp "../packaged_${agent_name}.yaml" "s3://${S3_BUCKET}/public_assets_support_materials/hcls_agent_toolkit/packaged_${agent_name}.yaml"
    rm "../packaged_${agent_name}.yaml"
  fi
done
cd ..

echo "Processing app templates"

# Prepare UI artifact and upload to S3
if [ -d "ui" ]; then
  echo "Preparing React UI artifact..."
  cd ui || exit
  zip -r ui_artifact.zip . -x "node_modules/*"
  echo "Uploading React UI artifact to S3..."
  aws s3 cp "ui_artifact.zip" "s3://${S3_BUCKET}/public_assets_support_materials/hcls_agent_toolkit/ui_artifact.zip"
  echo "React UI artifact uploaded to S3, deleting local copy"
  rm "ui_artifact.zip"
  cd ..
fi

# Process react app docker build template
echo "Processing react app docker build template..."
app_file="app.yaml"
if [ -f "$app_file" ]; then
  echo "Found app file: ${app_file}"
  app_name=$(basename "${app_file}" .yaml)
  echo "Packaging app: ${app_file}"
  aws cloudformation package \
    --template-file "${app_file}" \
    --s3-bucket "${S3_BUCKET}" \
    --s3-prefix "public_assets_support_materials/hcls_agent_toolkit" \
    --output-template-file "../packaged_${app_name}.yaml"

  # Copy to S3 immediately after packaging
  aws s3 cp "../packaged_${app_name}.yaml" "s3://${S3_BUCKET}/public_assets_support_materials/hcls_agent_toolkit/packaged_${app_name}.yaml"
  rm "../packaged_${app_name}.yaml"
fi

# Process additional artifacts
echo "Uploading additional artifacts"
aws s3 cp agents_catalog/15-clinical-study-research-agent/lambdalayers/matplotlib.zip "s3://${S3_BUCKET}/public_assets_support_materials/hcls_agent_toolkit/matplotlib.zip"
aws s3 cp agents_catalog/10-SEC-10-K-agent/action-groups/SEC-10-K-search/docker/sec-10-k-docker.zip "s3://${S3_BUCKET}/public_assets_support_materials/hcls_agent_toolkit/sec-10-k-docker.zip"

echo "All templates packaged and uploaded to S3"
