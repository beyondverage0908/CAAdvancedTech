//
//  TCLLocationController.swift
//  CAAdvancedTech
//
//  Created by pingjun lin on 2017/6/7.
//  Copyright © 2017年 pingjun lin. All rights reserved.
//

import UIKit
import CoreLocation

class TCLLocationController: UIViewController {
    
    @IBOutlet weak var latitudeAndLongitudeTextField: UITextField!
    @IBOutlet weak var locationNameTextField: UITextField!
    @IBOutlet weak var locationErrorTextField: UITextField!
    
    fileprivate let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.distanceFilter = 10
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func getLocationAction(_ sender: UIButton) {
        
        if CLLocationManager.locationServicesEnabled() {
            if #available(iOS 9.0, *) {
                locationManager.requestLocation()
            }
            locationManager.startUpdatingLocation()
        } else {
            print("不能进行定位")
        }
    }
}

extension TCLLocationController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let currentLocation = locations.last {
            latitudeAndLongitudeTextField.text = "\(currentLocation.coordinate.latitude)" + " : " + "\(currentLocation.coordinate.longitude)"
            locationManager.stopUpdatingLocation()
            
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(currentLocation, completionHandler: { (placemarks: [CLPlacemark]?, error: Error?) in
                if let placemarkList = placemarks, placemarkList.count > 0 {
                    let placemark = placemarkList[0]
                    let locality = placemark.locality
                    
                    if locality == nil {
                        self.locationNameTextField.text = "暂时无法定位"
                    } else {
                        self.locationNameTextField.text = locality
                    }
                }
            });
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationErrorTextField.text = error.localizedDescription
    }
}
