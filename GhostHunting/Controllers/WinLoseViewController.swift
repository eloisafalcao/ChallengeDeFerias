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
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpScreen()
        
        title2.adjustsFontSizeToFitWidth = true
        title2.frame.size.width = view.frame.width
        title2.frame.size.height = view.frame.height/15
        title2.center.x = view.center.x
        title2.center.y = view.frame.height/4
        
        image.frame.size.width = view.frame.height/2.6
        image.frame.size.height = view.frame.height/2.6
        image.center.x = view.center.x
        image.center.y = title2.center.y + image.frame.height/1.2
        
        text.adjustsFontSizeToFitWidth = true
        text.frame.size.width = view.frame.width/1.2
        text.frame.size.height = view.frame.height/5
        text.center.x = view.center.x
        text.center.y = image.center.y + text.frame.height*1.2
        
        button.frame.size.height = view.frame.height/15
        button.frame.size.width = button.frame.height*2
        button.center.x = view.center.x
        button.center.y = text.center.y + button.frame.height*2
        
        

    }
    
    func setUpScreen(){
        if segueName == "winSegue" {
            image.image = UIImage(named: "iconGhost")
            title2.text = "Good Job!"
            text.text = "You can check out your catch in the journal!"
            
        } else if segueName == "loseSegue"{
            image.image = UIImage(named: "goop")
            title2.text = "Ugh, goop!"
            text.text = "It ran-away!"
        }
    }
    

 
}
