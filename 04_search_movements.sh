#!/usr/bin/env bash
# VIM SEARCH MOVEMENTS PRACTICE
# Practice file for Steps 9-10: Jump motions (%, [[, ]]) and Search-based movement (/, ?, n, N, *)

# Practice using these movements:
# - % to jump between matching brackets
# - [[ and ]] to jump between function definitions
# - { and } to jump between paragraphs
# - / to search forward
# - ? to search backward
# - n and N to continue searching
# - * to search for the word under cursor

# Set strict mode
set -euo pipefail
IFS=$'\n\t'

# Global variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="${SCRIPT_DIR}/deployment.log"
CONFIG_DIR="${SCRIPT_DIR}/config"
ENVIRONMENT="${1:-development}"

# Color definitions for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# -------------------------------------------------------------------------
# FUNCTION DEFINITIONS - Practice using [[ and ]] to jump between functions
# -------------------------------------------------------------------------

function log_message() {
    local level="$1"
    local message="$2"
    local timestamp
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    echo -e "${timestamp} [${level}] ${message}"
    echo "${timestamp} [${level}] ${message}" >> "${LOG_FILE}"
}

function check_prerequisites() {
    log_message "INFO" "Checking prerequisites..."
    
    # Check if required commands exist
    for cmd in aws docker kubectl jq; do
        if ! command -v "${cmd}" &> /dev/null; then
            log_message "ERROR" "Required command not found: ${cmd}"
            return 1
        fi
    done
    
    # Check if config directory exists
    if [[ ! -d "${CONFIG_DIR}" ]]; then
        log_message "ERROR" "Config directory not found: ${CONFIG_DIR}"
        return 1
    fi
    
    # Check if environment config exists
    if [[ ! -f "${CONFIG_DIR}/${ENVIRONMENT}.json" ]]; then
        log_message "ERROR" "Environment config not found: ${CONFIG_DIR}/${ENVIRONMENT}.json"
        return 1
    }
    
    log_message "INFO" "All prerequisites satisfied"
    return 0
}

function load_config() {
    log_message "INFO" "Loading configuration for environment: ${ENVIRONMENT}"
    
    if [[ ! -f "${CONFIG_DIR}/${ENVIRONMENT}.json" ]]; then
        log_message "ERROR" "Config file not found: ${CONFIG_DIR}/${ENVIRONMENT}.json"
        return 1
    fi
    
    # Load configuration from JSON file
    CONFIG=$(cat "${CONFIG_DIR}/${ENVIRONMENT}.json")
    
    # Extract values (use * to search for these variables)
    AWS_REGION=$(echo "${CONFIG}" | jq -r '.aws_region')
    CLUSTER_NAME=$(echo "${CONFIG}" | jq -r '.cluster_name')
    NAMESPACE=$(echo "${CONFIG}" | jq -r '.namespace')
    REPLICAS=$(echo "${CONFIG}" | jq -r '.replicas')
    
    log_message "INFO" "Loaded configuration successfully"
    log_message "DEBUG" "AWS Region: ${AWS_REGION}"
    log_message "DEBUG" "Cluster Name: ${CLUSTER_NAME}"
    log_message "DEBUG" "Namespace: ${NAMESPACE}"
    log_message "DEBUG" "Replicas: ${REPLICAS}"
    
    return 0
}

function authenticate_aws() {
    log_message "INFO" "Authenticating with AWS in region ${AWS_REGION}"
    
    # Update kubeconfig for EKS cluster
    if ! aws eks update-kubeconfig --region "${AWS_REGION}" --name "${CLUSTER_NAME}"; then
        log_message "ERROR" "Failed to update kubeconfig for cluster: ${CLUSTER_NAME}"
        return 1
    fi
    
    log_message "INFO" "Successfully authenticated with AWS"
    return 0
}

