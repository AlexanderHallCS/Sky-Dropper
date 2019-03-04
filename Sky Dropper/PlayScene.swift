//
//  PlayScene.swift
//  Sky Dropper
//
//  Created by Alexander Hall on 2/3/19.
//  Copyright © 2019 Hall Inc. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

let motionManager: CMMotionManager = CMMotionManager()

class PlayScene: SKScene, SKPhysicsContactDelegate {
    
    var charLocX: CGFloat = 0.0
    
    var fallingItems :[SKSpriteNode] = [SKSpriteNode]()
    let redAppleTexture = SKTexture(imageNamed: "FallingAppleRed")
    let greenAppleTexture = SKTexture(imageNamed: "FallingAppleGreen")
    let yellowAppleTexture = SKTexture(imageNamed: "FallingAppleYellow")
    
    let backgroundTexture = SKTexture(imageNamed: "StartingBG")
    
    let worldNode = SKNode()
    
    var characterTexture = SKTexture(imageNamed: "DefaultBasketCharacterRight")
    var character = SKSpriteNode()
    
    override func didMove(to view: SKView) {
      //  worldNode.isPaused = false
      //  physicsWorld.speed = 1
        
        physicsWorld.contactDelegate = self
        let background = SKSpriteNode(texture: backgroundTexture)
        //background.size.width = self.size.width
        //background.size.height = self.size.height
        background.size = self.frame.size
        addChild(background)
        addChild(worldNode)
        
        character = SKSpriteNode(texture: characterTexture)
        character.name = "character"
        if(UIDevice.current.userInterfaceIdiom == .phone) {
            character.position = CGPoint(x: 0, y: self.size.height/2 * -1 + self.size.height/10)
        } else if(UIDevice.current.userInterfaceIdiom == .pad) {
            character.position = CGPoint(x: 0, y: self.size.height/2 * -1 + self.size.height/10 * 3 - 30)
        }
        character.zPosition = 1
        character.physicsBody = SKPhysicsBody(texture: characterTexture, size: characterTexture.size())
        //character.physicsBody!.isDynamic = true
        character.physicsBody!.isDynamic = false
        //character.physicsBody!.usesPreciseCollisionDetection = true
        character.physicsBody!.affectedByGravity = false
        //character.physicsBody!.categoryBitMask = ColliderType.characterCategory.rawValue
        //character.physicsBody!.collisionBitMask = 0
        //character.physicsBody!.contactTestBitMask = ColliderType.bossBulletCategory.rawValue
        addChild(character)
        
        motionManager.accelerometerUpdateInterval = 1.0/20.0
        if motionManager.isAccelerometerAvailable == true {
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!)  { (data, error) in
                let currentX = self.character.position.x
                if data!.acceleration.x < 0.0 {
                    if(!(currentX < -280)) {
                        self.charLocX = currentX + CGFloat((data?.acceleration.x)! * 100)
                        self.characterTexture = SKTexture(imageNamed: "DefaultBasketCharacterLeft")
                        self.character.texture = self.characterTexture
                    }
                } else if data!.acceleration.x > 0.0 {
                    if(!(currentX > 310)) {
                        self.charLocX = currentX + CGFloat((data?.acceleration.x)! * 100)
                        self.characterTexture = SKTexture(imageNamed: "DefaultBasketCharacterRight")
                        self.character.texture = self.characterTexture
                    }
                }
                self.character.physicsBody?.velocity = CGVector(dx: (data?.acceleration.x)! * 9.0, dy: 0)
            }
        }
        
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
        
        let moveCharX = SKAction.moveTo(x: charLocX, duration: 0.08)
        self.character.run(moveCharX)
        
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
        
        /*if(PlayViewController.GlobalPause.isDeinitializing == true) {
            self.removeAllChildren()
            worldNode.removeAllChildren()
            worldNode.isPaused = false
            physicsWorld.speed = 1
            PlayViewController.GlobalPause.paused = false
            print("deinitialize")
        } */
        
    }
}
