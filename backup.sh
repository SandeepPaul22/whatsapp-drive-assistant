#!/bin/bash
# Backup n8n data and workflows

BACKUP_DIR="backups/$(date +%Y%m%d_%H%M%S)"
mkdir -p $BACKUP_DIR

echo "📦 Creating backup in $BACKUP_DIR..."

# Backup docker volumes
docker run --rm -v whatsapp-drive-assistant_n8n_data:/data -v $(pwd)/$BACKUP_DIR:/backup alpine tar czf /backup/n8n_data.tar.gz -C /data .
docker run --rm -v whatsapp-drive-assistant_postgres_data:/data -v $(pwd)/$BACKUP_DIR:/backup alpine tar czf /backup/postgres_data.tar.gz -C /data .

# Copy configuration files
cp docker-compose.yml $BACKUP_DIR/
cp .env $BACKUP_DIR/
cp whatsapp-drive-assistant-workflow.json $BACKUP_DIR/

echo "✅ Backup completed: $BACKUP_DIR"
