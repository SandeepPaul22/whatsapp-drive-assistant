#!/bin/bash
# View n8n logs

echo "📋 Showing n8n logs (Press Ctrl+C to exit)..."
docker-compose logs -f n8n
