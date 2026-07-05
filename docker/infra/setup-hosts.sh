#!/bin/bash
# Tiago Apps - Setup Local Hosts Script
# =================================
#
# This script adds the local development domains to your /etc/hosts file.
# Run with sudo: sudo ./docker/infra/setup-hosts.sh
#
# The script is idempotent - it checks if entries already exist before adding.

set -e

HOSTS_FILE="/etc/hosts"
MARKER="# Tiago Apps Local Development"

# Domains to add
DOMAINS=(
    "127.0.0.1 hourledger.local.com"
    "127.0.0.1 app.hourledger.local.com"
    "127.0.0.1 admin.hourledger.local.com"
    "127.0.0.1 api.hourledger.local.com"
)

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run with sudo: sudo $0"
    exit 1
fi

# Check if marker already exists
if grep -q "$MARKER" "$HOSTS_FILE"; then
    echo "Tiago Apps hosts entries already exist in $HOSTS_FILE"
    echo "To update, first remove the existing entries manually."
    exit 0
fi

# Create backup
cp "$HOSTS_FILE" "${HOSTS_FILE}.bak.$(date +%Y%m%d%H%M%S)"
echo "Backup created at ${HOSTS_FILE}.bak.*"

# Add entries
echo "" >> "$HOSTS_FILE"
echo "$MARKER" >> "$HOSTS_FILE"

for domain in "${DOMAINS[@]}"; do
    echo "$domain" >> "$HOSTS_FILE"
    echo "Added: $domain"
done

echo "$MARKER END" >> "$HOSTS_FILE"
echo ""
echo "Successfully added Tiago Apps local domains to $HOSTS_FILE"
echo ""
echo "You can now access:"
echo "  - Landing Page: http://hourledger.local.com"
echo "  - Customer App: http://app.hourledger.local.com"
echo "  - Backoffice:   http://admin.hourledger.local.com"
echo "  - API:          http://api.hourledger.local.com"
