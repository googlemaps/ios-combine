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

import Foundation
import GoogleMaps
import OCMock
import XCTest

@testable import GoogleMapsPlatformCombine

class GmsMapViewPublisherTests : XCTestCase {

    private let expectationTimeout: TimeInterval = 1

    private var mapView: GMSMapView!
    private var publisher: GMSMapViewPublisher!

    /// Class to allow instantiation of a GMSOverlay type
    class MockOverlay: GMSOverlay {
    }

    override func setUp() {
        super.setUp()
        GMSServices.provideAPIKey("Test")
        mapView = GMSMapView()
        publisher = GMSMapViewPublisher(mapView: mapView)
    }

    func testPublisherEmitsWillMove() {
        let expect  = expectation(description: "Publisher emits on willMove")
        let cancellable = publisher.willMove.sink { _ in
            expect.fulfill()
        }
        mapView.delegate?.mapView?(mapView, willMove: true)
        wait(for: [expect], timeout: expectationTimeout)
        cancellable.cancel()
    }

    func testPublisherEmitsDidChangeCameraPosition() {
        let expect  = expectation(description: "Publisher emits on didChangeCameraPosition")
        let position = GMSCameraPosition(latitude: 0, longitude: 0, zoom: 0)
        let cancellable = publisher.didChangeCameraPosition.sink { newPosition in
            XCTAssertEqual(position, newPosition)
            expect.fulfill()
        }
        mapView.delegate?.mapView?(mapView, didChange: position)
        wait(for: [expect], timeout: expectationTimeout)
        cancellable.cancel()
    }

    func testPublisherEmitsidleAtCameraPosition() {
        let expect  = expectation(description: "Publisher emits on idleAtCameraPosition")
        let position = GMSCameraPosition(latitude: 0, longitude: 0, zoom: 0)
        let cancellable = publisher.idleAtCameraPosition.sink { newPosition in
            XCTAssertEqual(position, newPosition)
            expect.fulfill()
        }
        mapView.delegate?.mapView?(mapView, idleAt: position)
        wait(for: [expect], timeout: expectationTimeout)
        cancellable.cancel()
    }

    func testPublisherEmitsDidTapAtCoordinate() {
        let expect  = expectation(description: "Publisher emits on didTapAtCoordinate")
        let coordinate = CLLocationCoordinate2DMake(0, 0)
        let cancellable = publisher.didTapAtCoordinate.sink { tappedCoordinate in
            XCTAssertEqual(coordinate.latitude, tappedCoordinate.latitude)
            XCTAssertEqual(coordinate.longitude, tappedCoordinate.longitude)
            expect.fulfill()
        }
        mapView.delegate?.mapView?(mapView, didTapAt: coordinate)
        wait(for: [expect], timeout: expectationTimeout)
        cancellable.cancel()
    }

    func testPublisherEmitsDidLongPressAtCoordinate() {
        let expect  = expectation(description: "Publisher emits on didLongPressAtCoordinate")
        let coordinate = CLLocationCoordinate2DMake(0, 0)
        let cancellable = publisher.didLongPressAtCoordinate.sink { tappedCoordinate in
            XCTAssertEqual(coordinate.latitude, tappedCoordinate.latitude)
            XCTAssertEqual(coordinate.longitude, tappedCoordinate.longitude)
            expect.fulfill()
        }
        mapView.delegate?.mapView?(mapView, didLongPressAt: coordinate)
        wait(for: [expect], timeout: expectationTimeout)
        cancellable.cancel()
    }

