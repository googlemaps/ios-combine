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
//  GMSMapViewPublisher.swift
//  GoogleMapsPlatformCombine
//
//  Created by Chris Arriola on 9/17/21.
//

import Combine
import GoogleMaps

/// A class that provides pubilshers for events emitted from a `GMSMapView`.
///
/// When using this class, any delegate set to the `GMSMapView` will be overriden
/// as this class will set itself as the single delegate to the `GMSMapView`. Delegate methods
/// are then exposed as publishers in this class.
public class GMSMapViewPublisher: NSObject {

    private let gmsMapView: GMSMapView

    // MARK: - Publisher Properties

    private let willMoveSubject = PassthroughSubject<Bool, Never>()

    /// A publisher that emits whenever the camera is about to change. The boolean emitted
    /// indicates if the camera change is due to a gesture or not.
    public var willMove: AnyPublisher<Bool, Never> {
        willMoveSubject.eraseToAnyPublisher()
    }

    private let didChangeCameraPositionSubject = PassthroughSubject<GMSCameraPosition, Never>()

    /// A publisher that emits camera positions as the camera is moving during animations or gestures on the map.
    public var didChangeCameraPosition: AnyPublisher<GMSCameraPosition, Never> {
        didChangeCameraPositionSubject.eraseToAnyPublisher()
    }

    private let idleAtCameraPositionSubject = PassthroughSubject<GMSCameraPosition, Never>()

    /// A publisher that emits when the map becomes idle at a given camera position.
    public var idleAtCameraPosition: AnyPublisher<GMSCameraPosition, Never> {
        idleAtCameraPositionSubject.eraseToAnyPublisher()
    }

    private let didTapAtCoordinateSubject = PassthroughSubject<CLLocationCoordinate2D, Never>()

    /// A publisher that emits tapped coordinates.
    public var didTapAtCoordinate: AnyPublisher<CLLocationCoordinate2D, Never> {
        didTapAtCoordinateSubject.eraseToAnyPublisher()
    }

    private let didLongPressAtCoordinateSubject = PassthroughSubject<CLLocationCoordinate2D, Never>()

    /// A publisher that emits long pressed coordinates.
    public var didLongPressAtCoordinate: AnyPublisher<CLLocationCoordinate2D, Never> {
        didLongPressAtCoordinateSubject.eraseToAnyPublisher()
    }

    private let didTapInfoWindowSubject = PassthroughSubject<GMSMarker, Never>()

    /// A publisher that emits when a marker's info window has been tapped.
    public var didTapInfoWindow: AnyPublisher<GMSMarker, Never> {
        didTapInfoWindowSubject.eraseToAnyPublisher()
    }

    private let didLongPressInfoWindowSubject = PassthroughSubject<GMSMarker, Never>()

    /// A publisher that emits when a marker's info window has been long pressed.
    public var didLongPressInfoWindow: AnyPublisher<GMSMarker, Never> {
        didLongPressInfoWindowSubject.eraseToAnyPublisher()
    }

    private let didTapOverlaySubject = PassthroughSubject<GMSOverlay, Never>()

    /// A publisher that emits when an overlay has been tapped.
    public var didTapOverlay: AnyPublisher<GMSOverlay, Never> {
        didTapOverlaySubject.eraseToAnyPublisher()
    }

    private let didTapPOISubject = PassthroughSubject<(String, String, CLLocationCoordinate2D), Never>()

    /// A publisher that emits when a POI has been tapped.
    public var didTapPOI: AnyPublisher<(String, String, CLLocationCoordinate2D), Never> {
        didTapPOISubject.eraseToAnyPublisher()
    }

    private let didCloseInfoWindowSubject = PassthroughSubject<GMSMarker, Never>()

    /// A publisher that emits when a marker's info window is closed.
    public var didCloseInfoWindowOf: AnyPublisher<GMSMarker, Never> {
        didCloseInfoWindowSubject.eraseToAnyPublisher()
    }

    private let didBeginDraggingSubject = PassthroughSubject<GMSMarker, Never>()

    /// A publisher that emits when dragging has been initiated on a marker.
    public var didBeginDragging: AnyPublisher<GMSMarker, Never> {
        didBeginDraggingSubject.eraseToAnyPublisher()
    }

