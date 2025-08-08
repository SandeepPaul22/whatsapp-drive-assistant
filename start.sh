#!/bin/bash
# Start n8n with Docker Compose

echo "Starting WhatsApp Drive Assistant..."

# Check if .env exists
if [ ! -f .env ]; then
    echo "❌ .env file not found. Please copy .env-sample to .env and configure it."
    exit 1
fi

# Start services
docker-compose up -d

echo "✅ Services starting..."
echo "📱 n8n will be available at: http://localhost:5678"
echo "🔍 Check logs with: docker-compose logs -f n8n"