    func testPublisherEmitsDidTapMarker() {
        let expect  = expectation(description: "Publisher emits on didTapMarker")
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: 0, longitude: 0))
        let cancellable = publisher.didTapMarker().sink { tappedMarker in
            XCTAssertEqual(marker, tappedMarker)
            expect.fulfill()
        }
        _ = mapView.delegate?.mapView?(mapView, didTap: marker)
        wait(for: [expect], timeout: expectationTimeout)
        cancellable.cancel()
    }

    func testPublisherEmitsDidTapInfoWindow() {
        let expect  = expectation(description: "Publisher emits on didTapInfoWindow")
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: 0, longitude: 0))
        let cancellable = publisher.didTapInfoWindow.sink { tappedMarker in
            XCTAssertEqual(marker, tappedMarker)
            expect.fulfill()
        }
        mapView.delegate?.mapView?(mapView, didTapInfoWindowOf: marker)
        wait(for: [expect], timeout: expectationTimeout)
        cancellable.cancel()
    }

    func testPublisherEmitsDidLongPressInfoWindowOf() {
        let expect  = expectation(description: "Publisher emits on didLongPressInfoWindowOf")
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: 0, longitude: 0))
        let cancellable = publisher.didLongPressInfoWindow.sink { tappedMarker in
            XCTAssertEqual(marker, tappedMarker)
            expect.fulfill()
        }
        mapView.delegate?.mapView?(mapView, didLongPressInfoWindowOf: marker)
        wait(for: [expect], timeout: expectationTimeout)
        cancellable.cancel()
    }

    func testPublisherEmitsDidTapOverlay() {
        let expect  = expectation(description: "Publisher emits on didTapOverlay")
        let overlay = MockOverlay()
        let cancellable = publisher.didTapOverlay.sink { tappedOverlay in
            XCTAssertEqual(overlay, tappedOverlay)
            expect.fulfill()
        }
        mapView.delegate?.mapView?(mapView, didTap: overlay)
        wait(for: [expect], timeout: expectationTimeout)
        cancellable.cancel()
    }

    func testPublisherEmitsDidTapPOI() {
        let expect  = expectation(description: "Publisher emits on didTapPOI")
        let placeId = "placeId"
        let name = "place name"
        let location = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        let cancellable = publisher.didTapPOI.sink { (rplaceId, rname, rlocation) in
            XCTAssertEqual(placeId, rplaceId)
            XCTAssertEqual(name, rname)
            XCTAssertEqual(location.latitude, rlocation.latitude)
            XCTAssertEqual(location.longitude, rlocation.longitude)
            expect.fulfill()
        }
        mapView.delegate?.mapView?(mapView, didTapPOIWithPlaceID: placeId, name: name, location: location)
        wait(for: [expect], timeout: expectationTimeout)
        cancellable.cancel()
    }

    func testPublisherEmitsMarkerInfoWindow() {
        let expect  = expectation(description: "Publisher emits on markerInfoWindow")
        let marker = GMSMarker()
        let cancellable = publisher.markerInfoWindow().sink { m in
            XCTAssertEqual(marker, m)
            expect.fulfill()
        }
        _ = mapView.delegate?.mapView?(mapView, markerInfoWindow: marker)
        wait(for: [expect], timeout: expectationTimeout)
        cancellable.cancel()
    }

    func testPublisherEmitsMarkerInfoContents() {
        let expect  = expectation(description: "Publisher emits on markerInfoContents")
        let marker = GMSMarker()
        let cancellable = publisher.markerInfoContents().sink { m in
            XCTAssertEqual(marker, m)
            expect.fulfill()
        }
        _ = mapView.delegate?.mapView?(mapView, markerInfoContents: marker)
        wait(for: [expect], timeout: expectationTimeout)
        cancellable.cancel()
    }

    func testPublisherEmitsDidCloseInfoWindowOf() {
        let expect  = expectation(description: "Publisher emits on didCloseInfoWindowOf")
        let marker = GMSMarker()
        let cancellable = publisher.didCloseInfoWindowOf.sink { m in
            XCTAssertEqual(marker, m)
            expect.fulfill()
        }
        _ = mapView.delegate?.mapView?(mapView, didCloseInfoWindowOf: marker)
        wait(for: [expect], timeout: expectationTimeout)
        cancellable.cancel()
    }

    func testPublisherEmitsDidBeginDragging() {
        let expect  = expectation(description: "Publisher emits on didBeginDragging")
        let marker = GMSMarker()
        let cancellable = publisher.didBeginDragging.sink { m in
            XCTAssertEqual(marker, m)
            expect.fulfill()
        }
        mapView.delegate?.mapView?(mapView, didBeginDragging: marker)
        wait(for: [expect], timeout: expectationTimeout)
        cancellable.cancel()
    }

    func testPublisherEmitsDidEndDragging() {
        let expect  = expectation(description: "Publisher emits on didEndDragging")
        let marker = GMSMarker()
        let cancellable = publisher.didEndDragging.sink { m in
            XCTAssertEqual(marker, m)
            expect.fulfill()
        }
        mapView.delegate?.mapView?(mapView, didEndDragging: marker)
        wait(for: [expect], timeout: expectationTimeout)
        cancellable.cancel()
    }

    func testPublisherEmitsDidDrag() {
        let expect  = expectation(description: "Publisher emits on didDrag")
        let marker = GMSMarker()
        let cancellable = publisher.didDrag.sink { m in
            XCTAssertEqual(marker, m)
            expect.fulfill()
        }
        mapView.delegate?.mapView?(mapView, didDrag: marker)
        wait(for: [expect], timeout: expectationTimeout)
        cancellable.cancel()
    }

    func testPublisherEmitsDidTapMyLocationButton() {
        let expect  = expectation(description: "Publisher emits on didTapMyLocationButton")
        let cancellable = publisher.didTapMyLocationButton().sink { _ in
            expect.fulfill()
        }
        _ = mapView.delegate?.didTapMyLocationButton?(for: mapView)
        wait(for: [expect], timeout: expectationTimeout)
        cancellable.cancel()
    }

    func testPublisherEmitsDidTapMyLocation() {
        let expect  = expectation(description: "Publisher emits on didTapMyLocation")
        let coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        let cancellable = publisher.didTapMyLocation.sink { coord in
            XCTAssertEqual(coordinate.latitude, coord.latitude)
            XCTAssertEqual(coordinate.longitude, coord.longitude)
            expect.fulfill()
        }
        _ = mapView.delegate?.mapView?(mapView, didTapMyLocation: coordinate)
        wait(for: [expect], timeout: expectationTimeout)
        cancellable.cancel()
    }

    func testPublisherEmitsDidStartTileRendering() {
        let expect  = expectation(description: "Publisher emits on didStartTileRendering")
        let cancellable = publisher.didStartTileRendering.sink {
            expect.fulfill()
        }
        _ = mapView.delegate?.mapViewDidStartTileRendering?(mapView)
        wait(for: [expect], timeout: expectationTimeout)
        cancellable.cancel()
    }

    func testPublisherEmitsDidFinishTileRendering() {
        let expect  = expectation(description: "Publisher emits on didFinishTileRendering")
        let cancellable = publisher.didFinishTileRendering.sink {
            expect.fulfill()
        }
        _ = mapView.delegate?.mapViewDidFinishTileRendering?(mapView)
        wait(for: [expect], timeout: expectationTimeout)
        cancellable.cancel()
    }

    func testPublisherEmitsSnapshotReady() {
        let expect  = expectation(description: "Publisher emits on snapshotReady")
        let cancellable = publisher.snapshotReady.sink {
            expect.fulfill()
        }
        _ = mapView.delegate?.mapViewSnapshotReady?(mapView)
        wait(for: [expect], timeout: expectationTimeout)
        cancellable.cancel()
    }
}
