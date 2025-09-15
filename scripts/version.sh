#!/bin/bash

# Get version from pubspec.yaml
VERSION=$(grep 'version:' pubspec.yaml | sed 's/version: //g' | sed 's/+.*//')

# Get or set build number
if [ -z "$BUILD_NUMBER" ]; then
  BUILD_NUMBER=$(git rev-list --count HEAD)
fi

# Update pubspec.yaml
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  sed -i '' "s/version: .*/version: $VERSION+$BUILD_NUMBER/" pubspec.yaml
else
  # Linux
  sed -i "s/version: .*/version: $VERSION+$BUILD_NUMBER/" pubspec.yaml
fi

echo "Version: $VERSION"
echo "Build: $BUILD_NUMBER"