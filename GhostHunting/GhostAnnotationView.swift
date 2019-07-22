//
//  GhostAnnotationView.swift
//  GhostHunting
//
//  Created by Eloisa Falcão on 20/07/19.
//  Copyright © 2019 Eloisa Falcão. All rights reserved.
//

import UIKit
import MapKit

class GhostAnnotationView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let ghost = newValue as? GhostAnnotation else {return}
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            image = UIImage(named: "pinGhost")
           
        }
    }
}


