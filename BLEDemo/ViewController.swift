//
//  ViewController.swift
//  BLEDemo
//
//  Created by David Porter on 8/22/18.
//  Copyright © 2018 David Porter. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications

class ViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()

        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options:[.alert, .sound]) { (granted, error) in }

        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
    }

    // checking here to see if the user gave us permission or not then we scan
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }

    // setting up the beacon entering the region
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        guard region is CLBeaconRegion else { return }

        // this is the notification
        let content = UNMutableNotificationContent()
        content.title = "David Porter"
        content.body = "Can you please help?"
        content.sound = .default()

        let request = UNNotificationRequest(identifier: "BLEDemo", content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

    // here we are scanning for the beacons uuid
    func startScanning() {
        let uuid = UUID(uuidString: "9118606C-C0C4-4AF3-9E7E-B839FDA1AB19")!
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 143, minor: 456, identifier: "Samaritan")

        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
    }
}


