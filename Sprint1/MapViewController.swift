//
//  MapViewController.swift
//  Sprint1
//
//  Created by Capgemini-DA087 on 9/4/22.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
    var locationmanager : CLLocationManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        determineUserLocation()
    }
    func determineUserLocation(){
        locationmanager = CLLocationManager()
        locationmanager.delegate = self
        locationmanager.desiredAccuracy = kCLLocationAccuracyBest
        locationmanager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationmanager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let mUserLoc: CLLocation = locations[0] as CLLocation
        
                
        let center = CLLocationCoordinate2D(latitude: mUserLoc.coordinate.latitude, longitude: mUserLoc.coordinate.longitude)
        
        let mRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        let mkAnnotation: MKPointAnnotation = MKPointAnnotation()
        mkAnnotation.coordinate = CLLocationCoordinate2DMake(mUserLoc.coordinate.latitude, mUserLoc.coordinate.longitude)

        
        getAddress{(address) in
            mkAnnotation.title = address
        }
        
        mapView.setRegion(mRegion, animated: true)
        mapView.addAnnotation(mkAnnotation)
    
    
    func getAddress(handler: @escaping (String) -> Void) {
        
        
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: mUserLoc.coordinate.latitude, longitude: mUserLoc.coordinate.longitude)
        geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            var placemark: CLPlacemark?
            
            //place details
            placemark = placemarks?[0]
                    
            // address directory
            let address = "\(placemark?.subThoroughfare ?? ""), \(placemark?.thoroughfare ?? ""), \(placemark?.locality ?? ""), \(placemark?.subLocality ?? ""), \(placemark?.administrativeArea ?? ""), \(placemark?.postalCode ?? ""), \(placemark?.country ?? "")"
                    
            print("\(address)")
                
            handler(address)
        })
        
            
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
