//
//  EndViewController.swift
//  Sky Dropper
//
//  Created by Alexander Hall on 1/25/19.
//  Copyright © 2019 Hall Inc. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class EndViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            
            if let scene = SKScene(fileNamed: "EndViewScene") {
                
                scene.backgroundColor = SKColor.yellow
                
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    @IBAction func playAgain(_ sender: Any) {
        self.performSegue(withIdentifier: "endToPlay", sender: nil)
    }
    @IBAction func backToHome(_ sender: Any) {
        self.performSegue(withIdentifier: "endToStart", sender: nil)
    }
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
