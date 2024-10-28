#!/bin/bash

# Check if src/app.json exists
if [ ! -f src/app.json ]; then
    echo "Error: src/app.json not found!"
    exit 1
fi

# Read APPS_JSON from src/app.json
APPS_JSON=$(cat src/app.json)

# Convert APPS_JSON to base64
APPS_JSON_BASE64=$(echo -n "${APPS_JSON}" | base64)

# Fetch the pwd.yml content
PWD_YML=$(curl -s https://raw.githubusercontent.com/frappe/frappe_docker/main/pwd.yml)

# Remove the version line from PWD_YML
PWD_YML=$(echo "$PWD_YML" | sed '1d')

# Create the final docker-compose.yml
cat << EOF > docker-compose.yml
version: '3'

x-environment: &common-env
  APPS_JSON_BASE64: ${APPS_JSON_BASE64}

${PWD_YML}
EOF

# Determine sed options based on OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    SED_INPLACE=("sed" "-i" "")
else
    SED_INPLACE=("sed" "-i")
fi

# Add the common-env to the backend service
"${SED_INPLACE[@]}" '/^  backend:/,/^    environment:/ {
    /environment:/ {
        a\
      <<: *common-env
    }
}' docker-compose.yml

# Remove the "8080:8080" port mapping from the frontend service
"${SED_INPLACE[@]}" '/^  frontend:/,/^  [a-z]/ {
    /ports:/,/^  [a-z]/ {
        /- "8080:8080"/d
    }
}' docker-compose.yml

echo "docker-compose.yml has been generated successfully."
