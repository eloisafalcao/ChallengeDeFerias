//
//  Journal.swift
//  GhostHunting
//
//  Created by Eloisa Falcão on 17/07/19.
//  Copyright © 2019 Eloisa Falcão. All rights reserved.
//

import UIKit
import CoreData

class Journal: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var searchView: UIView!
    
    var caughtsGhosts: [GhostData] = []
//    var filteredGhosts = [GhostData]()
//
//    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var closeButton: UIButton!
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var viewRoxa: UIView!
    @IBOutlet weak var journal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        caughtsGhosts = getCaughtGhosts()
        
        //Search Bar
//        filteredGhosts = caughtsGhosts
//
//        searchController.searchResultsUpdater = self
//        searchController.dimsBackgroundDuringPresentation = false
//        definesPresentationContext = true
//        searchView = searchController.searchBar
//
//
        //Autolayout
        closeButton.frame.size.height = view.frame.height/20
        closeButton.frame.size.width = closeButton.frame.height
        closeButton.frame.origin.x = view.frame.origin.x + closeButton.frame.height/2
        closeButton.frame.origin.y = view.frame.origin.x + closeButton.frame.height
        
        viewRoxa.frame.size.height = view.frame.height/5
        viewRoxa.frame.size.width = view.frame.width
        viewRoxa.center.x = view.center.x
        viewRoxa.frame.origin = view.frame.origin
        
         journal.adjustsFontSizeToFitWidth = true
         journal.frame.size.height = view.frame.height/20
         journal.frame.origin.x = view.frame.origin.x + closeButton.frame.height/2
         journal.frame.origin.y = closeButton.frame.origin.y + (closeButton.frame.height/2)*3
        
        collectionView.frame.size.height = view.frame.height - viewRoxa.frame.size.height
        collectionView.frame.size.width = view.frame.width
        collectionView.center.x = view.center.x
        collectionView.frame.origin.y = viewRoxa.frame.origin.y + viewRoxa.frame.size.height
    
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return caughtsGhosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Celula
        var ghost: GhostData
        ghost = self.caughtsGhosts[indexPath.row]
        
        if ghost.countCaught == 0 {
            cell.image.image = UIImage(named: ghost.nonSelectImage ?? "naoSelecionadoFantasma2.png")
            cell.orangeView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            cell.skullw.image = UIImage(named: " ")
            
        } else {
            cell.image.image = UIImage(named: ghost.imageFileName ?? " ")
            cell.skullw.image = UIImage(named: ghost.skullsClass ?? " ")
            
//            cell.image.image = UIImage(named: filteredGhosts[indexPath.row].imageFileName ?? " ")
//            cell.skullw.image = UIImage(named: filteredGhosts[indexPath.row].skullsClass ?? " ")
        }
        
        return cell
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cellSegue" {
            let journalPageVc = segue.destination as! JornalPageViewController
            let cell = sender as! UICollectionViewCell
            let indexPath = collectionView.indexPath(for: cell)
            let ghost = caughtsGhosts[(indexPath?.row)!]
            journalPageVc.ghost = ghost
        }
    }
    
//    func updateSearchResults(for searchController: UISearchController) {
//        if searchController.searchBar.text! == "" {
//            filteredGhosts = caughtsGhosts
//        } else {
//            filteredGhosts = caughtsGhosts.filter { $0.name?.lowercased().contains(searchController.searchBar.text!.lowercased()) ?? false }
//        }
//
//        self.collectionView.reloadData()
//
//    }
  
}
