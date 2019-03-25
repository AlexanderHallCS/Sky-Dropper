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
    case characterCollisionObjectCategory = 0b100
}

class PlayScene: SKScene, SKPhysicsContactDelegate {
    
    var charLocX: CGFloat = 0.0
    var charCollisionLocX: CGFloat = 0.0
    
    var fallingItems :[SKSpriteNode] = [SKSpriteNode]()
    let redAppleTexture = SKTexture(imageNamed: "FallingAppleRed")
    let redFishTexture = SKTexture(imageNamed: "RedFish")
    let redSnowflakeTexture = SKTexture(imageNamed: "RedSnowflake")
    let redBananaTexture = SKTexture(imageNamed: "RedBanana")
    let redAlienTexture = SKTexture(imageNamed: "RedAlien")
    
    let greenAppleTexture = SKTexture(imageNamed: "FallingAppleGreen")
    let greenFishTexture = SKTexture(imageNamed: "GreenFish")
    let greenSnowflakeTexture = SKTexture(imageNamed: "GreenSnowflake")
    let greenBananaTexture = SKTexture(imageNamed: "GreenBanana")
    let greenAlienTexture = SKTexture(imageNamed: "GreenAlien")
    
    let yellowAppleTexture = SKTexture(imageNamed: "FallingAppleYellow")
    let yellowFishTexture = SKTexture(imageNamed: "YellowFish")
    let yellowSnowflakeTexture = SKTexture(imageNamed: "YellowSnowflake")
    let yellowBananaTexture = SKTexture(imageNamed: "YellowBanana")
    let yellowAlienTexture = SKTexture(imageNamed: "YellowAlien")
    
    let backgroundTexture = SKTexture(imageNamed: "StartingBG")
    
    let worldNode = SKNode()
    
    var basketCharacterTexture = SKTexture(imageNamed: "DefaultBasketCharacterRight")
    var lacrosseCharacterTexture = SKTexture(imageNamed: "LacrossePlayerRight")
    var astronautCharacterTexture = SKTexture(imageNamed: "AstronautSkinRight")
    var character = SKSpriteNode()
    
    var heartTexture = SKTexture(imageNamed: "Heart")
    var heart1 = SKSpriteNode()
    var heart2 = SKSpriteNode()
    var heart3 = SKSpriteNode()
    var heart4 = SKSpriteNode()
    var heart5 = SKSpriteNode()
    
    var cloudCurrencyLabel = SKLabelNode()
    var pointsLabel = SKLabelNode()
    var cloudCurrencyThisGame = 0
    var pointsThisGame = 0
    
    var toggleFallingItemTimerCheck = Timer()
    var spawnFallingItemTimer = Timer()
    var shouldPauseTimer = false
    
    var characterCollisionObject = SKSpriteNode()
    var isGoingLeft = false
    
