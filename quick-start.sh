#!/bin/bash
# Quick Start Script for WhatsApp Google Drive Assistant

echo "🚀 WhatsApp Google Drive Assistant - Quick Start"
echo "=============================================="

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker not found. Please install Docker Desktop first."
    echo "   Download from: https://www.docker.com/products/docker-desktop"
    exit 1
fi

# Check if Docker Compose is available
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose not found. Please install Docker Desktop first."
    exit 1
fi

echo "✅ Docker is installed"

# Check if .env exists
if [ ! -f .env ]; then
    echo "⚠️  .env file not found. Creating from template..."
    if [ -f .env-sample ]; then
        cp .env-sample .env
        echo "✅ Created .env from template"
        echo "📝 IMPORTANT: Please edit .env file with your API credentials:"
        echo "   - TWILIO_ACCOUNT_SID and TWILIO_AUTH_TOKEN"
        echo "   - GOOGLE_CLIENT_ID and GOOGLE_CLIENT_SECRET"  
        echo "   - OPENAI_API_KEY"
        echo ""
        echo "⏳ Waiting for you to configure .env..."
        read -p "Press Enter when you've edited the .env file with your credentials..."
    else
        echo "❌ .env-sample not found. Please ensure all project files are present."
        exit 1
    fi
else
    echo "✅ .env file found"
fi

echo "🐳 Starting Docker services..."
echo "   - PostgreSQL database"
echo "   - n8n workflow engine"

# Start services
docker-compose up -d

if [ $? -eq 0 ]; then
    echo "✅ Docker services started successfully!"

    echo "⏳ Waiting for services to fully initialize..."
    echo "   This may take 30-60 seconds..."

    # Wait for services to be ready
    sleep 15

    # Check if n8n is responding
    for i in {1..12}; do
        if curl -s http://localhost:5678 > /dev/null 2>&1; then
            echo "✅ n8n is ready!"
            break
        else
            echo "⏳ Still waiting for n8n... (attempt $i/12)"
            sleep 5
        fi

        if [ $i -eq 12 ]; then
            echo "⚠️  n8n may still be starting. Check logs with: docker-compose logs -f n8n"
        fi
    done

    echo ""
    echo "🎉 Setup Complete!"
    echo "=================="
    echo "🌐 n8n Interface: http://localhost:5678"
    echo "👤 Username: admin (or as set in .env)"
    echo "🔑 Password: (as set in .env)"
    echo ""
    echo "📋 Next Steps:"
    echo "   1. Open http://localhost:5678 in your browser"
    echo "   2. Login with your credentials"  
    echo "   3. Import the workflow: whatsapp-drive-assistant-workflow.json"
    echo "   4. Configure API credentials in n8n"
    echo "   5. Set webhook URL in Twilio WhatsApp Sandbox"
    echo "   6. Test with WhatsApp commands"
    echo ""
    echo "📖 Full setup guide: README.md"
    echo "🔧 View logs: docker-compose logs -f n8n"
    echo "🛑 Stop services: docker-compose down"

else
    echo "❌ Failed to start Docker services"
    echo "🔍 Check logs: docker-compose logs"
    exit 1
fi
