# Quick Netlify Deployment Guide

## For Frontend Only (Recommended Approach)

### Step 1: Push to GitHub
```bash
git add .
git commit -m "Ready for deployment"
git push origin main
```

### Step 2: Deploy to Netlify
1. Go to https://app.netlify.com
2. Click "Add new site" → "Import an existing project"
3. Connect GitHub and select your repository
4. Build settings will auto-detect from `netlify.toml`
5. Click "Deploy"

**Your frontend will be live at**: `https://your-site-name.netlify.app`

---

## For Backend Deployment (Choose One)

### Quick Option: Deploy with Railway (Easiest)

1. Go to https://railway.app
2. Click "Create Project" → "Deploy from GitHub repo"
3. Select your repository
4. In Variables tab, paste from `.env.example`:
   ```
   MONGODB_URI=mongodb+srv://...
   JWT_SECRET=generate-random-string
   RESEND_API_KEY=your_key
   CLOUDINARY_CLOUD_NAME=your_name
   CLOUDINARY_API_KEY=your_key
   CLOUDINARY_API_SECRET=your_secret
   ARCJET_KEY=your_key
   CLIENT_URL=your-frontend.netlify.app
   NODE_ENV=production
   ```
5. Click "Deploy"

**Your backend will be at**: `https://your-service-name.railway.app`

---

## Update Frontend with Backend URL

After backend is deployed:

1. Go to Netlify Dashboard
2. Settings → Build & deploy → Environment variables
3. Add: `VITE_API_BASE_URL=https://your-backend-url`
4. Trigger redeploy

---

## That's it! 🎉

Your Chatify app is now live and ready to use.
