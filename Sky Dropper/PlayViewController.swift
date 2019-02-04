//
//  PlayViewController.swift
//  Sky Dropper
//
//  Created by Alexander Hall on 2/3/19.
//  Copyright © 2019 Hall Inc. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class PlayViewController: UIViewController {
    
    var sceneHeight: CGFloat = 0
    var sceneWidth: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'PlayScene.sks'
            if let scene = SKScene(fileNamed: "PlayScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                sceneHeight = scene.size.height
                sceneWidth = scene.size.width
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    @IBAction func openPauseView(_ sender: Any) {
        let window = UIApplication.shared.keyWindow!
        let v = UIView(frame: CGRect(x: sceneHeight/16, y: sceneHeight/16, width: sceneWidth/3, height: sceneHeight/2.7))
        window.addSubview(v);
        v.backgroundColor = UIColor.black
        
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
