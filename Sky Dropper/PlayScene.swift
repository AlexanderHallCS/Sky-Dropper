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

enum ColliderType:UInt32 {
    case characterCategory = 0b01
    case fallingItemCategory = 0b10
    case characterSphericalCollisionObjectCategory = 0b100
}

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
    
    var heartTexture = SKTexture(imageNamed: "Heart")
    var heart1 = SKSpriteNode()
    var heart2 = SKSpriteNode()
    var heart3 = SKSpriteNode()
    var heart4 = SKSpriteNode()
    var heart5 = SKSpriteNode()
    
    var spawnFallingItemTimer = Timer()
    
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
        character.zPosition = 3
        character.physicsBody = SKPhysicsBody(texture: characterTexture, size: characterTexture.size())
        //character.physicsBody!.isDynamic = true
        character.physicsBody!.isDynamic = false
        //character.physicsBody!.usesPreciseCollisionDetection = true
        character.physicsBody!.affectedByGravity = false
        //character.physicsBody!.categoryBitMask = ColliderType.characterCategory.rawValue
        //character.physicsBody!.collisionBitMask = 0
        //character.physicsBody!.contactTestBitMask = ColliderType.bossBulletCategory.rawValue
        addChild(character)
        
        heart1 = SKSpriteNode(texture: heartTexture)
        heart1.zPosition = 1
        heart1.position = CGPoint(x: -self.size.width/2 + self.size.width/16, y: self.size.height/2 * -1 + self.size.height/36)
        heart1.size = CGSize(width: 30, height: 30)
        addChild(heart1)
        
        heart2 = SKSpriteNode(texture: heartTexture)
        heart2.zPosition = 1
        heart2.position = CGPoint(x: heart1.position.x + self.size.width/16, y: self.size.height/2 * -1 + self.size.height/36)
        heart2.size = CGSize(width: 30, height: 30)
        addChild(heart2)
        
        heart3 = SKSpriteNode(texture: heartTexture)
        heart3.zPosition = 1
        heart3.position = CGPoint(x: heart2.position.x + self.size.width/16, y: self.size.height/2 * -1 + self.size.height/36)
        heart3.size = CGSize(width: 30, height: 30)
        addChild(heart3)
        
        heart4 = SKSpriteNode(texture: heartTexture)
        heart4.zPosition = 1
        heart4.position = CGPoint(x: heart3.position.x + self.size.width/16, y: self.size.height/2 * -1 + self.size.height/36)
        heart4.size = CGSize(width: 30, height: 30)
        addChild(heart4)
        
        heart5 = SKSpriteNode(texture: heartTexture)
        heart5.zPosition = 1
        heart5.position = CGPoint(x: heart4.position.x + self.size.width/16, y: self.size.height/2 * -1 + self.size.height/36)
        heart5.size = CGSize(width: 30, height: 30)
        addChild(heart5)
        
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
        
        spawnFallingItemTimer = Timer.scheduledTimer(timeInterval: 1.3, target: self, selector: #selector(self.spawnFallingItem), userInfo: nil, repeats: true)
        
    }
    
    @objc func spawnFallingItem() {
        //maybe change where the apples spawn
        let randomXPosition = Int.random(in: 0...300)
        let randomItem = Int.random(in: 0...5)
        
        switch randomItem {
        case 0: let redItem = SKSpriteNode(texture: redAppleTexture)
                redItem.physicsBody = SKPhysicsBody(texture: redAppleTexture, size: redItem.size)
                redItem.physicsBody!.isDynamic = true
                redItem.physicsBody!.usesPreciseCollisionDetection = true
                redItem.physicsBody!.affectedByGravity = false
                redItem.physicsBody!.velocity = CGVector.init(dx: 0, dy: -320)
                redItem.position = CGPoint(x: Int(randomXPosition) - 300, y: 600)
                redItem.zPosition = 2
                worldNode.addChild(redItem)
                fallingItems.append(redItem)
        case 1: let redItem = SKSpriteNode(texture: redAppleTexture)
                redItem.physicsBody = SKPhysicsBody(texture: redAppleTexture, size: redItem.size)
                redItem.physicsBody!.isDynamic = true
                redItem.physicsBody!.usesPreciseCollisionDetection = true
                redItem.physicsBody!.affectedByGravity = false
                redItem.physicsBody!.velocity = CGVector.init(dx: 0, dy: -320)
                redItem.position = CGPoint(x: Int(randomXPosition) - 300, y: 600)
                redItem.zPosition = 2
                worldNode.addChild(redItem)
                fallingItems.append(redItem)
        case 2: let redItem = SKSpriteNode(texture: redAppleTexture)
                redItem.physicsBody = SKPhysicsBody(texture: redAppleTexture, size: redItem.size)
                redItem.physicsBody!.isDynamic = true
                redItem.physicsBody!.usesPreciseCollisionDetection = true
                redItem.physicsBody!.affectedByGravity = false
                redItem.physicsBody!.velocity = CGVector.init(dx: 0, dy: -320)
                redItem.position = CGPoint(x: Int(randomXPosition) - 300, y: 600)
                redItem.zPosition = 2
                worldNode.addChild(redItem)
                fallingItems.append(redItem)
        case 3: let greenItem = SKSpriteNode(texture: greenAppleTexture)
                greenItem.physicsBody = SKPhysicsBody(texture: greenAppleTexture, size: greenItem.size)
                greenItem.physicsBody!.isDynamic = true
                greenItem.physicsBody!.usesPreciseCollisionDetection = true
                greenItem.physicsBody!.affectedByGravity = false
                greenItem.physicsBody!.velocity = CGVector.init(dx: 0, dy: -320)
                greenItem.position = CGPoint(x: Int(randomXPosition) - 300, y: 600)
                greenItem.zPosition = 2
                worldNode.addChild(greenItem)
                fallingItems.append(greenItem)
        case 4: let greenItem = SKSpriteNode(texture: greenAppleTexture)
                greenItem.physicsBody = SKPhysicsBody(texture: greenAppleTexture, size: greenItem.size)
                greenItem.physicsBody!.isDynamic = true
                greenItem.physicsBody!.usesPreciseCollisionDetection = true
                greenItem.physicsBody!.affectedByGravity = false
                greenItem.physicsBody!.velocity = CGVector.init(dx: 0, dy: -320)
                greenItem.position = CGPoint(x: Int(randomXPosition) - 300, y: 600)
                greenItem.zPosition = 2
                worldNode.addChild(greenItem)
                fallingItems.append(greenItem)
        default: let yellowItem = SKSpriteNode(texture: yellowAppleTexture)
                 yellowItem.physicsBody = SKPhysicsBody(texture: yellowAppleTexture, size: yellowItem.size)
                 yellowItem.physicsBody!.isDynamic = true
                 yellowItem.physicsBody!.usesPreciseCollisionDetection = true
                 yellowItem.physicsBody!.affectedByGravity = false
                 yellowItem.physicsBody!.velocity = CGVector.init(dx: 0, dy: -320)
                 yellowItem.position = CGPoint(x: Int(randomXPosition) - 300, y: 600)
                 yellowItem.zPosition = 2
                 worldNode.addChild(yellowItem)
                 fallingItems.append(yellowItem)
        }
    }
    
    func checkFallingItemsOOB() {
        
        var iterator = 0
        while(iterator < fallingItems.count) {
            if(fallingItems[iterator].position.y < -700) {
                fallingItems[iterator].removeFromParent()
                fallingItems.remove(at: iterator)
                iterator = iterator - 1
                //fallingItemsDropped = fallingItemsDropped + 1
                //remove heart5-->4-->3-->2-->1-->gameover
            }
            iterator = iterator + 1
        }
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
        
        /*if(fallingItems.count == 0) {
         spawnFallingItem()
        } */
        
        if(PlayViewController.GlobalPause.paused == true) {
            worldNode.isPaused = true
            physicsWorld.speed = 0
        } else {
            worldNode.isPaused = false
            physicsWorld.speed = 1
        }
        
        checkFallingItemsOOB()
    }
}
