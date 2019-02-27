//
//  ItemsShopViewController.swift
//  Sky Dropper
//
//  Created by Alexander Hall on 2/26/19.
//  Copyright © 2019 Hall Inc. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class ItemsShopViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            
            if let scene = SKScene(fileNamed: "ItemsShopViewScene") {
                
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

