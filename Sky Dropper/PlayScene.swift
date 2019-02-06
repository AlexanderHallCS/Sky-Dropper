//
//  PlayScene.swift
//  Sky Dropper
//
//  Created by Alexander Hall on 2/3/19.
//  Copyright © 2019 Hall Inc. All rights reserved.
//

import SpriteKit
import GameplayKit

class PlayScene: SKScene {
    
    var fallingItems :[SKSpriteNode] = [SKSpriteNode]()
    let redAppleTexture = SKTexture(imageNamed: "FallingAppleRed")
    let greenAppleTexture = SKTexture(imageNamed: "FallingAppleGreen")
    let yellowAppleTexture = SKTexture(imageNamed: "FallingAppleYellow")
    
    override func didMove(to view: SKView) {
        
    }
    
    func spawnApple() {
        let redApple = SKSpriteNode(texture: redAppleTexture)
        redApple.physicsBody = SKPhysicsBody(texture: redAppleTexture, size: redApple.size)
        redApple.physicsBody!.isDynamic = true
        redApple.physicsBody!.usesPreciseCollisionDetection = true
        redApple.physicsBody!.affectedByGravity = false
        redApple.physicsBody!.velocity = CGVector.init(dx: 0, dy: -400)
        redApple.position = CGPoint(x: 0, y: 0)
        addChild(redApple)
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
    }
}
