//
//  TasksViewController.swift
//  GhostHunting
//
//  Created by Eloisa Falcão on 30/07/19.
//  Copyright © 2019 Eloisa Falcão. All rights reserved.
//
//
//import UIKit
//
//class TasksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//    
//    @IBAction func cluseButtonAction(_ sender: Any) {
//           self.dismiss(animated: true, completion: nil)
//    }
//    
//    
//    @IBOutlet weak var closeButton: UIButton!
//    @IBOutlet weak var viewRoxa: UIView!
//    @IBOutlet weak var taskTitle: UILabel!
//    @IBOutlet weak var tableView: UITableView!
//    
//    var tasks: [Task] = []
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
////         tasks = bringtasks()
//        
//        //Autolayout
//        closeButton.frame.size.height = view.frame.height/20
//        closeButton.frame.size.width = closeButton.frame.height
//        closeButton.frame.origin.x = view.frame.origin.x + closeButton.frame.height/2
//        closeButton.frame.origin.y = view.frame.origin.x + closeButton.frame.height
//        
//        viewRoxa.frame.size.height = view.frame.height/5
//        viewRoxa.frame.size.width = view.frame.width
//        viewRoxa.center.x = view.center.x
//        viewRoxa.frame.origin = view.frame.origin
//        
//        taskTitle.adjustsFontSizeToFitWidth = true
//        taskTitle.frame.size.height = view.frame.height/20
//        taskTitle.frame.origin.x = view.frame.origin.x + closeButton.frame.height/2
//        taskTitle.frame.origin.y = closeButton.frame.origin.y + (closeButton.frame.height/2)*3
//        
//        tableView.frame.size.height = view.frame.height - viewRoxa.frame.height
//        tableView.frame.size.width = view.frame.width
//        tableView.center.x = view.center.x
//        tableView.frame.origin.y = viewRoxa.frame.height
//        tableView.frame.origin.x = 0
//    
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return tasks.count
//    }
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
//        
//        let task: Task = self.tasks[indexPath.row]
//        cell.titulo.text = task.title
//        cell.descricao.text = task.descricao
//        print(task)
//        return cell
//}
//    
//    
//    
//    
//}
