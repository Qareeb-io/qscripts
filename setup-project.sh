#!/usr/bin/env bash
set -e

read -rp "enter github ssh url: " REPO_URL

if [ -z "$REPO_URL" ]; then
    echo "github url is required"
    exit 1
fi

REPO_NAME="$(basename "$REPO_URL" .git)"

echo "📦 cloning repository"
git clone "$REPO_URL"

cd "$REPO_NAME"

if [ ! -f ".env.example" ]; then
    echo ".env.example not found"
    exit 1
fi

echo "creating .env file"
cp .env.example .env

if grep -q '^DOMAIN_NAME=' .env; then
    read -rp "enter domain name: " DOMAIN_NAME

    if [ -z "$DOMAIN_NAME" ]; then
        echo "domain name is required"
        exit 1
    fi

    sed -i "s|^DOMAIN_NAME=.*|DOMAIN_NAME=$DOMAIN_NAME|" .env
fi

if [ -d "frontend" ]; then
    if [ -f "frontend/.env.example" ]; then
        echo "🎨 setting up frontend env"
        cd frontend
        cp .env.example .env
        cd ..
    fi
fi

echo "✅ project setup completed successfully"
