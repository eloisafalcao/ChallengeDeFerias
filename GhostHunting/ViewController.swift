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

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var buttonCenter: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var journalButton: UIButton!
    @IBOutlet weak var tooFarAlert: UIImageView!
    
    var ghostArray: [GhostData] = []
    var selectedGhost: GhostData?
    
    @IBAction func buttonCenterAction(_ sender: Any) {
        centerUserLocation()
        tooFarAlert.isHidden = true
    }
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.mapView.delegate = self 
        ghostArray = bringAllTheGhosts()
        checkAuthorizationStatus()
        addAnnotations()
        centerUserLocation()
        pressedButtons()
        tooFarAlert.isHidden = true
     
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
            centerUserLocation()
        @unknown default:
            print("unknown")
        }
        
    }
    
    
    func centerUserLocation(){
            guard let coordinate = locationManager.location?.coordinate else {return}
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
            self.mapView.setRegion(region, animated: true)
      
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc =  segue.destination as? BattleViewController {
            vc.ghost = selectedGhost
        }
    }
    
    func pressedButtons(){
        settingsButton.setImage(UIImage(named: "pressedSettingButton"), for: .highlighted)
        journalButton.setImage(UIImage(named: "pressedJournalButton"), for: .highlighted)
        buttonCenter.setImage( UIImage(named: "pressedCenterButton"), for: .highlighted)
        
    }
    
 

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        mapView.deselectAnnotation(view.annotation!, animated: false)
        
        if view.annotation! is MKUserLocation {
            return
        }
        
        let region = MKCoordinateRegion(center: view.annotation!.coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
        self.mapView.setRegion(region, animated: false)
   
       if let coordinate = locationManager.location?.coordinate {
        if mapView.visibleMapRect.contains(MKMapPoint(coordinate)){
              print("touch ghost")
            let ghost = (view.annotation as! GhostAnnotation).ghost
            self.selectedGhost = ghost
            self.performSegue(withIdentifier: "showBattle", sender: self)
            print("present battleView")
            
            
        } else {
            tooFarAlert.isHidden = false
            print("2 far")
        }
        
        }
        
      
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)

        if annotation is MKUserLocation {
            annotationView.image = UIImage(named: "userLocation")
        } else {
            annotationView.image = UIImage(named: "pinGhost")
        }
        
        var newFrame = annotationView.frame
        newFrame.size.height = 40
        newFrame.size.width = 40
        annotationView.frame = newFrame
        
        return annotationView
    }
    
    
    func addAnnotations(){
            Timer.scheduledTimer(withTimeInterval: Double(arc4random_uniform(10)), repeats: true) { (timer) in
                let randomGhost = Int(arc4random_uniform(UInt32(self.ghostArray.count)))
                let ghost = self.ghostArray[randomGhost]
                
                guard let coordinate = self.locationManager.location?.coordinate else {return}
                let annotation = GhostAnnotation(coordinate: coordinate, ghost: ghost)
                annotation.coordinate.latitude += (Double(arc4random_uniform(1000)) - 500)/300000.0
                annotation.coordinate.longitude += (Double(arc4random_uniform(1000)) - 500)/300000.0
                
//                print("add annotation")
                self.mapView.addAnnotation(annotation)
        
        }
    }
    

}
