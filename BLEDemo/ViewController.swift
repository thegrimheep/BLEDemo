//
//  ViewController.swift
//  BLEDemo
//
//  Created by David Porter on 8/22/18.
//  Copyright © 2018 David Porter. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    // checking here to see if the use gave us permission or not then we scan
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways{
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }

    //here we are scanning for the beacons uuid
    func startScanning() {
        let uuid = UUID(uuidString: "fake UUID goes here")!
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 143, minor: 456, identifier: "Samaritan")

        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
    }
}

