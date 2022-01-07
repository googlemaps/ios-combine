#!/bin/sh

PODSPEC_FILE="$1"

# Create a .zip xcframework

# 1. Update .podspec
sed -i '' '/s.user_target.*/d' $PODSPEC_FILE
sed -i '' "s/s.pod_target.*/s.pod_target_xcconfig = { 'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES' }/g" $PODSPEC_FILE

# 2. Run pod install
pod install --project-directory=Example/

# 2. Generate XCFramework
XCARCHIVE_SIM=sim.xcarchive
XCARCHIVE_IPHONE=iphone.xcarchive
XCFRAMEWORK=GoogleMapsPlatformCombine.xcframework
XCFRAMEWORK_ZIP="$XCFRAMEWORK.zip"

xcodebuild archive -workspace Example/GoogleMapsPlatformCombine.xcworkspace -scheme GoogleMapsPlatformCombine -configuration Release -destination 'generic/platform=iOS Simulator' -archivePath $XCARCHIVE_SIM SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES
xcodebuild archive -workspace Example/GoogleMapsPlatformCombine.xcworkspace -scheme GoogleMapsPlatformCombine -configuration Release -destination 'generic/platform=iOS' -archivePath $XCARCHIVE_IPHONE SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES
xcodebuild -create-xcframework -framework $XCARCHIVE_IPHONE/Products/Library/Frameworks/GoogleMapsPlatformCombine.framework -framework $XCARCHIVE_SIM/Products/Library/Frameworks/GoogleMapsPlatformCombine.framework -output $XCFRAMEWORK
zip -r $XCFRAMEWORK_ZIP $XCFRAMEWORK

# 3. Update Package.swift
CHECKSUM=$(swift package compute-checksum $XCFRAMEWORK_ZIP)
sed -i '' "s/checksum: \"[a-z0-9]*\"/checksum: \"$CHECKSUM\"/g" Package.swift

