# Complete Chatify Deployment Guide

## Overview
- **Frontend**: React + Vite → **Netlify**
- **Backend**: Node.js + Express + Socket.io → **Railway** or **Render**
- **Database**: MongoDB Atlas (free tier)

---

## Part 1: Prepare Your Project

### 1.1 Push Code to GitHub
```bash
cd c:\Users\mrbim\Downloads\Chatify\Chatify
git add .
git commit -m "Ready for production deployment"
git push origin main
```

**Verify**: Your code is at `https://github.com/Bmbimal/Chatify`

---

## Part 2: Deploy Backend to Railway

Railway is the easiest for Node.js apps. Follow these steps:

### 2.1 Go to Railway Dashboard
- Open: https://railway.app
- Click **"Create Project"** or **"New Project"**

### 2.2 Connect GitHub
- Select **"Deploy from GitHub repo"**
- Click **"Authorize GitHub"** if needed
- Search and select **"Chatify"** repository
- Select **"main"** branch

### 2.3 Railway Auto-detects Settings
- Build command: `npm install --prefix backend && npm install --prefix frontend`
- Start command: `npm start --prefix backend`
- Root directory: `./` (or leave blank)

### 2.4 Add Environment Variables
In Railway dashboard:
1. Click **"Variables"** tab
2. Click **"Add variable"** and paste each line:

```
MONGODB_URI=mongodb://127.0.0.1:27017/chatify
NODE_ENV=production
PORT=3000
JWT_SECRET=5ee469e5770735d094cc543ad83fe2f983401ec53d47a689058e10b3284bfdf6
RESEND_API_KEY=re_AUQ44cg8_Mu9BgQWCjaM29fPyEJHy1fvx
EMAIL_FROM=onboarding@resend.dev
EMAIL_FROM_NAME=Chatify
CLOUDINARY_CLOUD_NAME=dxrgpag3r
CLOUDINARY_API_KEY=591439529882737
CLOUDINARY_API_SECRET=6_-Ui6bwTgdpBMg432jSEy42jg8
ARCJET_KEY=ajkey_01knkanh4qf9nr6jpaq1pdyhvh
ARCJET_ENV=production
CLIENT_URL=https://your-netlify-domain.netlify.app
```

**Note**: Leave `CLIENT_URL` empty for now. You'll update it after deploying to Netlify.

### 2.5 Deploy
- Click **"Deploy"**
- Wait 3-5 minutes for build
- **Copy the generated URL** (e.g., `https://chatify-prod-xyz123.railway.app`)
- This is your **BACKEND_URL**

### 2.6 Update CLIENT_URL in Railway
1. Go back to Railway **Variables**
2. Update `CLIENT_URL=https://your-netlify-domain.netlify.app` *(after Step 3)*
3. Save and redeploy

---

## Part 3: Deploy Frontend to Netlify

### 3.1 Go to Netlify
- Open: https://app.netlify.com
- Click **"Add new site"** or **"New site"**

### 3.2 Connect GitHub
- Select **"Import an existing project"**
- Click **"GitHub"** to authorize
- Search for and select **"Bmbimal/Chatify"**

### 3.3 Configure Build Settings
Netlify auto-detects from `netlify.toml`:
- **Build command**: `npm run build`
- **Publish directory**: `frontend/dist`
- **Base directory**: `./` (root)

These are already configured in your project! ✅

### 3.4 Add Environment Variables
Before deploying:
1. Click **"Show advanced"** (if not visible)
2. Click **"Add environment variable"**
3. Add:
   ```
   VITE_API_BASE_URL=https://your-railway-url.railway.app
   ```
   (Use the BACKEND_URL from Step 2.5)

### 3.5 Deploy
- Click **"Deploy site"**
- Wait 2-3 minutes for build
- You'll get a **Netlify URL** (e.g., `https://chatify-site.netlify.app`)
- This is your **FRONTEND_URL**

---

## Part 4: Link Backend & Frontend

### 4.1 Update Railway with Frontend URL
1. Go back to **Railway dashboard**
2. Click **"Variables"**
3. Update `CLIENT_URL=https://your-netlify-domain.netlify.app`
4. Click **"Deploy"** to redeploy backend

### 4.2 Verify Connection
1. Open your Netlify URL: `https://chatify-site.netlify.app`
2. Try signing up or sending a message
3. Check browser **DevTools → Network** for API calls to your Railway backend
4. Should show requests to `https://your-railway-url.railway.app/api/...`

---

## Part 5: Database Setup (IMPORTANT)

Your current setup uses local MongoDB. For production:

### Option A: MongoDB Atlas (Recommended - Free)
1. Go to https://www.mongodb.com/cloud/atlas
2. Create free account
3. Create free cluster
4. Get connection string: `mongodb+srv://user:pass@cluster.mongodb.net/chatify`
5. Update `MONGODB_URI` in Railway variables

### Option B: MongoDB in Railway
1. In Railway dashboard, click **"Create"**
2. Add **"MongoDB"** plugin
3. It auto-generates `MONGODB_URI`
4. Use that in backend variables

---

## Quick Reference URLs

After deployment, your URLs will be:

```
📱 Frontend: https://your-site.netlify.app
🔧 Backend:  https://your-service.railway.app
📊 Database: MongoDB Atlas or Railway MongoDB
```

---

## Testing Checklist

- [ ] Frontend loads at Netlify URL
- [ ] Can sign up / login
- [ ] Can send messages (tests backend API)
- [ ] Real-time chat works (tests Socket.io)
- [ ] Can upload images (tests Cloudinary)
- [ ] Email notifications (tests Resend)
- [ ] Rate limiting works (tests Arcjet)

---

## Troubleshooting

### Issue: CORS Error
**Fix**: Backend's `CLIENT_URL` must match your Netlify domain exactly

### Issue: Can't connect to backend
**Fix**: Check `VITE_API_BASE_URL` in Netlify environment variables

### Issue: MongoDB connection fails
**Fix**: 
- Verify `MONGODB_URI` is correct
- If using MongoDB Atlas, whitelist IP: set to `0.0.0.0`

### Issue: Socket.io not connecting
**Fix**: Ensure backend is fully deployed and accessible

---

## After Deployment

### Continuous Deployment
- Push to `main` branch → Both services auto-update
- Railway: Auto-rebuilds backend
- Netlify: Auto-rebuilds frontend

### Custom Domain (Optional)
1. Buy domain (GoDaddy, Namecheap, etc.)
2. Netlify → Domain settings → Add custom domain
3. Follow DNS setup instructions
4. SSL is free and automatic

### Monitoring
- Railway: Dashboard shows logs and metrics
- Netlify: Functions tab shows frontend logs
- Check email/Slack for deployment notifications

---

## Summary

1. ✅ Code pushed to GitHub (done)
2. 🚀 Deploy backend to Railway (get BACKEND_URL)
3. 🚀 Deploy frontend to Netlify (get FRONTEND_URL)
4. 🔗 Link them with environment variables
5. 📊 Setup production MongoDB
6. ✅ Test everything works
7. 🎉 Done!

**Estimated time: 10-15 minutes**
