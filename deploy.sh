#!/usr/bin/env bash
set -e

PROJECT=""
BRANCH="main"

if [ "$#" -gt 0 ] && [ "${1#--}" = "$1" ]; then
    PROJECT="$1"
    shift
fi

while [ "$#" -gt 0 ]; do
    case "$1" in
        --branch)
            BRANCH="$2"
            shift 2
            ;;
        *)
            echo "❌ unknown option: $1"
            exit 1
            ;;
    esac
done

if [ -z "$PROJECT" ]; then
    read -rp "enter project name (directory path starting from the home dir): " PROJECT
fi

if [ -z "$PROJECT" ]; then
    echo "project name is required"
    exit 1
fi

PROJECT_DIR="$HOME/$PROJECT"

echo "starting deployment for $PROJECT on branch $BRANCH"

if [ -d "$PROJECT_DIR" ]; then
    cd "$PROJECT_DIR"
else
    echo "directory $PROJECT_DIR does not exist"
    exit 1
fi

echo "📦 updating code"
git fetch origin
git checkout "$BRANCH"
git reset --hard "origin/$BRANCH"

echo "⚙️ running production script"
./scripts/run-prod.sh

echo "✅ deployment finished successfully"
