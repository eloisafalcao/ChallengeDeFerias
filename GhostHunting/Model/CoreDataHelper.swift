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
    makeAGhost(name: "Ghost of past bug", withThe: "1StarsGhost.png", skulls: "1Skulls", percent: 0.3, description: " 1 star description ")
    makeAGhost(name: "Boo", withThe: "2StarsGhost.png", skulls: "2Skulls", percent: 0.25, description: " 2 star description ")
    makeAGhost(name: "Cry Baby", withThe: "3StarsGhost.png", skulls: "3Skull", percent: 0.2, description: " 3 star description")
    makeAGhost(name: "Casper", withThe: "4StarsGhost.png", skulls: "4Skulls", percent: 0.15, description: "4 star description ")
    makeAGhost(name: "Poltergeist", withThe: "5StarsGhost.png", skulls: "5Skuls", percent: 0.10, description: " 5 star description")

    (UIApplication.shared.delegate as! AppDelegate).saveContext()


}

func makeAGhost(name:String, withThe imageName:String, skulls: String, percent: Double, description: String) {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let ghost = GhostData(context: context)
    
    ghost.name = name
    ghost.imageFileName = imageName
    ghost.ghostDescription = description 
    ghost.skullsClass = skulls
    ghost.lifePercent = percent
    ghost.countCaught = 0
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

func updateCount(name: String) {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let fetchRequest = GhostData.fetchRequest() as NSFetchRequest<GhostData>
    fetchRequest.predicate = NSPredicate(format: "countCaught > %d", 0)
    
    do{
        let ghosts = try context.fetch(GhostData.fetchRequest()) as! [GhostData]
        for ghost in ghosts {
            if ghost.name == name{
                let newCount = ghost.countCaught + 1
                ghost.setValue(newCount, forKey: "countCaught")
                print("\(ghost) contagem = \(newCount)")
            }
        }
    } catch {
        print(" nao atualizou o count ")
    }
}