//
//  BattleViewController.swift
//  GhostHunting
//
//  Created by Eloisa Falcão on 20/07/19.
//  Copyright © 2019 Eloisa Falcão. All rights reserved.
//

import UIKit
import Foundation

class BattleViewController: UIViewController {
    
    @IBOutlet weak var ghostImage: UIImageView?
    @IBOutlet weak var trap: UIImageView?
    @IBOutlet weak var skullImage: UIImageView?
    @IBOutlet weak var lifeBar: UIView!
    @IBOutlet weak var timer: UILabel!
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var ghostName: UILabel!
    @IBOutlet weak var tapIt: UIImageView!
    @IBOutlet weak var exitBattleButton: UIButton!
    @IBOutlet weak var heart: UIImageView!
    @IBOutlet weak var backBar: UIImageView!
    
    var ghost: GhostData?
    var percent: Double?
    
    var timerCount:Timer?
    var timeLeft = 30
    
    @IBAction func exitButton(_ sender: Any) {
          self.dismiss(animated: true, completion: nil)
          print("exit battleView")
    }
    
    
    @IBAction func ghostButton(_ sender: Any) {
        tapIt.isHidden = true
        
        let width = lifeBar.frame.width - (lifeBar.frame.width * CGFloat(percent ?? 0))
        lifeBar.frame = CGRect(x: lifeBar.frame.origin.x, y: lifeBar.frame.origin.y, width: width, height: lifeBar.frame.height)
        
        if lifeBar.frame.width <= 10 {
            trap?.image = UIImage(named: "trap")
            tapIt.isHidden = false
            tapIt.image = UIImage(named: "throwTheTrap")
        }

    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBattle()
        print("o ghost selecionado foi \(ghost?.imageFileName ?? " nenhum ")")
        
        
        //Autolayout
        exitBattleButton.frame.size.height = view.frame.height/20
        exitBattleButton.frame.size.width = exitBattleButton.frame.height
        exitBattleButton.frame.origin.x = view.frame.origin.x + exitBattleButton.frame.height/2
        exitBattleButton.frame.origin.y = view.frame.origin.x + exitBattleButton.frame.height
        
        ghostName.adjustsFontSizeToFitWidth = true
        ghostName.frame.size.height = view.frame.height/30
        ghostName.frame.size.width = view.frame.width - view.frame.width/3
        ghostName.frame.origin.x = view.frame.origin.x + exitBattleButton.frame.height/2
        ghostName.frame.origin.y = exitBattleButton.frame.height + ghostName.frame.height*2
        
        skullImage?.frame.size.height = view.frame.height/30
        skullImage?.frame.size.width = view.frame.width/3
        skullImage?.center.y = ghostName.center.y
        skullImage?.frame.origin.x = view.center.x + view.frame.width/6
        
        backBar.frame.size.height = view.frame.height/16
        backBar.frame.size.width = view.frame.width/1.2
        backBar.center.x = view.center.x
        backBar.center.y = ghostName.center.y + backBar.frame.height
        
        lifeBar.frame.size.height = view.frame.height/25
        lifeBar.frame.size.width = backBar.frame.width/1.05
        lifeBar.center.x = view.center.x
        lifeBar.center.y = backBar.center.y
        
        heart.frame.size.height = view.frame.height/11
        heart.frame.size.width = heart.frame.height
        heart.frame.origin.x = view.frame.origin.x + exitBattleButton.frame.height
        heart.center.y = backBar.center.y
        
        ghostImage?.frame.size.height = view.frame.height/2.3
        ghostImage?.frame.size.width = view.frame.height/2.3
        ghostImage?.center = view.center
        
        button?.frame.size.height = view.frame.height/2.3
        button.frame.size.width = view.frame.height/2.3
        button.center = view.center
        
        tapIt.frame.size.height = view.frame.height/9
        tapIt.frame.size.width = view.frame.width/2
        tapIt.center.x = view.center.x
        tapIt.center.y = view.frame.height - view.frame.height/4.6
        
        trap?.frame.size.height = view.frame.height/11
        trap?.frame.size.width = view.frame.height/11
        trap?.center.x = view.center.x
        trap?.center.y = tapIt.center.y + view.frame.height/10
        
        timer.frame.size.height = view.frame.height/9
        timer.frame.size.width = view.frame.width/2
        timer.center.x = view.center.x
        timer.center.y =  backBar.center.y +  backBar.frame.height
  
    }
    

    func setUpBattle(){
        timerCount = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        
        ghostImage?.image = UIImage(named: ghost?.imageFileName ?? "heart")
        skullImage?.image = UIImage(named: ghost?.skullsClass ?? "heart")
        percent = ghost?.lifePercent
        ghostName?.text = ghost?.name
        trap?.image = UIImage(named: " ")
        
    }
    
    
    @objc func onTimerFires() {
        timeLeft -= 1
        timer.text = "\(timeLeft)"
        
        if timeLeft <= 0 {
            timerCount?.invalidate()
            timer = nil
            self.performSegue(withIdentifier: "loseSegue", sender: self)
            print("lose game")
 
        }
    }
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        if recognizer.state == UIGestureRecognizer.State.began{
             tapIt.isHidden = true
        }
        
        if recognizer.state == UIGestureRecognizer.State.ended {
            winBattle(trap: trap!, button: button)
        }
        
        
    }

    func winBattle(trap: UIImageView, button: UIButton){
        if trap.frame.intersects(button.frame) {
            print("win game")
            self.performSegue(withIdentifier: "winSegue", sender: self)
        }
        
        updateCount(name: ghostName.text ?? "Ghost!")

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "winSegue" {
            let vc = segue.destination as? WinLoseViewController
            vc?.segueName = "winSegue"
             
        } else if segue.identifier == "loseSegue" {
          let vc = segue.destination as? WinLoseViewController
          vc?.segueName = "loseSegue"
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseInOut, .repeat, .autoreverse, .allowUserInteraction], animations: {
            
            self.ghostImage?.center.y = self.view.center.y + 30
            self.button?.center.y = self.view.center.y + 30

        })
        
        
    }
    
 
    
}
