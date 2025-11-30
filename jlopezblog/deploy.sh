#!/bin/bash

# --- 1. Clean and Build Hugo Site ---
echo "▶️ Building Hugo site..."
# Clear the public folder before building (optional, but good practice)
rm -rf public/*
# Build the site (-D includes drafts, remove if not needed)
hugo -D

# Check if build was successful
if [ $? -ne 0 ]; then
    echo "❌ Hugo build failed. Aborting deployment."
    exit 1
fi
echo "✅ Hugo build successful."

# --- 2. Commit and Push the Submodule (Deployment Repo) ---
echo "▶️ Committing static files to the DEPLOYMENT repo (public/)..."

# Go into the submodule directory
cd public

# --- ENSURE WE ARE ON THE CORRECT BRANCH AND UP-TO-DATE ---
git checkout main 
git pull origin main

# Stage all changes in the deployment repo
git add .


# Stage all changes in the deployment repo
git add .

# Check if there are any changes to commit
if git diff --cached --quiet; then
    echo "ℹ️ No changes found in static files. Skipping deployment push."
else
    # Commit changes
    git commit -m "Site rebuild: $(date +%Y-%m-%d\ %H:%M:%S)"
    # Push the static files to the deployment repo's origin
    git push origin main
    echo "✅ Static files pushed to deployment repo."
fi

# --- 3. Commit and Push the Main (Source) Repo ---
echo "▶️ Committing submodule reference to the SOURCE repo..."

# Go back to the root of the main source repository
cd ..

# Stage the public folder with the --force flag to track the updated submodule pointer
git add -f public

# Commit the submodule reference change
git commit -m "Updated public submodule to the latest deployment commit"

# Push the source repo changes
git push origin main
echo "✅ Source repo and submodule pointer updated and pushed."

echo "🎉 Deployment complete!"