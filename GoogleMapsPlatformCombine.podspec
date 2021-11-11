Pod::Spec.new do |s|
  s.name             = 'GoogleMapsPlatformCombine'
  s.version          = '0.1.0'
  s.summary          = 'Swift library for Combine support with Google Maps Platform iOS SDKs'

  s.description      = <<-DESC
A swift library that provides Combine support via Publisher and Future for Google Maps Platform iOS SDKs.
                       DESC

  s.homepage         = 'https://github.com/googlemaps/ios-combine'
  s.license          = { :type => 'Apache, Version 2.0', :file => 'LICENSE' }
  s.author           = 'Google Inc.'
  s.source           = { :git => 'https://github.com/googlemaps/ios-combine.git', :tag => s.version.to_s }
  s.swift_version    = '5.0'
  s.ios.deployment_target = '13.0'

  s.source_files = 'Sources/**/*'
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

  s.subspec 'Maps' do |ss|
    ss.ios.deployment_target ='13.0'
    ss.source_files = "Sources/Maps/*"
    ss.dependency 'GoogleMaps', '5.1.0'
  end

  s.subspec 'Places' do |ss|
    ss.ios.deployment_target ='13.0'
    ss.source_files = "Sources/Places/*"
    ss.dependency 'GooglePlaces', '5.0.0'
  end

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = "Tests/Unit/**/*.swift"
    test_spec.dependency 'OCMock'
  end

  s.static_framework = true
end
