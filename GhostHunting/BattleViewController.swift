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
    
    var ghost: GhostData?
    var percent: Double?
    
    var timerCount:Timer?
    var timeLeft = 60
    
    @IBAction func exitButton(_ sender: Any) {
          self.dismiss(animated: true, completion: nil)
          print("exit battleView")
    }
    
    
    @IBAction func ghostButton(_ sender: Any) {
        let width = lifeBar.frame.width - (lifeBar.frame.width * CGFloat(percent ?? 0))
        print(lifeBar.frame.width * CGFloat(percent ?? 0))
        lifeBar.frame = CGRect(x: lifeBar.frame.origin.x, y: lifeBar.frame.origin.y, width: width, height: lifeBar.frame.height)
        
        if lifeBar.frame.width <= 10 {
            trap?.image = UIImage(named: "trap")
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBattle()
        print("o ghost selecionado foi \(ghost?.imageFileName ?? " nenhum ")")
 
    }
    

    func setUpBattle(){
        timerCount = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        
        ghostImage?.image = UIImage(named: ghost?.imageFileName ?? "heart")
        skullImage?.image = UIImage(named: ghost?.skullsClass ?? "heart")
        percent = ghost?.lifePercent
        trap?.image = UIImage(named: " ")
    }
    
    @objc func onTimerFires() {
        timeLeft -= 1
        timer.text = "\(timeLeft)"
        
        if timeLeft <= 0 {
            timerCount?.invalidate()
            timer = nil
 
        }
    }
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        if recognizer.state == UIGestureRecognizer.State.ended {
            winBattle(trap: trap!, button: button)
        }
        
        
    }

    func winBattle(trap: UIImageView, button: UIButton){
        if trap.frame.intersects(button.frame) {
            print("win game")
            //prepare for segue
        }
    }

}
