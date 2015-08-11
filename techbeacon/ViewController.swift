//
//  ViewController.swift
//  techbeacon
//
//  Created by Anatoly Konkin on 7/20/15.
//  Copyright (c) 2015 Anatoly Konkin. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var minor_label: UILabel!
    @IBOutlet weak var major_label: UILabel!
    @IBOutlet weak var proximity_label: UILabel!
    @IBOutlet weak var accuracy_label: UILabel!
    @IBOutlet weak var rssi_label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
        }
        let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"), identifier: "ru.techmas.techbeacon")
        locationManager.startRangingBeaconsInRegion(region)
        
        
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        println(beacons)
        
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
        
        if (knownBeacons.count > 0) {
            let closestBeacon = knownBeacons[0] as! CLBeacon

            major_label.text = String(stringInterpolationSegment: closestBeacon.major)
            minor_label.text = String(stringInterpolationSegment: closestBeacon.minor)
            
            let proximity = closestBeacon.proximity
            
            var proximityString = String()
            
            switch proximity
            {
            case .Immediate:
                proximityString = "Близко"
            case .Near:
                proximityString = "Недалеко"
            case .Far:
                proximityString = "Далеко"
            case .Unknown:
                proximityString = "Unknown"
            }

            proximity_label.text = proximityString
            rssi_label.text = String(closestBeacon.rssi)
            accuracy_label.text = String(stringInterpolationSegment: closestBeacon.accuracy)
        }
        
    }
    
//    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
//        let a = 1
//    }

}