    private let didEndDraggingSubject = PassthroughSubject<GMSMarker, Never>()

    /// A publisher that emits when dragging on a marker has ended.
    public var didEndDragging: AnyPublisher<GMSMarker, Never> {
        didEndDraggingSubject.eraseToAnyPublisher()
    }

    private let didDragSubject = PassthroughSubject<GMSMarker, Never>()

    /// A publisher that emits when a marker is dragged.
    public var didDrag: AnyPublisher<GMSMarker, Never> {
        didDragSubject.eraseToAnyPublisher()
    }

    private let didTapMyLocationSubject = PassthroughSubject<CLLocationCoordinate2D, Never>()

    /// A publisher that emits wen the My Location button is tapped.
    public var didTapMyLocation: AnyPublisher<CLLocationCoordinate2D, Never> {
        didTapMyLocationSubject.eraseToAnyPublisher()
    }

    private let didStartTileRenderingSubject = PassthroughSubject<Void, Never>()

    /// A publisher that emits when tiles have just been requested or labels have just started rendering.
    public var didStartTileRendering: AnyPublisher<Void, Never> {
        didStartTileRenderingSubject.eraseToAnyPublisher()
    }

    private let didFinishTileRenderingSubject = PassthroughSubject<Void, Never>()

    /// A pubilsher that emits when all tiles have been loaded (or failed permanently) and labels have been rendered.
    public var didFinishTileRendering: AnyPublisher<Void, Never> {
        didFinishTileRenderingSubject.eraseToAnyPublisher()
    }

    private let snapshotReadySubject = PassthroughSubject<Void, Never>()

    /// A publisher that emits when the map is stable (tiles loaded, labels rendered, camera is idle) and overlay objects have been rendered.
    public var snapshotReady: AnyPublisher<Void, Never> {
        snapshotReadySubject.eraseToAnyPublisher()
    }

    // MARK: - Publisher Methods

    private let didTapMarkerSubject = PassthroughSubject<GMSMarker, Never>()
    private var didTapMarkerConsumer: ((GMSMarker) -> Bool)?

    /// Publishes events when a marker is tapped.
    ///
    /// - Parameter consumer: an optional consumer which will be called before the publisher emits. If the consumer
    /// returns true, then the map will not perform the default selection behavior after tapping a marker (i.e. the info window is shown and
    /// camera moves and centers on the marker), otherwise, the map will perform the default selection behavior. Providing `nil`
    /// here indicates that the map should always perform the default selection behavior.
    /// - Returns: a publisher that emits when a marker is tapped
    public func didTapMarker(consumer: ((GMSMarker) -> Bool)? = nil) -> AnyPublisher<GMSMarker, Never> {
        didTapMarkerConsumer = consumer
        return didTapMarkerSubject.eraseToAnyPublisher()
    }

    private let markerInfoWindowSubject = PassthroughSubject<GMSMarker, Never>()
    private var markerInfoWindowConsumer: ((GMSMarker) -> UIView?)?

    /// Publishes events when a marker is about to become selected and its info window is about to be drawn. The `consumer`
    /// is used to provide an optional custom info window to use for the marker.
    ///
    /// - Parameter consumer: an optional consumer which will be called before the marker is selected. If the consumer
    /// returns a UIView, that UIView will be used as the marker's info window. Otherwise, the default info window will be used.
    /// - Returns: a publisher that emits when a marker is about to be selected and its info window is about to be drawn
    public func markerInfoWindow(consumer: ((GMSMarker) -> UIView?)? = nil) -> AnyPublisher<GMSMarker, Never> {
        markerInfoWindowConsumer = consumer
        return markerInfoWindowSubject.eraseToAnyPublisher()
    }

    private let markerInfoContentsSubject = PassthroughSubject<GMSMarker, Never>()
    private var markerInfoContentsConsumer: ((GMSMarker) -> UIView?)?

