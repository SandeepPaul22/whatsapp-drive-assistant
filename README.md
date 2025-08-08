# WhatsApp-Driven Google Drive Assistant (n8n workflow)

A complete n8n automation workflow that allows users to manage their Google Drive files through simple WhatsApp commands.

## 🚀 Features

- **WhatsApp Integration**: Send commands via WhatsApp using Twilio Sandbox
- **Google Drive Operations**: List, delete, move files and folders  
- **AI Document Summarization**: Get bullet-point summaries of PDFs, DOCX, and text files using OpenAI GPT-4
- **Safety Mechanisms**: Confirmation required for delete operations to prevent accidents
- **Audit Logging**: All actions logged to Google Sheets for security and compliance
- **Docker Deployment**: Ready-to-deploy containerized setup with PostgreSQL

## 📋 Commands Syntax

Send these commands via WhatsApp:

- `LIST /ProjectX` - List files in the /ProjectX folder
- `DELETE /ProjectX/report.pdf CONFIRM` - Delete a file (confirmation required)
- `MOVE /ProjectX/report.pdf /Archive` - Move file to Archive folder  
- `SUMMARY /ProjectX/document.pdf` - Get AI summary of document content
- `HELP` - Show available commands

## 🛠 Quick Setup

### Prerequisites
- Twilio account with WhatsApp Sandbox
- Google Cloud Platform account (Drive API enabled)
- OpenAI API key
- Docker & Docker Compose installed

### 1. Clone and Configure
```bash
git clone <repository-url>
cd whatsapp-drive-assistant
cp .env-sample .env
# Edit .env with your API keys and credentials
```

### 2. Start Services
```bash
./start.sh
# Or manually: docker-compose up -d
```

### 3. Import Workflow
- Access n8n at http://localhost:5678
- Import `whatsapp-drive-assistant-workflow.json`
- Configure credentials (Twilio, Google OAuth2, OpenAI)

### 4. Configure Twilio Webhook
- Get webhook URL from n8n: `https://your-domain.com/webhook/whatsapp-webhook`
- Set this URL in Twilio WhatsApp Sandbox settings

## 🏗 Architecture

The workflow consists of 12 connected nodes:

1. **WhatsApp Webhook** - Receives messages from Twilio
2. **Parse Command** - Extracts command and parameters
3. **Command Router** - Routes to appropriate Google Drive operation
4. **Google Drive Nodes** - Handle file operations (list, download, delete, move)
5. **Text Extraction** - Extracts content from various file formats
6. **OpenAI Summarization** - Generates concise document summaries
7. **Response Formatting** - Prepares user-friendly replies
8. **WhatsApp Reply** - Sends response back via Twilio
9. **Audit Logging** - Records all actions to Google Sheets
10. **Webhook Response** - Confirms receipt to Twilio

## 🔒 Security Features

- **Confirmation Required**: DELETE operations require explicit "CONFIRM" keyword
- **Audit Trail**: All actions logged with timestamp, user, command, and status
- **OAuth2 Authentication**: Secure Google Drive access using user's own credentials
- **Webhook Authentication**: Optional API key protection for webhook endpoint
- **Rate Limiting**: Built-in protections against command spam

## 📂 Repository Structure

```
whatsapp-drive-assistant/
├── whatsapp-drive-assistant-workflow.json  # Main n8n workflow
├── docker-compose.yml                      # Docker deployment config
├── .env-sample                             # Environment variables template
├── README.md                               # Setup guide
├── start.sh                                # Helper script to start services
├── stop.sh                                 # Helper script to stop services  
├── logs.sh                                 # View n8n logs
├── backup.sh                               # Backup workflows and data
└── docs/
    └── DEMO.md                             # Demo video instructions
```

## 🎥 Demo Video Script

1. **Setup Demonstration** (2 minutes)
   - Show Twilio WhatsApp Sandbox configuration
   - Import n8n workflow
   - Configure Google Drive and OpenAI credentials

2. **Command Testing** (2 minutes)
   - Send "HELP" command and show response
   - Demonstrate "LIST /Documents" showing files
   - Show "SUMMARY" of a PDF document with AI analysis

3. **Safety Features** (1 minute)
   - Attempt DELETE command without CONFIRM
   - Show confirmation prompt and successful deletion
   - Display audit log entry in Google Sheets

## ⚙️ Configuration Details

### Environment Variables
```bash
N8N_HOST=your-domain.com
N8N_PROTOCOL=https
WEBHOOK_URL=https://your-domain.com
TWILIO_WHATSAPP_FROM=+14155238886
```

### Required Credentials in n8n
- **Twilio API**: Account SID and Auth Token
- **Google Drive OAuth2**: Client ID and Client Secret  
- **Google Sheets OAuth2**: Same as Drive OAuth2
- **OpenAI API**: API Key for GPT-4 access

### Google Drive Scopes
```
https://www.googleapis.com/auth/drive
https://www.googleapis.com/auth/spreadsheets
```

## 🚨 Limitations & Considerations

- **Twilio Sandbox**: Limited to pre-approved phone numbers (for testing)
- **Rate Limits**: OpenAI API has usage limits for summarization
- **File Size**: Large files may timeout during summarization
- **MIME Types**: Currently supports PDF, DOCX, and plain text files
- **Security**: Operates within authenticated user's Google Drive only

## 🔧 Troubleshooting

### Common Issues
1. **Webhook not receiving messages**: Check Twilio sandbox URL configuration
2. **Google Drive access denied**: Verify OAuth2 credentials and scopes  
3. **OpenAI summarization fails**: Check API key and usage limits
4. **Audit logging not working**: Confirm Google Sheets document ID and permissions

### Debug Commands
```bash
# View n8n logs
./logs.sh

# Check container status
docker-compose ps

# Restart services
./stop.sh && ./start.sh
```

## 📈 Extensions & Customizations

### Possible Enhancements
- **Natural Language Processing**: Parse commands in conversational language
- **File Upload**: Support uploading files via WhatsApp to Google Drive
- **Advanced Search**: Implement fuzzy search and content-based filtering
- **Multi-user Support**: Handle multiple Google accounts per WhatsApp user
- **Scheduled Operations**: Set up recurring file organization tasks

### Custom Command Development
Add new commands by:
1. Extending the `Parse Command` function node
2. Adding new conditions to `Command Router`
3. Creating corresponding Google Drive operation nodes
4. Updating the response formatter

## 📄 License

MIT License - See LICENSE file for details.

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/new-command`)
3. Commit changes (`git commit -am 'Add new command'`)
4. Push to branch (`git push origin feature/new-command`)
5. Create Pull Request

## 📞 Support

- GitHub Issues: Report bugs and feature requests
- Documentation: Check README and inline code comments
- Community: Join n8n Discord for workflow discussions

---
