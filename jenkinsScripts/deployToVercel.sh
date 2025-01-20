# jenkinsScripts/deployToVercel.sh
#!/bin/bash

# Install Vercel CLI if not already installed
npm install -g vercel

# Configure Vercel with environment variables
vercel pull --yes --environment=production --token=$VERCEL_TOKEN
vercel build --token=$VERCEL_TOKEN
vercel deploy --prebuilt --token=$VERCEL_TOKEN --prod