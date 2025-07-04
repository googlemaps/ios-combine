[![Run unit tests](https://github.com/googlemaps/ios-combine/actions/workflows/test.yml/badge.svg?branch=main)](https://github.com/googlemaps/ios-combine/actions/workflows/test.yml)
[![pod](https://img.shields.io/cocoapods/v/GoogleMapsPlatformCombine)](https://cocoapods.org/pods/GoogleMapsPlatformCombine)
![Apache-2.0](https://img.shields.io/badge/license-Apache-blue)

GoogleMapsPlatformCombine
=======================

## Description
A Swift ilbrary containing Combine support, via `Publisher` and `Future`, for Google Maps Platform iOS SDKs.

## Example

### Example Usage

```swift
// Create a GMSMapViewPublisher
let publisher = GMSMapViewPublisher(mapView: mapView)

// Subscribe to events
publisher.didChangeCameraPosition.sink { cameraPosition in
  print("Camera position at \(cameraPosition.target)")
}
```

### Example Project

To run the example project:

1. Run `pod install` from the Example/ directory. 
2. Open the `GoogleMapsPlatformCombine.xcworkspace` file in Xcode

## Requirements
* Deployment Target of iOS 13.0+

## Installation

### [CocoaPods](https://cocoapods.org)

In your `Podfile`:

```ruby
pod 'GoogleMapsPlatformCombine', '0.3.1'
```

Subspecs are also available if you only need Combine support for a specific SDK:

```ruby
# For Combine support for the Maps SDK for iOS only
pod 'GoogleMapsPlatformCombine/Maps', '0.3.1'

# For Combine support for the Places SDK for iOS only
pod 'GoogleMapsPlatformCombine/Places', '0.3.1'
```

### [Swift Package Manager](https://github.com/apple/swift-package-manager)

Since the Maps/Places SDKs for iOS are not yet supported in SPM, if you install
this library via SPM you will need to also install Maps/Places using one of the
supported package managers. See installation options for [Maps][maps-install]
and [Places][places-install] for more information.

## Terms of Service

This sample uses Google Maps Platform services. Use of Google Maps Platform
services through this sample is subject to the
[Google Maps Platform Terms of Service](https://cloud.google.com/maps-platform/terms).

**European Economic Area (EEA) developers**

If your billing address is in the European Economic Area, effective on 8 July 2025, the [Google Maps Platform EEA Terms of Service](https://cloud.google.com/terms/maps-platform/eea) will apply to your use of the Services. Functionality varies by region. [Learn more](https://developers.google.com/maps/comms/eea/faq).

## Support

Encounter an issue while using this library?

If you find a bug or have a feature request, please file an [issue].
Or, if you'd like to contribute, please refer to our [contributing guide][contributing] and our [code of conduct].

You can also reach us on our [Discord channel].

For more information, check out the detailed guide on the
[Google Developers site][devsite-guide].

[maps-install]: https://developers.google.com/maps/documentation/ios-sdk/start#download-sdk
[places-install]: https://developers.google.com/maps/documentation/places/ios-sdk/start#step-2:-install-the-sdk
[contributing]: CONTRIBUTING.md
[code of conduct]: CODE_OF_CONDUCT.md
[Discord channel]: https://discord.gg/9fwRNWg
[issue]: https://github.com/googlemaps/ios-combine/issues
[devsite-guide]: https://developers.google.com/maps/documentation/ios-sdk/overview
