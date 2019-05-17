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
import AVFoundation

var audioPlayer = AVAudioPlayer()

class PlayViewController: UIViewController {
    
    var sceneHeight: CGFloat = 0
    var sceneWidth: CGFloat = 0
    
    struct GlobalPause {
        static var paused = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "SkyDropperMusic1", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
        }
        catch {
            print("The audio file was not found!")
        }
        
        if(audioPlayer.isPlaying == false) {
            audioPlayer.play()
        }
        
        audioPlayer.numberOfLoops = -1
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'PlayScene.sks'
            if let scene = SKScene(fileNamed: "PlayScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                sceneHeight = scene.size.height
                sceneWidth = scene.size.width
                
                viewController = self
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            //view.showsFPS = true
            //view.showsNodeCount = true
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        audioPlayer.stop()
        lives = 0
    }
    
    @IBAction func openPauseView(_ sender: Any) {
        let pauseVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "pausePopUpID") as! PauseViewController
        self.addChild(pauseVC)
        pauseVC.view.frame = self.view.frame
        self.view.addSubview(pauseVC.view)
        pauseVC.didMove(toParent: self)
        GlobalPause.paused = true
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
