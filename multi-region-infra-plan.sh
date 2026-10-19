#!/bin/bash
set -e

REGIONS_ARG=""

# Parse arguments to grab the comma-separated string after --region
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --region)
            shift
            REGIONS_ARG="$1"
            shift
            ;;
        --help|-h)
            echo "Usage: ./multi-region-infra-plan.sh --region us-east-1,us-east-2"
            exit 0
            ;;
        *)
            echo "Unknown parameter: $1"
            exit 1
            ;;
    esac
done

# Validate that --region was provided
if [ -z "$REGIONS_ARG" ]; then
    echo "Error: No regions specified."
    echo "Usage: ./multi-region-infra-plan.sh --region us-east-1,us-east-2"
    exit 1
fi

# Split the comma-separated string into a bash array
IFS=',' read -ra REGIONS <<< "$REGIONS_ARG"

# Iterate through each requested region
for region in "${REGIONS[@]}"; do
    # Trim any accidental whitespace around the region name (e.g., "us-east-1, us-east-2")
    region=$(echo "$region" | xargs)
    
    tfvars_file="variable-files/${region}.tfvars"

    # Safety check: ensure the tfvars file exists before running
    if [ ! -f "$tfvars_file" ]; then
        echo "=============================================="
        echo "Skipping region '$region': File '$tfvars_file' not found."
        echo "=============================================="
        continue
    fi

    echo "=============================================="
    echo "Running plan for region: $region"
    echo "Using file: $tfvars_file"
    echo "=============================================="

    lstk terraform plan --var-file="$tfvars_file"

    echo -e "\n"
done
