//
//  LocationManager.swift
//  LovelyDay
//
//  Created by Tielman Janse van Vuuren on 2020/12/13.
//

import Foundation
import CoreLocation

protocol MyLocationDelegate {
    func newLocationData(latitude: Double, longitude: Double)
}


class MyLocationManager: NSObject, CLLocationManagerDelegate {
    static let main = MyLocationManager()
    var locationManager: CLLocationManager?
    var delegate: MyLocationDelegate?


    override init() {
        super.init()
        self.locationManager = CLLocationManager()
        self.locationManager?.desiredAccuracy = 1000
        self.locationManager?.delegate = self

        self.locationManager?.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch(status) {
            case .notDetermined:
                print("Location Service authorization not determined")
                manager.requestWhenInUseAuthorization()
            case .restricted:
                print("Location Service authorization not available")
                // Maybe show dialog
            case .denied:
                print("Location Service authorization not available")
                // Maybe show dialog
            case .authorizedAlways:
                manager.startUpdatingLocation()
                print("Location Service is authorized")
            case .authorizedWhenInUse:
                manager.startUpdatingLocation()
                print("Location Service is authorized")
            default:
                return
        }

        print("Auth change")
    }
    /*func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {

    }*/

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // I have a location update
        manager.stopUpdatingLocation()
        if(locations.count > 0) {
            self.delegate?.newLocationData(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        }
        print("We have an update")
    }
}
