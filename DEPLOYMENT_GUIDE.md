# Chatify Deployment Guide

This guide covers deploying both the React frontend to Netlify and the Node.js/Express backend to a production server.

## Architecture Overview

- **Frontend**: React + Vite → Netlify (static hosting)
- **Backend**: Node.js + Express + Socket.io + MongoDB → Separate service (Render, Railway, or Heroku)

---

## Part 1: Frontend Deployment to Netlify

### Prerequisites
- GitHub account with the repository pushed
- Netlify account (free tier available at https://netlify.com)

### Steps

1. **Connect GitHub to Netlify**
   - Go to https://app.netlify.com
   - Click "Add new site" → "Import an existing project"
   - Authorize GitHub and select your repository

2. **Configure Build Settings**
   - **Build command**: `npm run build`
   - **Publish directory**: `frontend/dist`
   - These are already configured in `netlify.toml`

3. **Set Environment Variables**
   - In Netlify Dashboard → Site settings → Build & deploy → Environment
   - Add these variables:
     ```
     VITE_API_BASE_URL=https://your-backend-url.com
     ```
   - Replace with your actual backend URL (see Part 2)

4. **Deploy**
   - Push to main branch → Netlify auto-deploys
   - Your site will be live at: `https://your-site-name.netlify.app`

---

## Part 2: Backend Deployment

### Option A: Railway (Recommended)

Railway is ideal for Node.js apps with MongoDB integration.

#### Steps:
1. **Go to Railway**
   - Visit https://railway.app
   - Sign up with GitHub

2. **Create New Project**
   - Click "Create Project" → "Deploy from GitHub repo"
   - Select your Chatify repository
   - Choose "Node.js" service

3. **Configure MongoDB**
   - In Railway dashboard, add a MongoDB plugin
   - It will auto-generate `MONGODB_URI`

4. **Set Environment Variables**
   - In Railway → Variables tab, add:
     ```
     NODE_ENV=production
     JWT_SECRET=your_long_random_secret_here
     RESEND_API_KEY=your_resend_key
     CLOUDINARY_CLOUD_NAME=your_value
     CLOUDINARY_API_KEY=your_value
     CLOUDINARY_API_SECRET=your_value
     ARCJET_KEY=your_key
     CLIENT_URL=https://your-frontend-url.netlify.app
     PORT=3000
     ```

5. **Deploy**
   - Railway auto-deploys on push
   - Your backend URL will be shown in Railway dashboard

---

### Option B: Render.com

1. **Go to Render**
   - Visit https://render.com
   - Sign up with GitHub

2. **Create Web Service**
   - Click "Create" → "Web Service"
   - Connect GitHub repo
   - Select the repository

3. **Configure**
   - **Build command**: `npm install --prefix backend && npm install --prefix frontend`
   - **Start command**: `npm start --prefix backend`
   - **Root directory**: `./` (or leave blank)

4. **Add Environment Variables**
   - In Render dashboard, add all variables from .env.example
   - Add MongoDB URI (use MongoDB Atlas or Render's MongoDB)

5. **Deploy**
   - Click "Create Web Service"
   - Your backend URL will be: `https://your-service-name.onrender.com`

---

### Option C: Heroku (Legacy, requires updates)

If using Heroku, you'll need to set up a Procfile:

Create `Procfile` in root:
```
web: npm start --prefix backend
```

---

## Environment Variables Setup

### Step 1: Get Required Services

1. **MongoDB Atlas** (Free tier)
   - Go to https://www.mongodb.com/cloud/atlas
   - Create free cluster
   - Get connection string: `mongodb+srv://user:password@cluster.mongodb.net/chatify`

2. **Resend** (Email service)
   - Sign up at https://resend.com
   - Get API key

3. **Cloudinary** (Image hosting)
   - Sign up at https://cloudinary.com
   - Get API credentials

4. **Arcjet** (Security/Rate limiting)
   - Sign up at https://arcjet.com
   - Get API key

### Step 2: Update Backend URL in Netlify

After deploying backend, go to:
- Netlify Dashboard → Site settings → Build & deploy → Environment
- Update `VITE_API_BASE_URL` to your backend URL
- Trigger a new deploy

---

## Verify Deployment

### Test Frontend
```bash
curl https://your-site-name.netlify.app
```

### Test Backend API
```bash
curl https://your-backend-url.com/api/auth/status
```

### Check Socket.io Connection
Open your frontend and check browser DevTools → Network → check for WebSocket connection to backend

---

## Troubleshooting

### Issue: "CORS error" 
- Backend's `CLIENT_URL` must match your Netlify URL
- Check backend logs for actual request origin

### Issue: "Cannot GET /"
- Backend isn't serving frontend (in production mode)
- Check `NODE_ENV=production` is set

### Issue: Socket.io connection fails
- Ensure backend is running and accessible
- Check `VITE_API_BASE_URL` includes the backend URL

### Issue: MongoDB connection fails
- Verify `MONGODB_URI` is correct
- Check MongoDB Atlas whitelist includes the server's IP (set to 0.0.0.0)

---

## Updating After Deployment

### Frontend Updates
- Push to GitHub → Netlify auto-deploys

### Backend Updates
- Push to GitHub → Railway/Render/Heroku auto-deploys
- No action needed on frontend (API URL stays the same)

---

## Optional: Custom Domain

1. **Buy domain** (GoDaddy, Namecheap, etc.)
2. **Point to Netlify**:
   - Netlify → Site settings → Domain management
   - Add custom domain
   - Update nameservers or CNAME records

3. **SSL Certificate**: Netlify provides free HTTPS automatically

---

## Production Checklist

- [ ] MongoDB Atlas cluster created and running
- [ ] All environment variables set in both services
- [ ] Backend `CLIENT_URL` points to Netlify domain
- [ ] Frontend `VITE_API_BASE_URL` points to backend URL
- [ ] CORS enabled on backend
- [ ] JWT secret set (strong random string)
- [ ] Email service (Resend) configured
- [ ] Image hosting (Cloudinary) configured
- [ ] Rate limiting (Arcjet) configured
- [ ] Database backup configured
- [ ] Error monitoring set up (optional: Sentry, LogRocket)