    override func didMove(to view: SKView) {
        //worldNode.isPaused = false
        //physicsWorld.speed = 1
        cloudCurrencyThisGame = 0
        pointsThisGame = 0
        
        physicsWorld.contactDelegate = self
        let background = SKSpriteNode(texture: backgroundTexture)
        //background.size.width = self.size.width
        //background.size.height = self.size.height
        background.size = self.frame.size
        addChild(background)
        addChild(worldNode)
        
        cloudCurrencyLabel.text = "Clouds: \(cloudCurrencyThisGame)"
        cloudCurrencyLabel.fontName = "Baskerville"
        cloudCurrencyLabel.fontSize = 60
        cloudCurrencyLabel.fontColor = .yellow
        cloudCurrencyLabel.position = CGPoint(x: self.size.width/4 * -1 - 55, y: self.size.height/4 + 210)
        cloudCurrencyLabel.zPosition = 2
        addChild(cloudCurrencyLabel)
        
        pointsLabel.text = "Score: \(pointsThisGame)"
        pointsLabel.fontName = "Baskerville"
        pointsLabel.fontSize = 60
        pointsLabel.fontColor = .yellow
        pointsLabel.position  = CGPoint(x: self.size.width/4 * -1 - 65, y: self.size.height/4 + 270)
        pointsLabel.zPosition = 2
        addChild(pointsLabel)
        
        characterCollisionObject = SKSpriteNode(texture: heartTexture)
        characterCollisionObject.position = CGPoint(x: character.position.x + 85, y: character.position.y - 590)
        characterCollisionObject.zPosition = 3
        characterCollisionObject.physicsBody = SKPhysicsBody(texture: heartTexture, size: heartTexture.size())
        characterCollisionObject.physicsBody!.isDynamic = false
        characterCollisionObject.physicsBody!.categoryBitMask = ColliderType.characterCollisionObjectCategory.rawValue
        characterCollisionObject.physicsBody!.collisionBitMask = 0
        characterCollisionObject.physicsBody!.contactTestBitMask = ColliderType.fallingItemCategory.rawValue
        //makes the characterCollisionObject transparent
        characterCollisionObject.alpha = 0.5
        worldNode.addChild(characterCollisionObject)
        
        character = SKSpriteNode(texture: basketCharacterTexture)
        character.name = "character"
        if(UIDevice.current.userInterfaceIdiom == .phone) {
            character.position = CGPoint(x: 0, y: self.size.height/2 * -1 + self.size.height/10)
        } else if(UIDevice.current.userInterfaceIdiom == .pad) {
            character.position = CGPoint(x: 0, y: self.size.height/2 * -1 + self.size.height/10 * 3 - 30)
        }
        character.zPosition = 3
        character.physicsBody = SKPhysicsBody(texture: basketCharacterTexture, size: basketCharacterTexture.size())
        //character.physicsBody!.isDynamic = true
        character.physicsBody!.isDynamic = false
        //character.physicsBody!.usesPreciseCollisionDetection = true
        character.physicsBody!.affectedByGravity = false
        //character.physicsBody!.categoryBitMask = ColliderType.characterCategory.rawValue
        //character.physicsBody!.collisionBitMask = 0
        //character.physicsBody!.contactTestBitMask = ColliderType.bossBulletCategory.rawValue
        worldNode.addChild(character)
        
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
                let currentCollisionX = self.characterCollisionObject.position.x
                if data!.acceleration.x < 0.0 {
                    if(!(currentX < -280)) {
                        self.charLocX = currentX + CGFloat((data?.acceleration.x)! * 200)
                        self.charCollisionLocX = currentCollisionX + CGFloat((data?.acceleration.x)! * 200)
                        self.basketCharacterTexture = SKTexture(imageNamed: "DefaultBasketCharacterLeft")
                        self.character.texture = self.basketCharacterTexture
                        //move collision node 248 pixels when the character swaps directions
                        if(self.isGoingLeft == false) {
                            self.isGoingLeft = true
                            self.charCollisionLocX = self.charCollisionLocX - 248
                        }
                    }
                } else if data!.acceleration.x > 0.0 {
                    if(!(currentX > 310)) {
                        self.charLocX = currentX + CGFloat((data?.acceleration.x)! * 200)
                        self.charCollisionLocX = currentCollisionX + CGFloat((data?.acceleration.x)! * 200)
                        self.basketCharacterTexture = SKTexture(imageNamed: "DefaultBasketCharacterRight")
                        self.character.texture = self.basketCharacterTexture
                        //move collision node back 248 pixels when the character swaps directions
                        if(self.isGoingLeft == true) {
                            self.isGoingLeft = false
                            self.charCollisionLocX = self.charCollisionLocX + 248
                        }
                    }
                }
                self.character.physicsBody?.velocity = CGVector(dx: (data?.acceleration.x)! * 9.0, dy: 0)
                self.characterCollisionObject.physicsBody?.velocity = CGVector(dx: (data?.acceleration.x)! * 9.0, dy: 0)
            }
        }
        
        spawnFallingItemTimer = Timer.scheduledTimer(timeInterval: 1.3, target: self, selector: #selector(self.spawnFallingItem), userInfo: nil, repeats: true)
        toggleFallingItemTimerCheck = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.toggleFallingItemTimer), userInfo: nil, repeats: true)
        
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        // if(character.texture = yellowAppleTexture)
        //20 clouds, 500 points
        //green = 10 clouds, 250 points
        //red = 1 cloud, 100 points
        
        //collision between basket and falling items
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        if(contact.bodyA.categoryBitMask == ColliderType.fallingItemCategory.rawValue) {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else if (contact.bodyB.categoryBitMask == ColliderType.fallingItemCategory.rawValue){
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        var fallingItemIterator = 0
        while(fallingItemIterator < fallingItems.count) {
            if(firstBody.node == fallingItems[fallingItemIterator] && firstBody.node?.name == "red" && secondBody.node == characterCollisionObject) {
                //totalApplesCaught = totalApplesCaught + 1
                fallingItems[fallingItemIterator].removeFromParent()
                fallingItems.remove(at: fallingItemIterator)
                fallingItemIterator = fallingItemIterator - 1
                print("rud")
            } else if(firstBody.node == fallingItems[fallingItemIterator] && firstBody.node?.name == "green" && secondBody.node == characterCollisionObject) {
                fallingItems[fallingItemIterator].removeFromParent()
                fallingItems.remove(at: fallingItemIterator)
                fallingItemIterator = fallingItemIterator - 1
            } else if(firstBody.node == fallingItems[fallingItemIterator] && firstBody.node?.name == "yellow" && secondBody.node == characterCollisionObject) {
                fallingItems[fallingItemIterator].removeFromParent()
                fallingItems.remove(at: fallingItemIterator)
                fallingItemIterator = fallingItemIterator - 1
            }
            fallingItemIterator = fallingItemIterator + 1
        }
        
    }
    
    @objc func toggleFallingItemTimer() {
        if(spawnFallingItemTimer.isValid == true && PlayViewController.GlobalPause.paused == true && shouldPauseTimer == false) {
            shouldPauseTimer = true
            spawnFallingItemTimer.invalidate()
        } else if(spawnFallingItemTimer.isValid == false && PlayViewController.GlobalPause.paused == false && shouldPauseTimer == true){
            shouldPauseTimer = false
        }
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
                redItem.physicsBody!.categoryBitMask = ColliderType.fallingItemCategory.rawValue
                redItem.physicsBody!.collisionBitMask = 0
                redItem.physicsBody!.contactTestBitMask = ColliderType.characterCollisionObjectCategory.rawValue
                redItem.position = CGPoint(x: Int(randomXPosition) - 300, y: 600)
                redItem.zPosition = 2
                redItem.name = "red"
                worldNode.addChild(redItem)
                fallingItems.append(redItem)
        case 1: let redItem = SKSpriteNode(texture: redAppleTexture)
                redItem.physicsBody = SKPhysicsBody(texture: redAppleTexture, size: redItem.size)
                redItem.physicsBody!.isDynamic = true
                redItem.physicsBody!.usesPreciseCollisionDetection = true
                redItem.physicsBody!.affectedByGravity = false
                redItem.physicsBody!.velocity = CGVector.init(dx: 0, dy: -320)
                redItem.physicsBody!.categoryBitMask = ColliderType.fallingItemCategory.rawValue
                redItem.physicsBody!.collisionBitMask = 0
                redItem.physicsBody!.contactTestBitMask = ColliderType.characterCollisionObjectCategory.rawValue
                redItem.position = CGPoint(x: Int(randomXPosition) - 300, y: 600)
                redItem.zPosition = 2
                redItem.name = "red"
                worldNode.addChild(redItem)
                fallingItems.append(redItem)
        case 2: let redItem = SKSpriteNode(texture: redAppleTexture)
                redItem.physicsBody = SKPhysicsBody(texture: redAppleTexture, size: redItem.size)
                redItem.physicsBody!.isDynamic = true
                redItem.physicsBody!.usesPreciseCollisionDetection = true
                redItem.physicsBody!.affectedByGravity = false
                redItem.physicsBody!.velocity = CGVector.init(dx: 0, dy: -320)
                redItem.physicsBody!.categoryBitMask = ColliderType.fallingItemCategory.rawValue
                redItem.physicsBody!.collisionBitMask = 0
                redItem.physicsBody!.contactTestBitMask = ColliderType.characterCollisionObjectCategory.rawValue
                redItem.position = CGPoint(x: Int(randomXPosition) - 300, y: 600)
                redItem.zPosition = 2
                redItem.name = "red"
                worldNode.addChild(redItem)
                fallingItems.append(redItem)
        case 3: let greenItem = SKSpriteNode(texture: greenAppleTexture)
                greenItem.physicsBody = SKPhysicsBody(texture: greenAppleTexture, size: greenItem.size)
                greenItem.physicsBody!.isDynamic = true
                greenItem.physicsBody!.usesPreciseCollisionDetection = true
                greenItem.physicsBody!.affectedByGravity = false
                greenItem.physicsBody!.velocity = CGVector.init(dx: 0, dy: -320)
                greenItem.physicsBody!.categoryBitMask = ColliderType.fallingItemCategory.rawValue
                greenItem.physicsBody!.collisionBitMask = 0
                greenItem.physicsBody!.contactTestBitMask = ColliderType.characterCollisionObjectCategory.rawValue
                greenItem.position = CGPoint(x: Int(randomXPosition) - 300, y: 600)
                greenItem.zPosition = 2
                greenItem.name = "green"
                worldNode.addChild(greenItem)
                fallingItems.append(greenItem)
        case 4: let greenItem = SKSpriteNode(texture: greenAppleTexture)
                greenItem.physicsBody = SKPhysicsBody(texture: greenAppleTexture, size: greenItem.size)
                greenItem.physicsBody!.isDynamic = true
                greenItem.physicsBody!.usesPreciseCollisionDetection = true
                greenItem.physicsBody!.affectedByGravity = false
                greenItem.physicsBody!.velocity = CGVector.init(dx: 0, dy: -320)
                greenItem.physicsBody!.categoryBitMask = ColliderType.fallingItemCategory.rawValue
                greenItem.physicsBody!.collisionBitMask = 0
                greenItem.physicsBody!.contactTestBitMask = ColliderType.characterCollisionObjectCategory.rawValue
                greenItem.position = CGPoint(x: Int(randomXPosition) - 300, y: 600)
                greenItem.zPosition = 2
                greenItem.name = "green"
                worldNode.addChild(greenItem)
                fallingItems.append(greenItem)
        default: let yellowItem = SKSpriteNode(texture: yellowAppleTexture)
                 yellowItem.physicsBody = SKPhysicsBody(texture: yellowAppleTexture, size: yellowItem.size)
                 yellowItem.physicsBody!.isDynamic = true
                 yellowItem.physicsBody!.usesPreciseCollisionDetection = true
                 yellowItem.physicsBody!.affectedByGravity = false
                 yellowItem.physicsBody!.velocity = CGVector.init(dx: 0, dy: -320)
                 yellowItem.physicsBody!.categoryBitMask = ColliderType.fallingItemCategory.rawValue
                 yellowItem.physicsBody!.collisionBitMask = 0
                 yellowItem.physicsBody!.contactTestBitMask = ColliderType.characterCollisionObjectCategory.rawValue
                 yellowItem.position = CGPoint(x: Int(randomXPosition) - 300, y: 600)
                 yellowItem.zPosition = 2
                 yellowItem.name = "yellow"
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
                print("removed")
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
        let moveCollisionCharX = SKAction.moveTo(x: charCollisionLocX, duration: 0.08)
        self.characterCollisionObject.run(moveCollisionCharX)
        
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
