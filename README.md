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
pod 'GoogleMapsPlatformCombine', '0.2.0'
```

Subspecs are also available if you only need Combine support for a specific SDK:

```ruby
# For Combine support for the Maps SDK for iOS only
pod 'GoogleMapsPlatformCombine/Maps', '0.2.0'

# For Combine support for the Places SDK for iOS only
pod 'GoogleMapsPlatformCombine/Places', '0.2.0'
```

### [Swift Package Manager](https://github.com/apple/swift-package-manager)

See [#2](https://github.com/googlemaps/ios-combine/issues/2)

## Support

Encounter an issue while using this library?

If you find a bug or have a feature request, please file an [issue].
Or, if you'd like to contribute, please refer to our [contributing guide][contributing] and our [code of conduct].

You can also reach us on our [Discord channel].

For more information, check out the detailed guide on the
[Google Developers site][devsite-guide].

[contributing]: CONTRIBUTING.md
[code of conduct]: CODE_OF_CONDUCT.md
[Discord channel]: https://discord.gg/9fwRNWg
[issue]: https://github.com/googlemaps/ios-combine/issues
[devsite-guide]: https://developers.google.com/maps/documentation/ios-sdk/overview
