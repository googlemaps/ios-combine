[![Version](https://img.shields.io/cocoapods/v/GoogleMapsPlatformCombine.svg?style=flat)](https://cocoapods.org/pods/GoogleMapsPlatformCombine)
[![License](https://img.shields.io/cocoapods/l/GoogleMapsPlatformCombine.svg?style=flat)](https://cocoapods.org/pods/GoogleMapsPlatformCombine)
[![Platform](https://img.shields.io/cocoapods/p/GoogleMapsPlatformCombine.svg?style=flat)](https://cocoapods.org/pods/GoogleMapsPlatformCombine)

GoogleMapsPlatformCombine
=======================

## Description
A Swift ilbrary containing Combine support, via `Publisher` and `Future`, for Google Maps Platform iOS SDKs.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
* Deployment Target of iOS 13.0+

## Installation

### [CocoaPods](https://cocoapods.org)

In your `Podfile`:

```ruby
pod 'GoogleMapsPlatformCombine', '0.1.0'
```

Subspecs are also available if you only need Combine support for a specific SDK:

```ruby
# For Combine support for the Maps SDK for iOS only
pod 'GoogleMapsPlatformCombine/Maps', '0.1.0'

# For Combine support for the Places SDK for iOS only
pod 'GoogleMapsPlatformCombine/Places', '0.1.0'
```

### [Swift Package Manager](https://github.com/apple/swift-package-manager)

// TODO

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
