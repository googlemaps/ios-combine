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
//  GMSPlacesClientCombineTests.swift
//  GoogleMapsPlatformCombine-Unit-Tests
//
//  Created by Chris Arriola on 11/11/21.
//

import Combine
import Foundation
import GooglePlaces
import XCTest

class GMSPlacesClientCombineTests : XCTestCase {

    private let expectationTimeout: TimeInterval = 1
    var client: PlacesClientFake!

    override func setUp() {
        super.setUp()
        client = PlacesClientFake()
    }

    func testFindAutocompletePredictionsSuccess() {
        let response: ([GMSAutocompletePrediction], NSError?) = ([], nil)
        client.mockFindAutocompletePredictions = response

        let expect = expectation(description: #function)
        var cancellables: [AnyCancellable] = []
        client.findAutocompletePredictions(from: "query").sink { completion in
            switch completion {
            case .finished:
                expect.fulfill()
            case .failure(_):
                XCTFail("Error should not have occured.")
            }

        } receiveValue: { predictions in
            XCTAssertEqual(response.0, predictions)
        }
        .store(in: &cancellables)
        wait(for: [expect], timeout: expectationTimeout)
    }

    func testFindAutocompletePredictionFailure() {
        let response: ([GMSAutocompletePrediction]?, NSError) = (nil, NSError(domain: "", code: 1, userInfo: nil))
        client.mockFindAutocompletePredictions = response

        let expect = expectation(description: #function)
        var cancellables: [AnyCancellable] = []
        client.findAutocompletePredictions(from: "query").sink { completion in
            switch completion {
            case .finished:
                XCTFail("Error should have occured.")
            case let .failure(error as NSError):
                XCTAssertEqual(response.1.code, error.code)
                expect.fulfill()
            }

        } receiveValue: { predictions in
            XCTFail("Error should have occured.")
        }
        .store(in: &cancellables)
        wait(for: [expect], timeout: expectationTimeout)
    }

    func testfindPlaceLikelihoodsFromCurrentLocationSuccess() {
        let response: ([GMSPlaceLikelihood], NSError?) = ([], nil)
        client.mockFindPlaceLikelihoodsFromCurrentLocation = response

        let expect = expectation(description: #function)
        var cancellables: [AnyCancellable] = []
        client.findPlaceLikelihoodsFromCurrentLocation(fields: .name).sink { completion in
            switch completion {
            case .finished:
                expect.fulfill()
            case .failure(_):
                XCTFail("Error should not have occured.")
            }

        } receiveValue: { predictions in
            XCTAssertEqual(response.0, predictions)
        }
        .store(in: &cancellables)
        wait(for: [expect], timeout: expectationTimeout)
    }

    func testfindPlaceLikelihoodsFromCurrentLocationFailure() {
        let response: ([GMSPlaceLikelihood]?, NSError) = (nil, NSError(domain: "", code: 1, userInfo: nil))
        client.mockFindPlaceLikelihoodsFromCurrentLocation = response

        let expect = expectation(description: #function)
        var cancellables: [AnyCancellable] = []
        client.findPlaceLikelihoodsFromCurrentLocation(fields: .name).sink { completion in
            switch completion {
            case .finished:
                XCTFail("Error should have occured.")
            case let .failure(error as NSError):
                XCTAssertEqual(response.1.code, error.code)
                expect.fulfill()
            }

        } receiveValue: { predictions in
            XCTFail("Error should have occured.")
        }
        .store(in: &cancellables)
        wait(for: [expect], timeout: expectationTimeout)
    }
}
