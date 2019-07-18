//
//  Journal.swift
//  GhostHunting
//
//  Created by Eloisa Falcão on 17/07/19.
//  Copyright © 2019 Eloisa Falcão. All rights reserved.
//

import UIKit

class Journal: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
   
    var caughtsGhosts: [GhostData] = []
    
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
       return self.caughtsGhosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Celula
        
        var ghost: GhostData
        ghost = self.caughtsGhosts[indexPath.row]
        
        cell.image.image = UIImage(named: ghost.imageFileName ?? "heart")
        
        return cell
    }
    
    
}
