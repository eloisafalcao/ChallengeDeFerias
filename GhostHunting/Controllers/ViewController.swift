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
import UserNotifications

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var buttonCenter: UIButton!
    @IBOutlet weak var journalButton: UIButton!
    @IBOutlet weak var tooFarAlert: UIImageView!
    @IBOutlet weak var viewRoxa: UIView!
    @IBOutlet weak var tooFarView: UIImageView!
    @IBOutlet weak var tasksButton: UIButton!
    
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
        
        
        //Autolayout
        mapView.frame.size = view.frame.size
        mapView.frame.origin = view.frame.origin
        mapView.center = view.center
        
        viewRoxa.frame.size.height = view.frame.height/5
        viewRoxa.frame.size.width = view.frame.width
        viewRoxa.center.x = view.center.x
        viewRoxa.center.y = view.frame.height - viewRoxa.frame.height/2

        tooFarView.frame.size.height = view.frame.height/9
        tooFarView.frame.size.width = view.frame.width/2
        tooFarView.center.x = view.center.x
        tooFarView.center.y = viewRoxa.frame.height
        
        journalButton.frame.size.height = view.frame.height/7
        journalButton.frame.size.width =  journalButton.frame.height
        journalButton.center.x = view.center.x
        journalButton.center.y = viewRoxa.center.y
        
        buttonCenter.frame.size.height = journalButton.frame.height
        buttonCenter.frame.size.width = journalButton.frame.height
        buttonCenter.center.x = view.center.x + (journalButton.frame.width*1.1)
        buttonCenter.center.y = viewRoxa.center.y
        
        tasksButton.frame.size.height = journalButton.frame.height
        tasksButton.frame.size.width = journalButton.frame.height
        tasksButton.center.x = view.center.x - (journalButton.frame.width*1.1)
        tasksButton.center.y = viewRoxa.center.y
    }
    
    
    func checkAuthorizationStatus(){
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            print("notDetermined")
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            print("denied")
            let alertController = UIAlertController(title: "Hello Hunter 👻", message: "You need to allow your location in settings to start searching for ghosts!", preferredStyle: .alert)
            let actionOk = UIAlertAction(title: "Cancel",
                                         style: .default,
                                         handler: nil)
            
            let actionSettings = UIAlertAction(title: "Settings", style: .default){ (_) -> Void in
                
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)") // Prints true
                    })
                }
                
            }
            
            alertController.addAction(actionOk)
            alertController.addAction(actionSettings)

            self.present(alertController, animated: true, completion: nil)
            
        case .authorizedWhenInUse, .authorizedAlways:
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
            centerUserLocation()
        @unknown default:
            print("unknown")
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
         checkAuthorizationStatus()
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
        journalButton.setImage(UIImage(named: "pressedJournalButton"), for: .highlighted)
        buttonCenter.setImage( UIImage(named: "pressedCenterButton"), for: .highlighted)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        mapView.deselectAnnotation(view.annotation!, animated: false)
        
        if view.annotation! is MKUserLocation {
            return
        }
        
        let region = MKCoordinateRegion(center: view.annotation!.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
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
