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
    "127.0.0.1 local.tiagoapps.com.br"
    "127.0.0.1 app.local.tiagoapps.com.br"
    "127.0.0.1 admin.local.tiagoapps.com.br"
    "127.0.0.1 api.local.tiagoapps.com.br"
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
echo "  - Landing Page: http://local.tiagoapps.com.br"
echo "  - Customer App: http://app.local.tiagoapps.com.br"
echo "  - Backoffice:   http://admin.local.tiagoapps.com.br"
echo "  - API:          http://api.local.tiagoapps.com.br"
