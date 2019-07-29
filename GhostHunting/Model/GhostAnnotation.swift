//
//  GhostAnnotation.swift
//  GhostHunting
//
//  Created by Eloisa Falcão on 18/07/19.
//  Copyright © 2019 Eloisa Falcão. All rights reserved.
//

import UIKit
import MapKit

class GhostAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var ghost: GhostData
 
    init(coordinate: CLLocationCoordinate2D, ghost: GhostData) {
        self.coordinate = coordinate
        self.ghost = ghost
    }



    
    
}
