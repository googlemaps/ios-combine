//
//  ViewController.swift
//  GoogleMapsPlatformCombine
//
//  Created by Chris Arriola on 09/16/2021.
//  Copyright (c) 2021 Chris Arriola. All rights reserved.
//

import Combine
import GoogleMapsPlatformCombine
import GoogleMaps
import UIKit

class ViewController: UIViewController {

    private var publisher: GMSMapViewPublisher!
    private var subscriptions: Set<AnyCancellable> = []

    private let sydneyLatitude = -33.86
    private let sydneyLongitude = 151.20

    override func viewDidLoad() {
        super.viewDidLoad()

      // Create a GMSCameraPosition that tells the map to display the
      // coordinate -33.86,151.20 at zoom level 6.
      let camera = GMSCameraPosition.camera(withLatitude: sydneyLatitude, longitude: sydneyLongitude, zoom: 6.0)
      let mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
      view.addSubview(mapView)

      // Creates a marker in the center of the map.
      let marker = GMSMarker()
      marker.position = CLLocationCoordinate2D(latitude: sydneyLatitude, longitude: sydneyLongitude)
      marker.title = "Sydney"
      marker.snippet = "Australia"
      marker.map = mapView

      publisher = GMSMapViewPublisher(mapView: mapView)
      publisher.didChangeCameraPosition.sink { cameraPosition in
        print("Camera position at \(cameraPosition.target)")
      }.store(in: &subscriptions)
    }
}

