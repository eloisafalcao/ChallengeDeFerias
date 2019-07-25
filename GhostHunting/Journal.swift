//
//  Journal.swift
//  GhostHunting
//
//  Created by Eloisa Falcão on 17/07/19.
//  Copyright © 2019 Eloisa Falcão. All rights reserved.
//

import UIKit
import CoreData

class Journal: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
   
    var caughtsGhosts: [GhostData] = []
    
   
//    var caughtGhosts: [NSManagedObject] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var closeButton: UIButton!
    @IBAction func closeButtonAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        caughtsGhosts = getCaughtGhosts()
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return caughtsGhosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Celula
       
        var ghost: GhostData
        ghost = self.caughtsGhosts[indexPath.row]
        cell.image.image = UIImage(named: ghost.imageFileName ?? "heart")
        
//        let caughtGhost = caughtGhosts[indexPath.row]
//        cell.ghostName.text = caughtGhost.value(forKey: "ghostName") as? String

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let journalPage = storyboard?.instantiateViewController(withIdentifier: "JornalPageViewController") as? JornalPageViewController
        
        
    
    }
    
}
