//
//  ViewController.swift
//  GhostHunting
//
//  Created by Eloisa Falcão on 17/07/19.
//  Copyright © 2019 Eloisa Falcão. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var buttonCenter: UIButton!
    
    var ghostArray: [GhostData] = []
    
    @IBAction func buttonCenterAction(_ sender: Any) {
        centerUserLocation()
    }
    
    func mapView(_mapView:MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        if annotation is MKUserLocation {
//            annotationView.image = aga
        } else {
            let ghost = (annotation as! GhostAnnotation).ghost
            annotationView.image = UIImage(named: ghost.imageFileName!)
        }
        
        var newFrame = annotationView.frame
        newFrame.size.height = 40
        newFrame.size.width = 40
        annotationView.frame = newFrame
        
        return annotationView
    }
    

    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        ghostArray = bringAllTheGhosts()
        
        checkAuthorizationStatus()
        addAnnotations()
        centerUserLocation()
    }
    
    func checkAuthorizationStatus() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("restricted")  // Show an alert letting them know what's up
        case .denied:
            print("denied") // Show alert instructing them how to turn on permissions
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
            addAnnotations()
        @unknown default:
            print("unknown")
        }
        
    }
    
    
    func centerUserLocation(){
            guard let coordinate = locationManager.location?.coordinate else {return}
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 400, longitudinalMeters: 400)
            mapView.setRegion(region, animated: true)
      
    }
    
    func addAnnotations(){
        Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { (timer) in
            
            let randomGhost = Int(arc4random_uniform(UInt32(self.ghostArray.count)))
            let ghost = self.ghostArray[randomGhost]
            
            guard let coordinate = self.locationManager.location?.coordinate else {return}
            let annotation = GhostAnnotation(coordinate: coordinate, ghost: ghost)
            annotation.coordinate = coordinate
            annotation.coordinate.latitude += (Double(arc4random_uniform(1000)) - 500)/300000.0
            annotation.coordinate.longitude += (Double(arc4random_uniform(1000)) - 500)/300000.0
            
            self.mapView.addAnnotation(annotation)
            
        }
        
    }

}


