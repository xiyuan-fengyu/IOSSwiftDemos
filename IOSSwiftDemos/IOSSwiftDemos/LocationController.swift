//
//  LocationController.swift
//  IOSSwiftDemos
//
//  Created by 邓伯操 on 16/6/18.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import UIKit
import CoreLocation

class LocationController: UIViewController, CLLocationManagerDelegate {

    //注意：除了controller里面的内容，还需要在info.plist中添加两个属性：NSLocationAlwaysUsageDescription，NSLocationWhenInUseUsageDescription
    
    private var locationManager: CLLocationManager!
    
    @IBOutlet weak var locationLb: UILabel!
    
    @IBAction func onGetLocationClick(sender: AnyObject) {
        if locationManager == nil {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
        }
        if locationManager != nil {
            locationManager.startUpdatingLocation()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        locationLb.text = "Error while updating location " + error.localizedDescription
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil) {
                self.locationLb.text = "Reverse geocoder failed with error" + error!.localizedDescription
                return
            }
            
            if placemarks!.count > 0 {
                let pm = placemarks![0]
                self.showLocation(pm)
            } else {
                self.locationLb.text = "Problem with the data received from geocoder"
            }
        })
    }
    
    func showLocation(placemark: CLPlacemark?) {
        if let containsPlacemark = placemark {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
            
            let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
            let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
            let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
            let country = (containsPlacemark.country != nil) ? containsPlacemark.country : ""
            
            self.locationLb.text = locality! +  postalCode! +  administrativeArea! +  country!
        }
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
