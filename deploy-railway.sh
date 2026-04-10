#!/bin/bash
# Railway CLI Deployment Script for Chatify Backend

echo "🚀 Deploying Chatify Backend to Railway"
echo "========================================"

# Check if Railway CLI is installed
if ! command -v railway &> /dev/null; then
    echo "❌ Railway CLI not found. Install with: npm i -g @railway/cli"
    exit 1
fi

# Login to Railway
echo "📝 Logging into Railway..."
railway login

# Initialize Railway project
echo "🏗️ Creating Railway project..."
railway init --name chatify-backend

# Link to GitHub
echo "🔗 Linking GitHub repository..."
# This will prompt you to connect your repo

# Set environment variables
echo "⚙️ Setting environment variables..."
railway variables set MONGODB_URI=$MONGODB_URI
railway variables set NODE_ENV=production
railway variables set PORT=3000
railway variables set JWT_SECRET=$JWT_SECRET
railway variables set RESEND_API_KEY=$RESEND_API_KEY
railway variables set EMAIL_FROM=$EMAIL_FROM
railway variables set EMAIL_FROM_NAME=$EMAIL_FROM_NAME
railway variables set CLIENT_URL=$CLIENT_URL
railway variables set CLOUDINARY_CLOUD_NAME=$CLOUDINARY_CLOUD_NAME
railway variables set CLOUDINARY_API_KEY=$CLOUDINARY_API_KEY
railway variables set CLOUDINARY_API_SECRET=$CLOUDINARY_API_SECRET
railway variables set ARCJET_KEY=$ARCJET_KEY
railway variables set ARCJET_ENV=production

# Deploy
echo "📤 Deploying to Railway..."
railway up

echo "✅ Deployment complete!"
echo "🌐 Your backend URL: $(railway status)"
