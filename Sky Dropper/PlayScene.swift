//
//  PlayScene.swift
//  Sky Dropper
//
//  Created by Alexander Hall on 2/3/19.
//  Copyright © 2019 Hall Inc. All rights reserved.
//

import SpriteKit
import GameplayKit

class PlayScene: SKScene, SKPhysicsContactDelegate {
    
    var fallingItems :[SKSpriteNode] = [SKSpriteNode]()
    let redAppleTexture = SKTexture(imageNamed: "FallingAppleRed")
    let greenAppleTexture = SKTexture(imageNamed: "FallingAppleGreen")
    let yellowAppleTexture = SKTexture(imageNamed: "FallingAppleYellow")
    
    let backgroundTexture = SKTexture(imageNamed: "StartingBG")
    
    let worldNode = SKNode()
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        let background = SKSpriteNode(texture: backgroundTexture)
        //background.size.width = self.size.width
        //background.size.height = self.size.height
        background.size = self.frame.size
        addChild(background)
        addChild(worldNode)
    }
    
    
    func spawnApple() {
        let redApple = SKSpriteNode(texture: redAppleTexture)
        redApple.physicsBody = SKPhysicsBody(texture: redAppleTexture, size: redApple.size)
        redApple.physicsBody!.isDynamic = true
        redApple.physicsBody!.usesPreciseCollisionDetection = true
        redApple.physicsBody!.affectedByGravity = false
        redApple.physicsBody!.velocity = CGVector.init(dx: 0, dy: -320)
        redApple.position = CGPoint(x: 0, y: 300)
        redApple.zPosition = 1
        worldNode.addChild(redApple)
        fallingItems.append(redApple)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if(fallingItems.count == 0) {
         spawnApple()
        }
        
        if(PlayViewController.GlobalPause.paused == true) {
            worldNode.isPaused = true
            physicsWorld.speed = 0
        } else {
            worldNode.isPaused = false
            physicsWorld.speed = 1
        }
        
    }
}
