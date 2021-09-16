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
//  GMSPlacesClient+Combine.swift
//  GoogleMapsPlatformCombine
//
//  Created by Chris Arriola on 9/21/21.
//

import Combine
import GooglePlaces

extension GMSPlacesClient {

    /// Loads the image for a specific photo at its maximum size.
    ///
    /// Image data may be cached by the SDK. If the requested photo does not exist in the cache,
    /// then a network lookup will be performd.
    ///
    /// - Parameter photoMetadata: the metadata of the photo to load
    /// - Returns: a publisher emitting a `UIImage` instance for the requested photo
    public func loadPlacePhoto(
        photoMetadata: GMSPlacePhotoMetadata
    ) -> Future<UIImage, Error> {
        Future<UIImage, Error> { promise in
            self.loadPlacePhoto(photoMetadata) { image, error in
                if let error = error {
                    promise(.failure(error))
                } else if let image = image {
                    promise(.success(image))
                }
            }
        }
    }

    /// Loads the image for a specific photo at its maximum size.
    ///
    /// The image will be scaled to fit within the given dimensions while maintaining the aspect ratio
    /// of the original image. This scaling is performed server-side.
    ///
    /// If the scale parameter is not 1.0 maxSize will be multiplied by this value and the returned UIImage
    /// will be set to have the specified scale. This parameter should be set to the screen scale if
    /// you are loading images for display on screen.
    ///
    /// Image data may be cached by the SDK. If the requested photo does not exist in the cache
    /// then a network lookup will be performed.
    ///
    /// - Parameters:
    ///   - photoMetadata: the metadata of the photo to load
    ///   - size: the maximum size of the image
    ///   - scale: the scale to load the image at
    /// - Returns: a publisher emitting a `UIImage` instance for the requested photo
    public func loadPlacePhoto(
        photoMetadata: GMSPlacePhotoMetadata,
        constrainedTo size: CGSize,
        scale: CGFloat
    ) -> Future<UIImage, Error> {
        Future<UIImage, Error> { promise in
            self.loadPlacePhoto(photoMetadata, constrainedTo: size, scale: scale) { image, error in
                if let error = error {
                    promise(.failure(error))
                } else if let image = image {
                    promise(.success(image))
                }
            }
        }
    }

    /// Find Autocomplete predictions from text query.
    ///
    /// Results may optionally be biased towards a certain location or restricted to an area as specified in `filter`.
    ///
    /// - Parameters:
    ///   - query: the text query
    ///   - filter: (optional) a filter to apply a set of restrictions to the results
    ///   - sessionToken: (optional) a token to associate this request to a billing session
    /// - Returns: a publisher returning place predictions based on the request
    public func findAutocompletePredictions(
        from query: String,
        filter: GMSAutocompleteFilter? = nil,
        sessionToken: GMSAutocompleteSessionToken? = nil
    ) -> Future<[GMSAutocompletePrediction], Error> {
        Future<[GMSAutocompletePrediction], Error> { promise in
            self.findAutocompletePredictions(
                fromQuery: query,
                filter: filter,
                sessionToken: sessionToken
            ) { predictions, error in
                if let error = error {
                    promise(.failure(error))
                } else if let predictions = predictions {
                    promise(.success(predictions))
                }
            }
        }
    }

    /// Fetch details for a place.
    ///
    /// - Parameters:
    ///   - id: the ID of the place to fetch
    ///   - fields: the fields to be retrieved for the requested place
    ///   - sessionToken: (optional) a token to associate this request to a billing session
    /// - Returns: a publisher returning the requested place
    public func fetchPlace(
        id: String,
        fields: GMSPlaceField,
        sessionToken: GMSAutocompleteSessionToken? = nil
    ) -> Future<GMSPlace, Error> {
        Future<GMSPlace, Error> { promise in
            self.fetchPlace(
                fromPlaceID: id,
                placeFields: fields,
                sessionToken: sessionToken
            ) { place, error in
                if let error = error {
                    promise(.failure(error))
                } else if let place = place {
                    promise(.success(place))
                }
            }
        }
    }

    /// Find place likelihoods using the user's current location.
    ///
    /// **Note**: This method requires that your app has permission to access the current device location.
    /// Before calling this make sure to request access to the users location using
    /// `CLLocationManager.requestWhenInUseAuthorization` or `CLLocationManager.requestAlwaysAuthorization`.
    /// If you do call this method and your app does not have the correct authorization status, the publisher
    /// will return an error.
    ///
    /// - Parameter fields: the individual place fields requested for the place objects in the list
    /// - Returns: a publisher returning a list of likely places the user is at
    public func findPlaceLikelihoodsFromCurrentPlace(
        fields: GMSPlaceField
    ) -> Future<[GMSPlaceLikelihood], Error> {
        Future<[GMSPlaceLikelihood], Error> { promise in
            self.findPlaceLikelihoodsFromCurrentLocation(
                withPlaceFields: fields
            ) { placeLikelihoods, error in
                if let error = error {
                    promise(.failure(error))
                } else if let placeLikelihoods = placeLikelihoods {
                    promise(.success(placeLikelihoods))
                }
            }
        }
    }
}
