//
//  MemberLocation.swift
//  Bump
//
//  Created by Boshi Li on 16/05/2017.
//  Copyright © 2017 Boshi Li. All rights reserved.
//

import MapKit
import Foundation
import CoreLocation

final class LocationHelper:NSObject, CLLocationManagerDelegate{
    
    static let shared = LocationHelper()
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.activityType = .fitness
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
    }
        
    func requestAuthorization(complection: (UIViewController) -> Swift.Void) {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            break
        // ...
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
        case  .restricted, .denied:
            let alertController = UIAlertController(
                title: "取用 GPS 被拒絕",
                message: "請將 GPS 取用權限調整到 \"使用 App 期間\", 以提供更好的使用者體驗。",
                preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            let openAction = UIAlertAction(title: "開啟設定", style: .default) { (action) in
                if let url = URL(string:UIApplicationOpenSettingsURLString) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }
            alertController.addAction(openAction)
            complection(alertController)
            
        }
    }
        
    var usersCurrentLocation : CLLocationCoordinate2D? {
        get {
            if let coordinate = locationManager.location?.coordinate {
                return coordinate
            } else {
                return nil
            }
        }
    }
}


extension LocationHelper {
    
    func countDistance(pointA: CLLocationCoordinate2D, pointB: CLLocationCoordinate2D) -> CLLocationDistance {
        let a = MKMapPointForCoordinate(pointA)
        let b = MKMapPointForCoordinate(pointB)
        return MKMetersBetweenMapPoints(a, b)
    }

    
    func convert(latitudeString: String?, longitudeString: String?) -> CLLocationCoordinate2D? {
        
        guard let latitudeStr = latitudeString,
            let longtitdeStr = longitudeString else { return nil }
        
        guard let latitude = CLLocationDegrees(latitudeStr),
            let longtitde = CLLocationDegrees(longtitdeStr) else { return nil }

        return CLLocationCoordinate2D(latitude: latitude, longitude: longtitde)

    }
    
}
