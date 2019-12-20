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
    makeAGhost(name: "Ghost of past bug", withThe: "1StarsGhost.png", skulls: "1Skulls", percent: 0.2, description: "This ghost especially haunts developers, is a bug that has been ignored and therefore returns in search of revenge.", withThe: "naoSelecionadoFantasma1.png")
    
    makeAGhost(name: "Boo", withThe: "2StarsGhost.png", skulls: "2Skulls", percent: 0.17, description: "Boo is just a little ghost who likes to play around, he's harmless but can be very annoying when upset.", withThe: "naoSelecionadoFantasma2.png")
    
    makeAGhost(name: "Cry Baby", withThe: "3StarsGhost.png", skulls: "3Skulls", percent: 0.15, description: "His cry can be heard for miles away, he haunts the sad people and feeds on their pain. Make no mistake about the size, this little guy can be very scary!", withThe: "naoSelecionadoFantasma3.png")
    
    makeAGhost(name: "Casper", withThe: "4StarsGhost.png", skulls: "4Skulls", percent: 0.1, description: "Despite the name, this ghost is not friendly at all, he is extremely needy and when he finds a haunting victim he never leaves.", withThe: "naoSelecionadoFantasma4.png")
    
    makeAGhost(name: "Poltergeist", withThe: "5StarsGhost.png", skulls: "5Skulls", percent: 0.05, description: "It carries the name of an entire category of haunts for the noise it makes, manifests itself in conjunction with the environment and so can be fatal!", withThe: "naoSelecionadoFantasma5.png")
    
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
}

func makeAGhost(name:String, withThe imageName:String, skulls: String, percent: Double, description: String, withThe zeroCountImage:String) {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let ghost = GhostData(context: context)
    
    ghost.name = name //passa o NSLOCACLIZE STRING MAS PASSA O Name
    ghost.imageFileName = imageName
    ghost.ghostDescription = description
    ghost.skullsClass = skulls
    ghost.lifePercent = percent
    ghost.countCaught = 0
    ghost.nonSelectImage = zeroCountImage
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

