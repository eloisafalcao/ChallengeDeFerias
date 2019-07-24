//
//  WinLoseViewController.swift
//  GhostHunting
//
//  Created by Eloisa Falcão on 23/07/19.
//  Copyright © 2019 Eloisa Falcão. All rights reserved.
//

import UIKit

class WinLoseViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    var segueName: String = " "
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpScreen()

    }
    
    func setUpScreen(){
        if segueName == "winSegue" {
            image.image = UIImage(named: "iconGhost")
            
        } else if segueName == "loseSegue"{
            image.image = UIImage(named: "goop")
            
        }
    }
    
    

 
}
