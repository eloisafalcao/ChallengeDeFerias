//
//  File.swift
//  GhostHunting
//
//  Created by Eloisa Falcão on 17/07/19.
//  Copyright © 2019 Eloisa Falcão. All rights reserved.
//

import CoreData
import UIKit

func makeAllGhosts(){
    makeAGhost(name: "Ghost of past bug", withThe: "1StarsGhost.png", skulls: "1Skulls")
    makeAGhost(name: "Boo", withThe: "2StarsGhost.png", skulls: "2Skulls")
    makeAGhost(name: "Cry Baby", withThe: "3StarsGhost.png", skulls: "3Skulls")
    makeAGhost(name: "Casper", withThe: "4StarsGhost.png", skulls: "4Skulls")
    makeAGhost(name: "Poltergeist", withThe: "5StarsGhost.png", skulls: "5Skulls")

(UIApplication.shared.delegate as! AppDelegate).saveContext()


}

func makeAGhost(name:String, withThe imageName:String, skulls: String){
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let ghost = GhostData(context: context)
    
    ghost.name = name
    ghost.imageFileName = imageName
    ghost.skullsClass = skulls
    
}

func bringAllTheGhosts() -> [GhostData] {
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    do {
        let ghosts = try context.fetch(GhostData.fetchRequest()) as! [GhostData]
        
        if ghosts.count == 0 {
            makeAllGhosts()
            return bringAllTheGhosts()
        }
        return ghosts
    } catch {
        print("nao achou fantasmas no Core Data ")
    }
    
    return []
}

func getCaughtGhosts() -> [GhostData] {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let fetchRequest = GhostData.fetchRequest() as NSFetchRequest<GhostData>
    fetchRequest.predicate = NSPredicate(format: "countCaught > %d", 0)
    
    do{
        let ghosts = try context.fetch(GhostData.fetchRequest()) as! [GhostData]
        return ghosts
    } catch {
        print("nao achou fantasmas capturados no Core Data ")
    }
    
    return []
}
