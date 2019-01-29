//
//  GameViewController.swift
//  Sky Dropper
//
//  Created by Alexander Hall on 1/9/19.
//  Copyright © 2019 Hall Inc. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //shopButton initialization
        let shopButton = UIButton(type: UIButton.ButtonType.system) as UIButton
        let shopButtonImage = UIImage(named: "ShopButton")
        shopButton.setImage(shopButtonImage, for: .normal)
        shopButton.frame = CGRect(x: scene.size.height.get, y: 20, width: 60, height: 60)
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'StartScene.sks'
            if let scene = SKScene(fileNamed: "StartScene") {
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
