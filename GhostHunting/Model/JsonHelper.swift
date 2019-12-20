//
//  JsonHelper.swift
//  GhostHunting
//
//  Created by Eloisa Falcão on 02/08/19.
//  Copyright © 2019 Eloisa Falcão. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct JsonGhost: Codable {
    var name: String
    var imageFileName: String
    var skullsClass: String
    var lifePercent: Double
    var ghostDescription: String
    var nonSelectImage: String
    var countCaught: Int
    
    public func create(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "GhostData" , in: managedContext)!
        
        let ghost = NSManagedObject(entity: userEntity, insertInto: managedContext)
        
        ghost.setValue(self.name, forKeyPath: "name")
        ghost.setValue(self.imageFileName, forKeyPath: "imageFileName")
        ghost.setValue(self.skullsClass, forKeyPath: "skullsClass")
        ghost.setValue(self.lifePercent, forKeyPath: "lifePercent")
        ghost.setValue(self.ghostDescription, forKeyPath: "ghostDescription")
        ghost.setValue(self.nonSelectImage, forKeyPath: "nonSelectImage")
        ghost.setValue(self.countCaught, forKeyPath: "countCaught")
      
        do {
            try managedContext.save()
        }
        catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func update(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "GhostData")
        fetchRequest.predicate = NSPredicate(format: "countCaught > %d", 0)
        
        do {
            let test = try managedContext.fetch(fetchRequest)
            if(test.count != 0){
                let ghost = test[0] as! NSManagedObject
                
                ghost.setValue(self.name, forKeyPath: "name")
                ghost.setValue(self.imageFileName, forKeyPath: "imageFileName")
                ghost.setValue(self.skullsClass, forKeyPath: "skullsClass")
                ghost.setValue(self.lifePercent, forKeyPath: "lifePercent")
                ghost.setValue(self.ghostDescription, forKeyPath: "ghostDescription")
                ghost.setValue(self.nonSelectImage, forKeyPath: "nonSelectImage")
                ghost.setValue(self.countCaught, forKeyPath: "countCaught")
                
            } else {
                print("Ghost not found")
            }
            
            do {
                try managedContext.save()
            }
            catch let error as NSError {
                print(error)
            }
        }
        catch {
            print(error)
        }
    }

class getJsonGhost: NSObject{
    static func getCaughtGhosts() -> [JsonGhost] {
        var ghosts: [JsonGhost] = []
        do {
            if let path = Bundle.main.path(forResource: "ghosts", ofType: "json", inDirectory: nil)
            {
                let url = URL(fileURLWithPath: path)
                let ghostsData = try Data(contentsOf: url)
                ghosts = try JSONDecoder().decode([JsonGhost].self, from: ghostsData)
                return ghosts            }
        } catch {
            print("Erro")
        }
        return ghosts
    }

}


}

