// Copyright 2021 Google LLC
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

//
//  PlacesClientFake.swift
//  GoogleMapsPlatformCombine-Unit-Tests
//
//  Created by Chris Arriola on 11/11/21.
//

import Combine
import Foundation
import GooglePlaces

class PlacesClientFake : GMSPlacesClient {

    var mockFindAutocompletePredictions: ([GMSAutocompletePrediction]?, Error?)?
    var mockFindPlaceLikelihoodsFromCurrentLocation: ([GMSPlaceLikelihood]?, Error?)?

    override func findAutocompletePredictions(fromQuery query: String, filter: GMSAutocompleteFilter?, sessionToken: GMSAutocompleteSessionToken?, callback: @escaping GMSAutocompletePredictionsCallback) {
        guard let response = mockFindAutocompletePredictions else {
            callback(nil, nil)
            return
        }
        callback(response.0, response.1)
    }

    override func findPlaceLikelihoodsFromCurrentLocation(withPlaceFields placeFields: GMSPlaceField, callback: @escaping GMSPlaceLikelihoodsCallback) {
        guard let response = mockFindPlaceLikelihoodsFromCurrentLocation else {
            callback(nil, nil)
            return
        }
        callback(response.0, response.1)
    }
}
