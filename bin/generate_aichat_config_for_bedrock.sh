#!/bin/bash

# Configuration
TEMPLATE_FILE="$HOME/.config/aichat/template.yaml"
OUTPUT_FILE="$HOME/.config/aichat/config.yaml"

# 1. Check if the template file exists
if [[ ! -f "$TEMPLATE_FILE" ]]; then
    echo "Error: Template file '$TEMPLATE_FILE' not found."
    exit 1
fi

# 2. Check if required environment variables are set
if [[ -z "$AWS_ACCESS_KEY_ID" || -z "$AWS_SECRET_ACCESS_KEY" || -z "$AWS_SESSION_TOKEN" ]]; then
    echo "Error: Missing AWS credentials in environment."
    echo "Please export AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, and AWS_SESSION_TOKEN."
    exit 1
fi

echo "Credentials detected. Generating $OUTPUT_FILE..."

ESCAPED_AWS_ACCESS_KEY_ID=$(printf '%s\n' "$AWS_ACCESS_KEY_ID" | sed -e 's/[\/&]/\\&/g')
ESCAPED_AWS_SECRET_ACCESS_KEY=$(printf '%s\n' "$AWS_SECRET_ACCESS_KEY" | sed -e 's/[\/&]/\\&/g')
ESCAPED_AWS_SESSION_TOKEN=$(printf '%s\n' "$AWS_SESSION_TOKEN" | sed -e 's/[\/&]/\\&/g')
# 3. Use sed to perform the replacement
# We use double quotes so that the shell expands the variables
sed -e "s/<access_key>/$ESCAPED_AWS_ACCESS_KEY_ID/g" \
    -e "s/<secret_key>/$ESCAPED_AWS_SECRET_ACCESS_KEY/g" \
    -e "s/<session_token>/$ESCAPED_AWS_SESSION_TOKEN/g" \
    "$TEMPLATE_FILE" > "$OUTPUT_FILE"

# 4. Verify success
if [[ $? -eq 0 ]]; then
    echo "Success! New configuration created at: $OUTPUT_FILE"
else
    echo "An error occurred during file generation."
    exit 1
fi
