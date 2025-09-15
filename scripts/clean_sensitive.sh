#!/bin/bash

# Clean Android sensitive files
rm -f android/app/upload-keystore.jks
rm -f android/key.properties
rm -f android/app/google-services.json

# Clean iOS sensitive files
rm -f ios/Runner/GoogleService-Info.plist
rm -rf ~/Library/MobileDevice/Provisioning\ Profiles
security delete-keychain build.keychain 2>/dev/null || true

echo "Sensitive files cleaned"