function deploy_application() {
    log_message "INFO" "Deploying application to ${ENVIRONMENT} environment"
    
    # Create namespace if it doesn't exist
    if ! kubectl get namespace "${NAMESPACE}" &> /dev/null; then
        log_message "INFO" "Creating namespace: ${NAMESPACE}"
        kubectl create namespace "${NAMESPACE}"
    fi
    
    # Apply Kubernetes manifests
    log_message "INFO" "Applying Kubernetes manifests"
    if ! kubectl apply -f "${CONFIG_DIR}/manifests" -n "${NAMESPACE}"; then
        log_message "ERROR" "Failed to apply Kubernetes manifests"
        return 1
    fi
    
    # Scale deployment
    log_message "INFO" "Scaling deployment to ${REPLICAS} replicas"
    if ! kubectl scale deployment/webapp --replicas="${REPLICAS}" -n "${NAMESPACE}"; then
        log_message "ERROR" "Failed to scale deployment"
        return 1
    fi
    
    log_message "INFO" "Application deployed successfully"
    return 0
}

function check_deployment_status() {
    log_message "INFO" "Checking deployment status"
    
    # Wait for deployment to complete
    if ! kubectl rollout status deployment/webapp -n "${NAMESPACE}" --timeout=300s; then
        log_message "ERROR" "Deployment did not complete successfully"
        return 1
    fi
    
    # Get deployment status
    READY_REPLICAS=$(kubectl get deployment/webapp -n "${NAMESPACE}" -o jsonpath='{.status.readyReplicas}')
    
    if [[ "${READY_REPLICAS}" -ne "${REPLICAS}" ]]; then
        log_message "WARNING" "Not all replicas are ready. Expected: ${REPLICAS}, Ready: ${READY_REPLICAS}"
        return 1
    fi
    
    log_message "INFO" "Deployment is healthy. All ${REPLICAS} replicas are ready."
    return 0
}

function cleanup_resources() {
    log_message "INFO" "Cleaning up temporary resources"
    
    # Clean up any temporary files or resources
    if [[ -d "${SCRIPT_DIR}/tmp" ]]; then
        rm -rf "${SCRIPT_DIR}/tmp"
    fi
    
    log_message "INFO" "Cleanup completed"
    return 0
}

# -------------------------------------------------------------------------
# MAIN SCRIPT - Practice using { and } to jump between paragraphs
# -------------------------------------------------------------------------

# Print banner
echo -e "${BLUE}"
echo "===================================================="
echo "= DevOps Deployment Script                         ="
echo "= Environment: ${ENVIRONMENT}                          ="
echo "===================================================="
echo -e "${NC}"

# Initialize log file
mkdir -p "$(dirname "${LOG_FILE}")"
echo "=== Deployment Log Started at $(date) ===" > "${LOG_FILE}"

# Check prerequisites
if ! check_prerequisites; then
    log_message "ERROR" "Prerequisites check failed. Exiting."
    exit 1
fi

# Load configuration
if ! load_config; then
    log_message "ERROR" "Failed to load configuration. Exiting."
    exit 1
fi

# Authenticate with AWS
if ! authenticate_aws; then
    log_message "ERROR" "Failed to authenticate with AWS. Exiting."
    exit 1
fi

# Deploy application
if ! deploy_application; then
    log_message "ERROR" "Failed to deploy application. Exiting."
    exit 1
fi

# Check deployment status
if ! check_deployment_status; then
    log_message "WARNING" "Deployment may not be healthy. Please check manually."
else
    log_message "INFO" "Deployment completed successfully."
fi

# Cleanup
if ! cleanup_resources; then
    log_message "WARNING" "Cleanup may not have completed successfully."
fi

# Print summary
echo -e "${GREEN}"
echo "===================================================="
echo "= Deployment Summary                               ="
echo "===================================================="
echo "= Environment: ${ENVIRONMENT}"
echo "= Region: ${AWS_REGION}"
echo "= Cluster: ${CLUSTER_NAME}"
echo "= Namespace: ${NAMESPACE}"
echo "= Replicas: ${REPLICAS}"
echo "= Status: Deployment Completed"
echo "= Log File: ${LOG_FILE}"
echo "===================================================="
echo -e "${NC}"

log_message "INFO" "Script execution completed"
exit 0
