//
//  JornalPageViewController.swift
//  GhostHunting
//
//  Created by Eloisa Falcão on 22/07/19.
//  Copyright © 2019 Eloisa Falcão. All rights reserved.
//

import UIKit

class JornalPageViewController: UIViewController {

    @IBOutlet weak var ghostImage: UIImageView!
    @IBOutlet weak var ghostDescription: UILabel!
    @IBOutlet weak var ghostName: UILabel!
    @IBOutlet weak var skulls: UIImageView!
    @IBOutlet weak var ghostCount: UILabel!
    
    @IBAction func exitButton(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
