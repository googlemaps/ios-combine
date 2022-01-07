// swift-tools-version:5.4

// Copyright 2022 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import PackageDescription

let package = Package(
    name: "GoogleMapsPlatformCombine",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "GoogleMapsPlatformCombineMaps",
            targets: ["GoogleMapsPlatformCombineMaps"]
        ),
        .library(
            name: "GoogleMapsPlatformCombinePlaces",
            targets: ["GoogleMapsPlatformCombinePlaces"]
        )
    ],
    dependencies: [
        .package(
            name: "OCMock",
            url: "https://github.com/erikdoe/ocmock.git",
            .revision("c5eeaa6dde7c308a5ce48ae4d4530462dd3a1110")
        )
    ],
    targets: [
        .target(
            name: "GoogleMapsPlatformCombineMaps",
            path: "Sources/Maps"
        ),
        .target(
            name: "GoogleMapsPlatformCombinePlaces",
            path: "Sources/Places"
        )
        // Disabling test target until Maps/Places supports SPM
        // https://corp.google.com/issues/141721633
        //
        //.testTarget(
        //    name: "GoogleMapsPlatformCombineUnitTests",
        //    dependencies: ["OCMock"],
        //    path: "Tests"
        //)
    ]
)
