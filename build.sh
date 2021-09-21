#!/bin/sh

DERIVED_DATA_DIR="DerivedData"
PRODUCTS_DIR="${DERIVED_DATA_DIR}/Build/Products"

# carthage adds these, not sure if necessary
EXTRA_ARGS="ONLY_ACTIVE_ARCH=NO CODE_SIGNING_REQUIRED=NO CODE_SIGN_IDENTITY="

# Embed bitcode for iphoneos binaries
EXTRA_IPHONEOS_ARGS="ENABLE_BITCODE=YES BITCODE_GENERATION_MODE=bitcode"

# libetpan has been set up to build an xcframework for libsasl2, however xcframeworks must exist at the *start* of the build process
# I didn't have time to figure out something less awful than building libetpan first
# It'll copy sasl.xcframework to the build directory
xcodebuild -project build-mac/mailcore2.xcodeproj -scheme "libetpan ios" -configuration Release -derivedDataPath ${DERIVED_DATA_DIR} -sdk iphoneos ${EXTRA_ARGS} ${EXTRA_IPHONEOS_ARGS}
xcodebuild -project build-mac/mailcore2.xcodeproj -scheme "libetpan ios" -configuration Release -derivedDataPath ${DERIVED_DATA_DIR} -sdk iphonesimulator ${EXTRA_ARGS}

# mailcore2 references the sasl.xcframework in the build directory
xcodebuild -project build-mac/mailcore2.xcodeproj -scheme "mailcore ios" -configuration Release -derivedDataPath ${DERIVED_DATA_DIR} -sdk iphoneos ${EXTRA_ARGS} ${EXTRA_IPHONEOS_ARGS}
xcodebuild -project build-mac/mailcore2.xcodeproj -scheme "mailcore ios" -configuration Release -derivedDataPath ${DERIVED_DATA_DIR} -sdk iphonesimulator ${EXTRA_ARGS}

# glue it all together
# note -debug-symbols path has to be absolute, see https://developer.apple.com/forums/thread/655768
xcodebuild -create-xcframework \
    -framework "${PRODUCTS_DIR}/Release-iphoneos/MailCore.framework" \
    -debug-symbols "${PWD}/${PRODUCTS_DIR}/Release-iphoneos/MailCore.framework.dSYM" \
    -framework "${PRODUCTS_DIR}/Release-iphonesimulator/MailCore.framework" \
    -debug-symbols "${PWD}/${PRODUCTS_DIR}/Release-iphonesimulator/MailCore.framework.dSYM" \
    -output "${PRODUCTS_DIR}/MailCore.xcframework"