    /// Publishes events when a marker is about to become selected and its info window contents is about to be drawn. The
    /// `consumer` is used to provide an optional custom info window contents view to use for the info window.
    ///
    /// - Parameter consumer: an optional consumer which will be called before the marker is selected. If the consumer
    /// returns a UIView, that UIView will be used as the marker's info window content view. Otherwise, the default info window
    /// contents view will be used.
    /// - Returns: a publisher that emits when a marker is about to be selected and its info contents view about to be drawn
    public func markerInfoContents(consumer: ((GMSMarker) -> UIView?)? = nil) -> AnyPublisher<GMSMarker, Never> {
        markerInfoContentsConsumer = consumer
        return markerInfoContentsSubject.eraseToAnyPublisher()
    }

    private let didTapMyLocationButtonSubject = PassthroughSubject<Void, Never>()
    private var didTapMyLocationButtonConsumer: (() -> Bool)?

    /// Publishes events when the my location button is tapped. The `consumer` is used to provide customization
    /// to the behavior when the my location button is tapped.
    /// - Parameter consumer: an optional consumer which will be called before the publisher emits. If the consumer
    /// returns true, then the default behavior of centering the map on the my location button will not occur, otherwise, the
    /// default behavior will occur.
    /// - Returns: a publisher that emits when the my location button is tapped
    public func didTapMyLocationButton(consumer: (() -> Bool)? = nil) -> AnyPublisher<Void, Never> {
        didTapMyLocationButtonConsumer = consumer
        return didTapMyLocationButtonSubject.eraseToAnyPublisher()
    }

    // MARK: - Initializer and Deinitializer

    /// Initializes a new instance of `GMSMapViewPublisher`. Upon creation, the publisher will set itself as the delegate
    /// of `mapView`
    /// - Parameter mapView: the map view to publish events from
    public init(mapView: GMSMapView) {
        self.gmsMapView = mapView
        super.init()
        gmsMapView.delegate = self
    }

    deinit {
        gmsMapView.delegate = nil
    }
}

// MARK: - GMSMapViewDelegate

extension GMSMapViewPublisher : GMSMapViewDelegate {
    public func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        willMoveSubject.send(gesture)
    }

    public func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        didChangeCameraPositionSubject.send(position)
    }

    public func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        idleAtCameraPositionSubject.send(position)
    }

    public func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        didTapAtCoordinateSubject.send(coordinate)
    }

    public func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        didLongPressAtCoordinateSubject.send(coordinate)
    }

    public func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let shouldConsume = didTapMarkerConsumer?(marker) ?? false
        didTapMarkerSubject.send(marker)
        return shouldConsume
    }

    public func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        didTapInfoWindowSubject.send(marker)
    }

    public func mapView(_ mapView: GMSMapView, didLongPressInfoWindowOf marker: GMSMarker) {
        didLongPressInfoWindowSubject.send(marker)
    }

    public func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
        didTapOverlaySubject.send(overlay)
    }

    public func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String, name: String, location: CLLocationCoordinate2D) {
        didTapPOISubject.send((placeID, name, location))
    }

    public func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let infoWindow = markerInfoWindowConsumer?(marker) ?? nil
        markerInfoWindowSubject.send(marker)
        return infoWindow
    }

    public func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        let infoContents = markerInfoContentsConsumer?(marker) ?? nil
        markerInfoContentsSubject.send(marker)
        return infoContents
    }

    public func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
        didCloseInfoWindowSubject.send(marker)
    }

    public func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        didBeginDraggingSubject.send(marker)
    }

    public func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        didEndDraggingSubject.send(marker)
    }

    public func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        didDragSubject.send(marker)
    }

    public func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        let shouldConsume = didTapMyLocationButtonConsumer?() ?? true
        didTapMyLocationButtonSubject.send()
        return shouldConsume
    }

    public func mapView(_ mapView: GMSMapView, didTapMyLocation location: CLLocationCoordinate2D) {
        didTapMyLocationSubject.send(location)
    }

    public func mapViewDidStartTileRendering(_ mapView: GMSMapView) {
        didStartTileRenderingSubject.send()
    }

    public func mapViewDidFinishTileRendering(_ mapView: GMSMapView) {
        didFinishTileRenderingSubject.send()
    }

    public func mapViewSnapshotReady(_ mapView: GMSMapView) {
        snapshotReadySubject.send()
    }
}
