//
//  JornalPageViewController.swift
//  GhostHunting
//
//  Created by Eloisa Falcão on 22/07/19.
//  Copyright © 2019 Eloisa Falcão. All rights reserved.
//

import UIKit

class JornalPageViewController: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var viewRoxa: UIView!
    @IBOutlet weak var ghostImage: UIImageView!
    @IBOutlet weak var ghostDescription: UILabel!
    @IBOutlet weak var ghostName: UILabel!
    @IBOutlet weak var skulls: UIImageView!
    @IBOutlet weak var ghostCount: UILabel!
    @IBOutlet weak var caughts: UILabel!
    
    var ghost: GhostData? 
    
    
    @IBAction func exitButton(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(ghost)

        ghostImage.image = UIImage(named: ghost?.imageFileName ?? "heart")
        ghostName.text = ghost?.name
        skulls.image = UIImage(named: ghost?.skullsClass ?? "heart")
        ghostDescription.text = ghost?.ghostDescription
        if let count = ghost?.countCaught {
            let showCount: String = String(count)
            ghostCount.text = showCount
           
            
         //Autolayout
            closeButton.frame.size.height = view.frame.height/20
            closeButton.frame.size.width = closeButton.frame.height
            closeButton.frame.origin.x = view.frame.origin.x + closeButton.frame.height/2
            closeButton.frame.origin.y = view.frame.origin.x + closeButton.frame.height
        
            viewRoxa.frame.size.height = view.frame.height/7
            viewRoxa.frame.size.width = view.frame.width
            viewRoxa.center.x = view.center.x
            viewRoxa.frame.origin = view.frame.origin
            
            ghostImage.frame.size.height = view.frame.height/2.3
            ghostImage.frame.size.width = view.frame.width
            ghostImage.center.x = view.center.x
            ghostImage.frame.origin.y = viewRoxa.frame.origin.y + viewRoxa.frame.height
            
            ghostName.adjustsFontSizeToFitWidth = true
            ghostName.frame.size.height = view.frame.height/30
            ghostName.frame.origin.x = view.frame.origin.x + closeButton.frame.height/2
            ghostName.center.y = ghostImage.center.y + ghostImage.frame.height/2

            skulls.frame.size.height = view.frame.height/30
            skulls.frame.size.width = view.frame.width/3
            skulls.frame.origin.x = view.frame.origin.x + closeButton.frame.height/2
            skulls.frame.origin.y = ghostName.frame.origin.y + ghostName.frame.height
            
            ghostDescription.frame.size.height = view.frame.height/4.5
            ghostDescription.frame.size.width = view.frame.width - closeButton.frame.height
            ghostDescription.frame.origin.x = view.frame.origin.x + closeButton.frame.height/2
            ghostDescription.frame.origin.y = skulls.frame.origin.y + skulls.frame.height
            
            caughts.frame.size.height = view.frame.height/30
            caughts.frame.size.width = view.frame.width/3
            caughts.frame.origin.x = view.frame.origin.x + closeButton.frame.height/2
            caughts.frame.origin.y = ghostDescription.frame.origin.y + ghostDescription.frame.height
            
            ghostCount.frame.size.height = view.frame.height/30
            ghostCount.frame.size.width = view.frame.width/5
            ghostCount.frame.origin.x = caughts.frame.origin.x + caughts.frame.width
            ghostCount.frame.origin.y = ghostDescription.frame.origin.y + ghostDescription.frame.height
            
            
            
        }
        else {
            print("optionalInt was nil")
        }
        
    }
    
    
    

    

}
