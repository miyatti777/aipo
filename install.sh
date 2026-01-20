#!/bin/bash
#
# AIPO Installer
# Installs AIPO commands and skills for Cursor or Claude Code
#

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Default to Cursor
TARGET_ENV="${1:-.cursor}"

# Validate target environment
if [[ "$TARGET_ENV" != ".cursor" && "$TARGET_ENV" != ".claude" ]]; then
    echo "Usage: ./install.sh [.cursor|.claude]"
    echo ""
    echo "Examples:"
    echo "  ./install.sh           # Install for Cursor (default)"
    echo "  ./install.sh .cursor   # Install for Cursor"
    echo "  ./install.sh .claude   # Install for Claude Code"
    exit 1
fi

echo "🚀 Installing AIPO for $TARGET_ENV..."

# Create directories
mkdir -p "$TARGET_ENV/commands/aipo"
mkdir -p "$TARGET_ENV/skills/aipo"

# Copy commands
echo "📋 Copying commands..."
cp -r "$SCRIPT_DIR/commands/"* "$TARGET_ENV/commands/aipo/"

# Copy skills
echo "📚 Copying skills..."
cp -r "$SCRIPT_DIR/skills/"* "$TARGET_ENV/skills/aipo/"

# Update paths in command files (relative -> absolute for target env)
echo "🔧 Updating paths..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    find "$TARGET_ENV/commands/aipo" -name "*.md" -exec sed -i '' "s|\.\./skills/|$TARGET_ENV/skills/aipo/|g" {} \;
else
    # Linux
    find "$TARGET_ENV/commands/aipo" -name "*.md" -exec sed -i "s|\.\./skills/|$TARGET_ENV/skills/aipo/|g" {} \;
fi

echo ""
echo "✅ AIPO installed successfully!"
echo ""
echo "📁 Structure:"
echo "   $TARGET_ENV/commands/aipo/  - 5 commands"
echo "   $TARGET_ENV/skills/aipo/    - Skills & templates"
echo ""
echo "🎯 Get started:"
echo "   /aipo/01_sense を実行してください"
echo "   Goal: [あなたのゴールをここに]"
