[![Run unit tests](https://github.com/googlemaps/ios-combine/actions/workflows/test.yml/badge.svg?branch=main)](https://github.com/googlemaps/ios-combine/actions/workflows/test.yml)
[![pod](https://img.shields.io/cocoapods/v/GoogleMapsPlatformCombine)](https://cocoapods.org/pods/GoogleMapsPlatformCombine)

![Alpha release](https://img.shields.io/badge/release-alpha-orange)
![Release](https://github.com/googlemaps/ios-combine/workflows/Release/badge.svg)

[![Tests/Build Status](https://github.com/googlemaps/ios-combine/actions/workflows/test.yml/badge.svg)](https://github.com/googlemaps/ios-combine/actions/workflows/test.yml)

![GitHub contributors](https://img.shields.io/github/contributors/googlemaps/ios-combine?color=green)
[![GitHub License](https://img.shields.io/github/license/googlemaps/ios-combine?color=blue)][license]
[![Discord](https://img.shields.io/discord/676948200904589322?color=6A7EC2&logo=discord&logoColor=ffffff)][Discord server]

# Google Maps Platform Combine iOS Library (Alpha)

## Description
A Swift library containing Combine support, via `Publisher` and `Future`, for Google Maps Platform iOS SDKs.

## Requirements

* [Sign up with Google Maps Platform]
* A Google Maps Platform [project] with the **Maps SDK for iOS** enabled
* An [API key] associated with the project above
* Swift and XCode
* (Deployment target of) iOS 13+

## Usage

```swift
// Create a GMSMapViewPublisher
let publisher = GMSMapViewPublisher(mapView: mapView)

// Subscribe to events
publisher.didChangeCameraPosition.sink { cameraPosition in
  print("Camera position at \(cameraPosition.target)")
}
```

### Sample App

To run the example project:

1. Run `pod install` from the Example/ directory.
2. Open the `GoogleMapsPlatformCombine.xcworkspace` file in Xcode

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

## Contributing

Contributions are welcome and encouraged! If you'd like to contribute, send us a [pull request] and refer to our [code of conduct] and [contributing guide].

## Terms of Service

This library uses Google Maps Platform services. Use of Google Maps Platform services through this library is subject to the Google Maps Platform [Terms of Service].

This library is not a Google Maps Platform Core Service. Therefore, the Google Maps Platform Terms of Service, e.g., [Technical Support Services Guidelines], Service Level Agreement ["SLA"][SLA], and [Deprecation Policy], do not apply to the code in this library.

## Support

This library is offered via an open source [license]. It is not governed by the Google Maps Platform Support Technical Support Services Guidelines, the SLA, or the Deprecation Policy. However, any Google Maps Platform services used by the library remain subject to the Google Maps Platform Terms of Service.

This library adheres to [semantic versioning] to indicate when backwards-incompatible changes are introduced. Accordingly, while the library is in version 0.x, backwards-incompatible changes may be introduced at any time.

If you find a bug, or have a feature request, please [file an issue] on GitHub. If you would like to get answers to technical questions from other Google Maps Platform developers, ask through one of our [developer community channels]. If you'd like to contribute, please check the [contributing guide].

You can also discuss this library on our [Discord server].

[maps-install]: https://developers.google.com/maps/documentation/ios-sdk/start#download-sdk
[places-install]: https://developers.google.com/maps/documentation/places/ios-sdk/start#step-2:-install-the-sdk

[API key]: https://developers.google.com/maps/documentation/ios-sdk/get-api-key
[maps-sdk]: https://developers.google.com/maps/documentation/ios-sdk/overview
[documentation]: https://googlemaps.github.io/ios-combine

[code of conduct]: ?tab=coc-ov-file#readme
[contributing guide]: CONTRIBUTING.md
[Deprecation Policy]: https://cloud.google.com/maps-platform/terms
[developer community channels]: https://developers.google.com/maps/developer-community
[Discord server]: https://discord.gg/hYsWbmk
[file an issue]: https://github.com/googlemaps/ios-combine/issues/new/choose
[license]: LICENSE
[pull request]: https://github.com/googlemaps/ios-combine/compare
[project]: https://developers.google.com/maps/documentation/ios-sdk/cloud-setup#enabling-apis
[semantic versioning]: https://semver.org
[Sign up with Google Maps Platform]: https://console.cloud.google.com/google/maps-apis/start
[similar inquiry]: https://github.com/googlemaps/ios-combine/issues
[SLA]: https://cloud.google.com/maps-platform/terms/sla
[Technical Support Services Guidelines]: https://cloud.google.com/maps-platform/terms/tssg
[Terms of Service]: https://cloud.google.com/maps-platform/terms
