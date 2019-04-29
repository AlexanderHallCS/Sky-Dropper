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
import CoreData

let motionManager: CMMotionManager = CMMotionManager()
var viewController: UIViewController?

enum ColliderType:UInt32 {
    case fallingItemCategory = 0b10
    case characterCollisionObjectCategory = 0b100
    case barrierCategory = 0b1000
    case rayGunCategory = 0b10000
    case laserCategory = 0b100000
    case barrierBlockCategory = 0b1000000
}


class PlayScene: SKScene, SKPhysicsContactDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
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
    
    var redItem = SKSpriteNode()
    var greenItem = SKSpriteNode()
    var yellowItem = SKSpriteNode()
    
    let rayGunTexture = SKTexture(imageNamed: "RayGun")
    let barrierTexture = SKTexture(imageNamed: "BarrierFalling")
    var rayGun = SKSpriteNode()
    var barrier = SKSpriteNode()
    var barrierBlock = SKSpriteNode()
    var barrierBlockTexture = SKTexture(imageNamed: "BarrierBlock")
    var removeBarrierTimer = Timer()
    
    var laserTexture = SKTexture(imageNamed: "Laser")
    var lasers :[SKSpriteNode] = [SKSpriteNode]()
    
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
    var heart6 = SKSpriteNode()
    
    var cloudCurrencyLabel = SKLabelNode()
    var pointsLabel = SKLabelNode()
    var cloudCurrencyThisGame = 0
    var pointsThisGame = 0
    var totalClouds: UInt32 = 0
    
    var toggleFallingItemTimerCheck = Timer()
    var spawnFallingItemTimer = Timer()
    var shouldPauseTimer = false
    var spawnBarrierOrRayGunTimer = Timer()
    
    var characterCollisionObject = SKSpriteNode()
    var isGoingLeft = false
    
    var lives = 5
    
    var currentSkin: UInt32 = 0
    var isAstronautUnlocked: UInt32 = 0
    var isLacrosseUnlocked: UInt32 = 0
    
    var rayGunUpgradeNumber: UInt32 = 0
    var barrierUpgradeNumber: UInt32 = 0
    
    var hasIncreasedSpeed: UInt32 = 0
    var hasExtraLife: UInt32 = 0
    
    var fallingItemsDropped: UInt32 = 0
    var redItemsCaught: UInt32 = 0
    var greenItemsCaught: UInt32 = 0
    var yellowItemsCaught: UInt32 = 0
    var totalItemsCaught: UInt32 = 0
    var totalPoints: UInt32 = 0
    
    var isWinterUnlocked: UInt32 = 0
    var isJungleUnlocked: UInt32 = 0
    var isOceanUnlocked: UInt32 = 0
    var isSpaceUnlocked: UInt32 = 0
    var currentBackground: UInt32 = 0
    
    var defaultBackgroundTexture = SKTexture(imageNamed: "StartingBG")
    var winterBG = SKTexture(imageNamed: "WinterBG")
    var jungleBG = SKTexture(imageNamed: "JungleBG")
    var oceanBG = SKTexture(imageNamed: "OceanBG")
    var spaceBG = SKTexture(imageNamed: "SpaceBG")
    var background = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
        do {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SkyDropperTracking")
            request.returnsObjectsAsFaults = false
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                currentSkin = (data.value(forKey: "currentSkin") as! UInt32)
                isAstronautUnlocked = (data.value(forKey: "isAstronautUnlocked") as! UInt32)
                isLacrosseUnlocked = (data.value(forKey: "isLacrosseUnlocked") as! UInt32)
                rayGunUpgradeNumber = (data.value(forKey: "rayGunUpgradeTracking") as! UInt32)
                barrierUpgradeNumber = (data.value(forKey: "barrierUpgradeTracking") as! UInt32)
                hasExtraLife = (data.value(forKey: "hasExtraLife") as! UInt32)
                hasIncreasedSpeed = (data.value(forKey: "hasIncreasedSpeed") as! UInt32)
                fallingItemsDropped = (data.value(forKey: "totalFallingItemsDropped") as! UInt32)
                totalPoints = (data.value(forKey: "totalPoints") as! UInt32)
                redItemsCaught = (data.value(forKey: "redItemsCaught") as! UInt32)
                greenItemsCaught = (data.value(forKey: "greenItemsCaught") as! UInt32)
                yellowItemsCaught = (data.value(forKey: "yellowItemsCaught") as! UInt32)
                totalItemsCaught = (data.value(forKey: "totalFallingItemsCaught") as! UInt32)
                isWinterUnlocked = (data.value(forKey: "isWinterBGUnlocked") as! UInt32)
                isJungleUnlocked = (data.value(forKey: "isJungleBGUnlocked") as! UInt32)
                isOceanUnlocked = (data.value(forKey: "isOceanBGUnlocked") as! UInt32)
                isSpaceUnlocked = (data.value(forKey: "isSpaceBGUnlocked") as! UInt32)
                currentBackground = (data.value(forKey: "currentBackground") as! UInt32)
                isWinterUnlocked = (data.value(forKey: "isWinterBGUnlocked") as! UInt32)
                isJungleUnlocked = (data.value(forKey: "isJungleBGUnlocked") as! UInt32)
                isOceanUnlocked = (data.value(forKey: "isOceanBGUnlocked") as! UInt32)
                isSpaceUnlocked = (data.value(forKey: "isSpaceBGUnlocked") as! UInt32)
                currentBackground = (data.value(forKey: "currentBackground") as! UInt32)
            }
        } catch {
            print("Failed")
        }
        
        cloudCurrencyThisGame = 0
        pointsThisGame = 0
        
        physicsWorld.contactDelegate = self
        
        
        if(currentBackground == 0) {
            background = SKSpriteNode(texture: defaultBackgroundTexture)
        } else if(currentBackground == 1) {
            background = SKSpriteNode(texture: winterBG)
        } else if(currentBackground == 2) {
            background = SKSpriteNode(texture: jungleBG)
        } else if(currentBackground == 3) {
            background = SKSpriteNode(texture: oceanBG)
        } else if(currentBackground == 4) {
            background = SKSpriteNode(texture: spaceBG)
        }
        background.size = self.frame.size
        addChild(background)
        
        addChild(worldNode)
        
        cloudCurrencyLabel.text = "Clouds: \(cloudCurrencyThisGame)"
        cloudCurrencyLabel.fontName = "Baskerville"
        cloudCurrencyLabel.fontSize = 60
        cloudCurrencyLabel.fontColor = .yellow
        cloudCurrencyLabel.position = CGPoint(x: self.size.width/4 * -1 - 157, y: self.size.height/4 + 210)
        cloudCurrencyLabel.zPosition = 2
        cloudCurrencyLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        addChild(cloudCurrencyLabel)
        
        pointsLabel.text = "Score: \(pointsThisGame)"
        pointsLabel.fontName = "Baskerville"
        pointsLabel.fontSize = 60
        pointsLabel.fontColor = .yellow
        pointsLabel.position  = CGPoint(x: self.size.width/4 * -1 - 155, y: self.size.height/4 + 270)
        pointsLabel.zPosition = 2
        pointsLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        addChild(pointsLabel)
        
        characterCollisionObject = SKSpriteNode(texture: heartTexture)
        characterCollisionObject.position = CGPoint(x: character.position.x + 85, y: character.position.y - 590)
        characterCollisionObject.zPosition = 3
        characterCollisionObject.physicsBody = SKPhysicsBody(texture: heartTexture, size: heartTexture.size())
        characterCollisionObject.physicsBody!.isDynamic = false
        characterCollisionObject.physicsBody!.categoryBitMask = ColliderType.characterCollisionObjectCategory.rawValue
        characterCollisionObject.physicsBody!.collisionBitMask = 0
        characterCollisionObject.physicsBody!.contactTestBitMask = ColliderType.fallingItemCategory.rawValue | ColliderType.barrierCategory.rawValue | ColliderType.rayGunCategory.rawValue
        //makes the characterCollisionObject transparent
        characterCollisionObject.alpha = 0.5
        worldNode.addChild(characterCollisionObject)
        
        if(currentSkin == 0){
            character = SKSpriteNode(texture: basketCharacterTexture)
        } else if(currentSkin == 1){
            character = SKSpriteNode(texture: astronautCharacterTexture)
        } else if(currentSkin == 2) {
            character = SKSpriteNode(texture: lacrosseCharacterTexture)
        }
        character.name = "character"
        if(UIDevice.current.userInterfaceIdiom == .phone) {
            character.position = CGPoint(x: 0, y: self.size.height/2 * -1 + self.size.height/10)
        } else if(UIDevice.current.userInterfaceIdiom == .pad) {
            character.position = CGPoint(x: 0, y: self.size.height/2 * -1 + self.size.height/10 * 3 - 30)
        }
        character.zPosition = 3
        
        if(currentSkin == 0){
            character.physicsBody = SKPhysicsBody(texture: basketCharacterTexture, size: basketCharacterTexture.size())
        } else if(currentSkin == 1){
            character.physicsBody = SKPhysicsBody(texture: astronautCharacterTexture, size: astronautCharacterTexture.size())
        } else if(currentSkin == 2) {
            character.physicsBody = SKPhysicsBody(texture: lacrosseCharacterTexture, size: lacrosseCharacterTexture.size())
        }
        character.physicsBody!.isDynamic = false
        character.physicsBody!.affectedByGravity = false
        character.physicsBody!.categoryBitMask = 0
        character.physicsBody!.collisionBitMask = 1
        character.physicsBody!.contactTestBitMask = 0
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
        
        lives = 5
        if(hasExtraLife == 1) {
            lives = 6
            heart6 = SKSpriteNode(texture: heartTexture)
            heart6.zPosition = 1
            heart6.position = CGPoint(x: heart5.position.x + self.size.width/16, y: self.size.height/2 * -1 + self.size.height/36)
            heart6.size = CGSize(width: 30, height: 30)
            addChild(heart6)
        }
        
        motionManager.accelerometerUpdateInterval = 1.0/20.0
        if motionManager.isAccelerometerAvailable == true {
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!)  { (data, error) in
                //.stopAccelerometerUpdates() when paused
                let currentX = self.character.position.x
                let currentCollisionX = self.characterCollisionObject.position.x
                if data!.acceleration.x < 0.0 {
                    if(!(currentX < -280)) {
                        if(self.hasIncreasedSpeed == 0) {
                        self.charLocX = currentX + CGFloat((data?.acceleration.x)! * 200)
                        self.charCollisionLocX = currentCollisionX + CGFloat((data?.acceleration.x)! * 200)
                        } else if(self.hasIncreasedSpeed == 1) {
                            self.charLocX = currentX + CGFloat((data?.acceleration.x)! * 400)
                            self.charCollisionLocX = currentCollisionX + CGFloat((data?.acceleration.x)! * 400)
                        }
                        if(self.currentSkin == 0){
                            self.basketCharacterTexture = SKTexture(imageNamed: "DefaultBasketCharacterLeft")
                        } else if(self.currentSkin == 1){
                             self.basketCharacterTexture = SKTexture(imageNamed: "AstronautSkinLeft")
                        } else if(self.currentSkin == 2) {
                            self.basketCharacterTexture = SKTexture(imageNamed: "LacrossePlayerLeft")
                        }
                        //CHANGE THIS MAYBE VVVVVVVVVVVV TO SUIT CURRENTSKIN
                        //self.character.texture = self.basketCharacterTexture
                        //move collision node 248 pixels when the character swaps directions
                        if(self.isGoingLeft == false) {
                            self.isGoingLeft = true
                            self.charCollisionLocX = self.charCollisionLocX - 248
                        }
                    }
                } else if data!.acceleration.x > 0.0 {
                    if(!(currentX > 310)) {
                        if(self.hasIncreasedSpeed == 0) {
                        self.charLocX = currentX + CGFloat((data?.acceleration.x)! * 200)
                        self.charCollisionLocX = currentCollisionX + CGFloat((data?.acceleration.x)! * 200)
                        } else if(self.hasIncreasedSpeed == 1) {
                            self.charLocX = currentX + CGFloat((data?.acceleration.x)! * 400)
                            self.charCollisionLocX = currentCollisionX + CGFloat((data?.acceleration.x)! * 400)
                        }
                        if(self.currentSkin == 0){
                            self.basketCharacterTexture = SKTexture(imageNamed: "DefaultBasketCharacterRight")
                        } else if(self.currentSkin == 1){
                            self.basketCharacterTexture = SKTexture(imageNamed: "AstronautSkinRight")
                        } else if(self.currentSkin == 2) {
                            self.basketCharacterTexture = SKTexture(imageNamed: "LacrossePlayerRight")
                        }
                        //CHANGE THIS MAYBE VVVVVVVVVVVV TO SUIT CURRENTSKIN
                        //self.character.texture = self.basketCharacterTexture
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
        spawnBarrierOrRayGunTimer = Timer.scheduledTimer(timeInterval: 20.0, target: self, selector: #selector(self.spawnRayGunOrBarrier), userInfo: nil, repeats: true)
        
    }
    
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        //collision between basket and falling items
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if(contact.bodyA.categoryBitMask == ColliderType.fallingItemCategory.rawValue && contact.bodyB.categoryBitMask == ColliderType.characterCollisionObjectCategory.rawValue) {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else if (contact.bodyB.categoryBitMask == ColliderType.fallingItemCategory.rawValue && contact.bodyA.categoryBitMask == ColliderType.characterCollisionObjectCategory.rawValue){
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        //collision between basket and rayGun
        var thirdBody = SKPhysicsBody()
        var fourthBody = SKPhysicsBody()
        
        if(contact.bodyA.categoryBitMask == ColliderType.rayGunCategory.rawValue && contact.bodyB.categoryBitMask == ColliderType.characterCollisionObjectCategory.rawValue) {
            thirdBody = contact.bodyA
            fourthBody = contact.bodyB
        } else if(contact.bodyB.categoryBitMask == ColliderType.rayGunCategory.rawValue && contact.bodyA.categoryBitMask == ColliderType.characterCollisionObjectCategory.rawValue) {
            thirdBody = contact.bodyB
            fourthBody = contact.bodyA
        }
        
        //collision between basket and falling barrier
        var fifthBody = SKPhysicsBody()
        var sixthBody = SKPhysicsBody()
        
        if(contact.bodyA.categoryBitMask == ColliderType.barrierCategory.rawValue && contact.bodyB.categoryBitMask == ColliderType.characterCollisionObjectCategory.rawValue) {
            fifthBody = contact.bodyA
            sixthBody = contact.bodyB
        } else if(contact.bodyB.categoryBitMask == ColliderType.barrierCategory.rawValue && contact.bodyA.categoryBitMask == ColliderType.characterCollisionObjectCategory.rawValue) {
            fifthBody = contact.bodyB
            sixthBody = contact.bodyA
        }
        
        //collision between lasers and falling items
        var seventhBody = SKPhysicsBody()
        var eightBody = SKPhysicsBody()
        
        if(contact.bodyA.categoryBitMask == ColliderType.laserCategory.rawValue && contact.bodyB.categoryBitMask == ColliderType.fallingItemCategory.rawValue) {
            seventhBody = contact.bodyA
            eightBody = contact.bodyB
        } else if(contact.bodyB.categoryBitMask == ColliderType.laserCategory.rawValue && contact.bodyA.categoryBitMask == ColliderType.fallingItemCategory.rawValue){
            seventhBody = contact.bodyB
            eightBody = contact.bodyA
        }
        
        //collision between falling items and barrier block
        var ninthBody = SKPhysicsBody()
        var tenthBody = SKPhysicsBody()
        
        if(contact.bodyA.categoryBitMask == ColliderType.barrierBlockCategory.rawValue && contact.bodyB.categoryBitMask == ColliderType.fallingItemCategory.rawValue) {
            ninthBody = contact.bodyA
            tenthBody = contact.bodyB
        } else if(contact.bodyB.categoryBitMask == ColliderType.barrierBlockCategory.rawValue && contact.bodyA.categoryBitMask == ColliderType.fallingItemCategory.rawValue) {
            ninthBody = contact.bodyB
            tenthBody = contact.bodyA
        }

        var fallingItemIterator = 0
        while(fallingItemIterator < fallingItems.count) {
            if(firstBody.node == fallingItems[fallingItemIterator] && firstBody.node?.name == "red" && secondBody.node == characterCollisionObject) {
                fallingItems[fallingItemIterator].removeFromParent()
                fallingItems.remove(at: fallingItemIterator)
                fallingItemIterator = fallingItemIterator - 1
                //CHANGE TO CLOUDCURRENCYTHISGAME + 1 WHEN DONE TESTING
                cloudCurrencyThisGame = cloudCurrencyThisGame + 5000
                pointsThisGame = pointsThisGame + 100
                totalPoints = totalPoints + 100
                redItemsCaught = redItemsCaught + 1
                totalItemsCaught = totalItemsCaught + 1
                cloudCurrencyLabel.text = "Clouds: \(cloudCurrencyThisGame)"
                pointsLabel.text = "Score: \(pointsThisGame)"
            } else if(firstBody.node == fallingItems[fallingItemIterator] && firstBody.node?.name == "green" && secondBody.node == characterCollisionObject) {
                fallingItems[fallingItemIterator].removeFromParent()
                fallingItems.remove(at: fallingItemIterator)
                fallingItemIterator = fallingItemIterator - 1
                cloudCurrencyThisGame = cloudCurrencyThisGame + 10
                pointsThisGame = pointsThisGame + 250
                totalPoints = totalPoints + 250
                greenItemsCaught = greenItemsCaught + 1
                totalItemsCaught = totalItemsCaught + 1
                pointsLabel.text = "Score: \(pointsThisGame)"
                cloudCurrencyLabel.text = "Clouds: \(cloudCurrencyThisGame)"
            } else if(firstBody.node == fallingItems[fallingItemIterator] && firstBody.node?.name == "yellow" && secondBody.node == characterCollisionObject) {
                fallingItems[fallingItemIterator].removeFromParent()
                fallingItems.remove(at: fallingItemIterator)
                fallingItemIterator = fallingItemIterator - 1
                cloudCurrencyThisGame = cloudCurrencyThisGame + 20
                pointsThisGame = pointsThisGame + 500
                totalPoints = totalPoints + 500
                yellowItemsCaught = yellowItemsCaught + 1
                totalItemsCaught = totalItemsCaught + 1
                cloudCurrencyLabel.text = "Clouds: \(cloudCurrencyThisGame)"
                pointsLabel.text = "Score: \(pointsThisGame)"
            }
            fallingItemIterator = fallingItemIterator + 1
        }
        
        if(thirdBody.node == rayGun && fourthBody.node == characterCollisionObject || fourthBody.node == rayGun && thirdBody.node == characterCollisionObject) {
         rayGun.removeFromParent()
         var numLasers = 0
         var laserPosition = 0
         var numMaxLasers = 0
         var laserPositionOffset = 0
            if(rayGunUpgradeNumber == 0) {
                numMaxLasers = 20
                laserPositionOffset = 20
            } else if(rayGunUpgradeNumber == 1) {
                numMaxLasers = 30
                laserPositionOffset = 18
            } else if(rayGunUpgradeNumber == 2) {
                numMaxLasers = 40
                laserPositionOffset = 16
            } else if(rayGunUpgradeNumber == 3) {
                numMaxLasers = 50
                laserPositionOffset = 14
            } else if(rayGunUpgradeNumber == 4) {
                numMaxLasers = 60
                laserPositionOffset = 12
            } else if(rayGunUpgradeNumber == 5) {
                numMaxLasers = 70
                laserPositionOffset = 10
            }
         while(numLasers < numMaxLasers) {
         let laser = SKSpriteNode(texture: laserTexture)
            laser.physicsBody = SKPhysicsBody(texture: laserTexture, size: laserTexture.size())
         laser.physicsBody!.isDynamic = true
         laser.physicsBody!.usesPreciseCollisionDetection = true
         laser.physicsBody!.affectedByGravity = false
         laser.physicsBody!.velocity = CGVector.init(dx: 0, dy: 320)
         laser.physicsBody!.categoryBitMask = ColliderType.laserCategory.rawValue
         laser.physicsBody!.collisionBitMask = 0
         laser.physicsBody!.contactTestBitMask = ColliderType.fallingItemCategory.rawValue
         laser.position = CGPoint(x: (CGFloat)(-357 + laserPosition), y: self.size.height/2 * -1 + self.size.height/10)
         laser.size = CGSize(width: 5, height: 50)
         laser.zPosition = 2
         laser.name = "laser"
         worldNode.addChild(laser)
         lasers.append(laser)
            
         numLasers = numLasers + 1
         laserPosition = laserPosition + laserPositionOffset
            }
         }
        
        
        
        if(fifthBody.node == barrier && sixthBody.node == characterCollisionObject) {
            barrier.removeFromParent()
                barrierBlock = SKSpriteNode(texture: barrierBlockTexture)
                //barrierBlock.size = CGSize(width: self.size.width, height: 20)
                barrierBlock.physicsBody = SKPhysicsBody(texture: barrierBlockTexture, size: barrierBlockTexture.size())
                barrierBlock.physicsBody!.isDynamic = true
                barrierBlock.physicsBody!.usesPreciseCollisionDetection = true
                barrierBlock.physicsBody!.affectedByGravity = false
                barrierBlock.physicsBody!.categoryBitMask = ColliderType.barrierBlockCategory.rawValue
                barrierBlock.physicsBody!.collisionBitMask = 0
                barrierBlock.physicsBody!.contactTestBitMask = ColliderType.fallingItemCategory.rawValue
                barrierBlock.position = CGPoint(x: 0, y: -450)
                barrierBlock.zPosition = 3
                barrierBlock.name = "barrierBlock"
                worldNode.addChild(barrierBlock)
                //invalidate this if the back to home button is pressed
            if(barrierUpgradeNumber == 0) {
                removeBarrierTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.stopBarrier), userInfo: nil, repeats: false)
            } else if(barrierUpgradeNumber == 1) {
                removeBarrierTimer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(self.stopBarrier), userInfo: nil, repeats: false)
            } else if(barrierUpgradeNumber == 2) {
                removeBarrierTimer = Timer.scheduledTimer(timeInterval: 6.0, target: self, selector: #selector(self.stopBarrier), userInfo: nil, repeats: false)
            } else if(barrierUpgradeNumber == 3) {
                removeBarrierTimer = Timer.scheduledTimer(timeInterval: 8.0, target: self, selector: #selector(self.stopBarrier), userInfo: nil, repeats: false)
            } else if(barrierUpgradeNumber == 4) {
                removeBarrierTimer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(self.stopBarrier), userInfo: nil, repeats: false)
            } else if(barrierUpgradeNumber == 5) {
                removeBarrierTimer = Timer.scheduledTimer(timeInterval: 12.0, target: self, selector: #selector(self.stopBarrier), userInfo: nil, repeats: false)
            }
        }
        
        
        
        var iterator2 = 0
        while(iterator2 < fallingItems.count) {
            if(seventhBody.node?.name == "laser" && eightBody.node == fallingItems[iterator2] && eightBody.node?.name == "red") {
                fallingItems[iterator2].removeFromParent()
                cloudCurrencyThisGame = cloudCurrencyThisGame + 1
                pointsThisGame = pointsThisGame + 100
                totalPoints = totalPoints + 100
                redItemsCaught = redItemsCaught + 1
                totalItemsCaught = totalItemsCaught + 1
                cloudCurrencyLabel.text = "Clouds: \(cloudCurrencyThisGame)"
                pointsLabel.text = "Score: \(pointsThisGame)"
            } else if(seventhBody.node?.name == "laser" && eightBody.node == fallingItems[iterator2] && eightBody.node?.name == "green"){
                fallingItems[iterator2].removeFromParent()
                cloudCurrencyThisGame = cloudCurrencyThisGame + 10
                pointsThisGame = pointsThisGame + 250
                totalPoints = totalPoints + 250
                greenItemsCaught = greenItemsCaught + 1
                totalItemsCaught = totalItemsCaught + 1
                cloudCurrencyLabel.text = "Clouds: \(cloudCurrencyThisGame)"
                pointsLabel.text = "Score: \(pointsThisGame)"
            } else if(seventhBody.node?.name == "laser" && eightBody.node == fallingItems[iterator2] && eightBody.node?.name == "yellow"){
                fallingItems[iterator2].removeFromParent()
                cloudCurrencyThisGame = cloudCurrencyThisGame + 20
                pointsThisGame = pointsThisGame + 500
                totalPoints = totalPoints + 500
                yellowItemsCaught = yellowItemsCaught + 1
                totalItemsCaught = totalItemsCaught + 1
                cloudCurrencyLabel.text = "Clouds: \(cloudCurrencyThisGame)"
                pointsLabel.text = "Score: \(pointsThisGame)"
            }
            
            iterator2 = iterator2 + 1
        }
        
        
        
        var fallingItemIterator3 = 0
        while(fallingItemIterator3 < fallingItems.count) {
            //print("FallingItemIterator3: \(fallingItemIterator3)")
            //print("FallingItems.count: \(fallingItems.count)")
            if(ninthBody.node == fallingItems[fallingItemIterator3] && ninthBody.node?.name == "red" && tenthBody.node == barrierBlock || tenthBody.node == fallingItems[fallingItemIterator3] && tenthBody.node?.name == "red" && ninthBody.node == barrierBlock) {
                fallingItems[fallingItemIterator3].removeFromParent()
                fallingItems.remove(at: fallingItemIterator3)
                fallingItemIterator3 = fallingItemIterator3 - 1
                cloudCurrencyThisGame = cloudCurrencyThisGame + 1
                pointsThisGame = pointsThisGame + 100
                totalPoints = totalPoints + 100
                redItemsCaught = redItemsCaught + 1
                totalItemsCaught = totalItemsCaught + 1
                cloudCurrencyLabel.text = "Clouds: \(cloudCurrencyThisGame)"
                pointsLabel.text = "Score: \(pointsThisGame)"
            } else if(ninthBody.node == fallingItems[fallingItemIterator3] && ninthBody.node?.name == "green" && tenthBody.node == barrierBlock || tenthBody.node == fallingItems[fallingItemIterator3] && tenthBody.node?.name == "green" && ninthBody.node == barrierBlock) {
                fallingItems[fallingItemIterator3].removeFromParent()
                fallingItems.remove(at: fallingItemIterator3)
                fallingItemIterator3 = fallingItemIterator3 - 1
                cloudCurrencyThisGame = cloudCurrencyThisGame + 10
                pointsThisGame = pointsThisGame + 250
                totalPoints = totalPoints + 250
                greenItemsCaught = greenItemsCaught + 1
                totalItemsCaught = totalItemsCaught + 1
                cloudCurrencyLabel.text = "Clouds: \(cloudCurrencyThisGame)"
                pointsLabel.text = "Score: \(pointsThisGame)"
            } else if(ninthBody.node == fallingItems[fallingItemIterator3] && ninthBody.node?.name == "yellow" && tenthBody.node == barrierBlock || tenthBody.node == fallingItems[fallingItemIterator3] && tenthBody.node?.name == "yellow" && ninthBody.node == barrierBlock){
                fallingItems[fallingItemIterator3].removeFromParent()
                fallingItems.remove(at: fallingItemIterator3)
                fallingItemIterator3 = fallingItemIterator3 - 1
                cloudCurrencyThisGame = cloudCurrencyThisGame + 20
                pointsThisGame = pointsThisGame + 500
                totalPoints = totalPoints + 500
                yellowItemsCaught = yellowItemsCaught + 1
                totalItemsCaught = totalItemsCaught + 1
                cloudCurrencyLabel.text = "Clouds: \(cloudCurrencyThisGame)"
                pointsLabel.text = "Score: \(pointsThisGame)"
            }
            fallingItemIterator3 = fallingItemIterator3 + 1
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
    
    @objc func stopBarrier() {
        barrierBlock.removeFromParent()
    }
    
    @objc func spawnRayGunOrBarrier() {
        let randomXPosition = Int.random(in: 0...300)
        let randomItem = Int.random(in: 0...1)
        
        switch randomItem {
        case 0: rayGun = SKSpriteNode(texture: rayGunTexture)
                rayGun.physicsBody = SKPhysicsBody(texture: rayGunTexture, size: rayGunTexture.size())
                rayGun.physicsBody!.isDynamic = true
                rayGun.physicsBody!.usesPreciseCollisionDetection = true
                rayGun.physicsBody!.affectedByGravity = false
                rayGun.physicsBody!.velocity = CGVector.init(dx: 0, dy: -320)
                rayGun.physicsBody!.categoryBitMask = ColliderType.rayGunCategory.rawValue
                rayGun.physicsBody!.collisionBitMask = 0
                rayGun.physicsBody!.contactTestBitMask = ColliderType.characterCollisionObjectCategory.rawValue
                //rayGun.position = CGPoint(x: Int(randomXPosition) - 300, y: 600)
                rayGun.position = CGPoint(x: character.position.x + 85, y: 600)
                rayGun.zPosition = 2
                rayGun.name = "rayGun"
                worldNode.addChild(rayGun)
        default: barrier = SKSpriteNode(texture: barrierTexture)
                 barrier.physicsBody = SKPhysicsBody(texture: barrierTexture, size: barrierTexture.size())
                 barrier.physicsBody!.isDynamic = true
                 barrier.physicsBody!.usesPreciseCollisionDetection = true
                 barrier.physicsBody!.affectedByGravity = false
                 barrier.physicsBody!.velocity = CGVector.init(dx: 0, dy: -320)
                 barrier.physicsBody!.categoryBitMask = ColliderType.barrierCategory.rawValue
                 barrier.physicsBody!.collisionBitMask = 0
                 barrier.physicsBody!.contactTestBitMask = ColliderType.characterCollisionObjectCategory.rawValue
                 barrier.position = CGPoint(x: Int(randomXPosition) - 300, y: 600)
                 barrier.zPosition = 2
                 barrier.name = "barrier"
                 worldNode.addChild(barrier)
        }
    }
    
    @objc func spawnFallingItem() {
        //maybe change where the apples spawn
        let randomXPosition = Int.random(in: 0...300)
        let randomItem = Int.random(in: 0...5)
        
        switch randomItem {
        case 0:
            if(currentBackground == 0) {
                redItem = SKSpriteNode(texture: redAppleTexture)
                redItem.physicsBody = SKPhysicsBody(texture: redAppleTexture, size: redItem.size)
            } else if(currentBackground == 1) {
                redItem = SKSpriteNode(texture: redSnowflakeTexture)
                redItem.physicsBody = SKPhysicsBody(texture: redSnowflakeTexture, size: redItem.size)
            } else if(currentBackground == 2) {
                redItem = SKSpriteNode(texture: redBananaTexture)
                redItem.physicsBody = SKPhysicsBody(texture: redBananaTexture, size: redItem.size)
            } else if(currentBackground == 3) {
                redItem = SKSpriteNode(texture: redFishTexture)
                redItem.physicsBody = SKPhysicsBody(texture: redFishTexture, size: redItem.size)
            } else if(currentBackground == 4) {
                redItem = SKSpriteNode(texture: redAlienTexture)
                redItem.physicsBody = SKPhysicsBody(texture: redAlienTexture, size: redItem.size)
            }
                redItem.physicsBody!.isDynamic = true
                redItem.physicsBody!.usesPreciseCollisionDetection = true
                redItem.physicsBody!.affectedByGravity = false
                redItem.physicsBody!.velocity = CGVector.init(dx: 0, dy: -320)
                redItem.physicsBody!.categoryBitMask = ColliderType.fallingItemCategory.rawValue
                redItem.physicsBody!.collisionBitMask = 0
                redItem.physicsBody!.contactTestBitMask = ColliderType.characterCollisionObjectCategory.rawValue | ColliderType.laserCategory.rawValue | ColliderType.barrierBlockCategory.rawValue
                redItem.position = CGPoint(x: Int(randomXPosition) - 300, y: 600)
                redItem.zPosition = 2
                redItem.name = "red"
                worldNode.addChild(redItem)
                fallingItems.append(redItem)
        case 1:
            if(currentBackground == 0) {
            redItem = SKSpriteNode(texture: redAppleTexture)
            redItem.physicsBody = SKPhysicsBody(texture: redAppleTexture, size: redItem.size)
        } else if(currentBackground == 1) {
            redItem = SKSpriteNode(texture: redSnowflakeTexture)
            redItem.physicsBody = SKPhysicsBody(texture: redSnowflakeTexture, size: redItem.size)
        } else if(currentBackground == 2) {
            redItem = SKSpriteNode(texture: redBananaTexture)
            redItem.physicsBody = SKPhysicsBody(texture: redBananaTexture, size: redItem.size)
        } else if(currentBackground == 3) {
            redItem = SKSpriteNode(texture: redFishTexture)
            redItem.physicsBody = SKPhysicsBody(texture: redFishTexture, size: redItem.size)
        } else if(currentBackground == 4) {
            redItem = SKSpriteNode(texture: redAlienTexture)
            redItem.physicsBody = SKPhysicsBody(texture: redAlienTexture, size: redItem.size)
        }
                redItem.physicsBody!.isDynamic = true
                redItem.physicsBody!.usesPreciseCollisionDetection = true
                redItem.physicsBody!.affectedByGravity = false
                redItem.physicsBody!.velocity = CGVector.init(dx: 0, dy: -320)
                redItem.physicsBody!.categoryBitMask = ColliderType.fallingItemCategory.rawValue
                redItem.physicsBody!.collisionBitMask = 0
                redItem.physicsBody!.contactTestBitMask = ColliderType.characterCollisionObjectCategory.rawValue | ColliderType.laserCategory.rawValue | ColliderType.barrierBlockCategory.rawValue
                redItem.position = CGPoint(x: Int(randomXPosition) - 300, y: 600)
                redItem.zPosition = 2
                redItem.name = "red"
                worldNode.addChild(redItem)
                fallingItems.append(redItem)
        case 2:
            if(currentBackground == 0) {
            redItem = SKSpriteNode(texture: redAppleTexture)
            redItem.physicsBody = SKPhysicsBody(texture: redAppleTexture, size: redItem.size)
        } else if(currentBackground == 1) {
            redItem = SKSpriteNode(texture: redSnowflakeTexture)
            redItem.physicsBody = SKPhysicsBody(texture: redSnowflakeTexture, size: redItem.size)
        } else if(currentBackground == 2) {
            redItem = SKSpriteNode(texture: redBananaTexture)
            redItem.physicsBody = SKPhysicsBody(texture: redBananaTexture, size: redItem.size)
        } else if(currentBackground == 3) {
            redItem = SKSpriteNode(texture: redFishTexture)
            redItem.physicsBody = SKPhysicsBody(texture: redFishTexture, size: redItem.size)
        } else if(currentBackground == 4) {
            redItem = SKSpriteNode(texture: redAlienTexture)
            redItem.physicsBody = SKPhysicsBody(texture: redAlienTexture, size: redItem.size)
        }
                redItem.physicsBody!.isDynamic = true
                redItem.physicsBody!.usesPreciseCollisionDetection = true
                redItem.physicsBody!.affectedByGravity = false
                redItem.physicsBody!.velocity = CGVector.init(dx: 0, dy: -320)
                redItem.physicsBody!.categoryBitMask = ColliderType.fallingItemCategory.rawValue
                redItem.physicsBody!.collisionBitMask = 0
                redItem.physicsBody!.contactTestBitMask = ColliderType.characterCollisionObjectCategory.rawValue | ColliderType.laserCategory.rawValue | ColliderType.barrierBlockCategory.rawValue
                redItem.position = CGPoint(x: Int(randomXPosition) - 300, y: 600)
                redItem.zPosition = 2
                redItem.name = "red"
                worldNode.addChild(redItem)
                fallingItems.append(redItem)
        case 3:
            if(currentBackground == 0) {
            greenItem = SKSpriteNode(texture: greenAppleTexture)
            greenItem.physicsBody = SKPhysicsBody(texture: greenAppleTexture, size: greenItem.size)
        } else if(currentBackground == 1) {
            greenItem = SKSpriteNode(texture: greenSnowflakeTexture)
            greenItem.physicsBody = SKPhysicsBody(texture: greenSnowflakeTexture, size: greenItem.size)
        } else if(currentBackground == 2) {
            greenItem = SKSpriteNode(texture: greenBananaTexture)
            greenItem.physicsBody = SKPhysicsBody(texture: greenBananaTexture, size: greenItem.size)
        } else if(currentBackground == 3) {
            greenItem = SKSpriteNode(texture: greenFishTexture)
            greenItem.physicsBody = SKPhysicsBody(texture: greenFishTexture, size: greenItem.size)
        } else if(currentBackground == 4) {
            greenItem = SKSpriteNode(texture: greenAlienTexture)
            greenItem.physicsBody = SKPhysicsBody(texture: greenAlienTexture, size: greenItem.size)
        }
                greenItem.physicsBody!.isDynamic = true
                greenItem.physicsBody!.usesPreciseCollisionDetection = true
                greenItem.physicsBody!.affectedByGravity = false
                greenItem.physicsBody!.velocity = CGVector.init(dx: 0, dy: -320)
                greenItem.physicsBody!.categoryBitMask = ColliderType.fallingItemCategory.rawValue
                greenItem.physicsBody!.collisionBitMask = 0
                greenItem.physicsBody!.contactTestBitMask = ColliderType.characterCollisionObjectCategory.rawValue | ColliderType.laserCategory.rawValue | ColliderType.barrierBlockCategory.rawValue
                greenItem.position = CGPoint(x: Int(randomXPosition) - 300, y: 600)
                greenItem.zPosition = 2
                greenItem.name = "green"
                worldNode.addChild(greenItem)
                fallingItems.append(greenItem)
        case 4:
            if(currentBackground == 0) {
                greenItem = SKSpriteNode(texture: greenAppleTexture)
                greenItem.physicsBody = SKPhysicsBody(texture: greenAppleTexture, size: greenItem.size)
            } else if(currentBackground == 1) {
                greenItem = SKSpriteNode(texture: greenSnowflakeTexture)
                greenItem.physicsBody = SKPhysicsBody(texture: greenSnowflakeTexture, size: greenItem.size)
            } else if(currentBackground == 2) {
                greenItem = SKSpriteNode(texture: greenBananaTexture)
                greenItem.physicsBody = SKPhysicsBody(texture: greenBananaTexture, size: greenItem.size)
            } else if(currentBackground == 3) {
                greenItem = SKSpriteNode(texture: greenFishTexture)
                greenItem.physicsBody = SKPhysicsBody(texture: greenFishTexture, size: greenItem.size)
            } else if(currentBackground == 4) {
                greenItem = SKSpriteNode(texture: greenAlienTexture)
                greenItem.physicsBody = SKPhysicsBody(texture: greenAlienTexture, size: greenItem.size)
            }
                greenItem.physicsBody!.isDynamic = true
                greenItem.physicsBody!.usesPreciseCollisionDetection = true
                greenItem.physicsBody!.affectedByGravity = false
                greenItem.physicsBody!.velocity = CGVector.init(dx: 0, dy: -320)
                greenItem.physicsBody!.categoryBitMask = ColliderType.fallingItemCategory.rawValue
                greenItem.physicsBody!.collisionBitMask = 0
                greenItem.physicsBody!.contactTestBitMask = ColliderType.characterCollisionObjectCategory.rawValue | ColliderType.laserCategory.rawValue | ColliderType.barrierBlockCategory.rawValue
                greenItem.position = CGPoint(x: Int(randomXPosition) - 300, y: 600)
                greenItem.zPosition = 2
                greenItem.name = "green"
                worldNode.addChild(greenItem)
                fallingItems.append(greenItem)
        default:
            if(currentBackground == 0) {
            yellowItem = SKSpriteNode(texture: yellowAppleTexture)
            yellowItem.physicsBody = SKPhysicsBody(texture: yellowAppleTexture, size: yellowItem.size)
        } else if(currentBackground == 1) {
            yellowItem = SKSpriteNode(texture: yellowSnowflakeTexture)
            yellowItem.physicsBody = SKPhysicsBody(texture: yellowSnowflakeTexture, size: yellowItem.size)
        } else if(currentBackground == 2) {
            yellowItem = SKSpriteNode(texture: yellowBananaTexture)
            yellowItem.physicsBody = SKPhysicsBody(texture: yellowBananaTexture, size: yellowItem.size)
        } else if(currentBackground == 3) {
            yellowItem = SKSpriteNode(texture: yellowFishTexture)
            yellowItem.physicsBody = SKPhysicsBody(texture: yellowFishTexture, size: yellowItem.size)
        } else if(currentBackground == 4) {
            yellowItem = SKSpriteNode(texture: yellowAlienTexture)
            yellowItem.physicsBody = SKPhysicsBody(texture: yellowAlienTexture, size: yellowItem.size)
        }
                 yellowItem.physicsBody!.isDynamic = true
                 yellowItem.physicsBody!.usesPreciseCollisionDetection = true
                 yellowItem.physicsBody!.affectedByGravity = false
                 yellowItem.physicsBody!.velocity = CGVector.init(dx: 0, dy: -320)
                 yellowItem.physicsBody!.categoryBitMask = ColliderType.fallingItemCategory.rawValue
                 yellowItem.physicsBody!.collisionBitMask = 0
                 yellowItem.physicsBody!.contactTestBitMask = ColliderType.characterCollisionObjectCategory.rawValue | ColliderType.laserCategory.rawValue | ColliderType.barrierBlockCategory.rawValue
                 yellowItem.position = CGPoint(x: Int(randomXPosition) - 300, y: 600)
                 yellowItem.zPosition = 2
                 yellowItem.name = "yellow"
                 worldNode.addChild(yellowItem)
                 fallingItems.append(yellowItem)
        }
    }
    
    func checkLasersOOB() {
        var iterator = 0
        while(iterator < lasers.count) {
            if(lasers[iterator].position.y > 700) {
                lasers[iterator].removeFromParent()
                lasers.remove(at: iterator)
                iterator = iterator - 1
            }
            iterator = iterator + 1
        }
    }
    
    func checkFallingItemsOOB() {
        
        var iterator = 0
        while(iterator < fallingItems.count) {
            if(fallingItems[iterator].position.y < -800) {
                fallingItems[iterator].removeFromParent()
                fallingItems.remove(at: iterator)
                iterator = iterator - 1
                if(lives == 6) {
                    fallingItemsDropped = fallingItemsDropped + 1
                    heart6.removeFromParent()
                    lives = lives-1
                } else if(lives == 5) {
                    fallingItemsDropped = fallingItemsDropped + 1
                    heart5.removeFromParent()
                    lives = lives-1
                } else if(lives == 4){
                    fallingItemsDropped = fallingItemsDropped + 1
                    heart4.removeFromParent()
                    lives = lives-1
                } else if(lives == 3) {
                    fallingItemsDropped = fallingItemsDropped + 1
                    heart3.removeFromParent()
                    lives = lives-1
                } else if(lives == 2) {
                    fallingItemsDropped = fallingItemsDropped + 1
                    heart2.removeFromParent()
                    lives = lives-1
                } else if(lives == 1) {
                    fallingItemsDropped = fallingItemsDropped + 1
                    heart1.removeFromParent()
                    lives = lives-1
                    hasExtraLife = 0
                    hasIncreasedSpeed = 0
                    do {
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        let context = appDelegate.persistentContainer.viewContext
                        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SkyDropperTracking")
                        request.returnsObjectsAsFaults = false
                        let result = try context.fetch(request)
                        for data in result as! [NSManagedObject] {
                            totalClouds = (data.value(forKey: "totalClouds") as! UInt32)
                        }
                    } catch {
                        print("Failed")
                    }
                    totalClouds = totalClouds.advanced(by: cloudCurrencyThisGame)
                    let context = appDelegate.persistentContainer.viewContext
                    let entity = NSEntityDescription.entity(forEntityName: "SkyDropperTracking", in: context)
                    let newUser = NSManagedObject(entity: entity!, insertInto: context)
                    newUser.setValue(totalClouds, forKey: "totalClouds")
                    newUser.setValue(currentSkin, forKey: "currentSkin")
                    newUser.setValue(isLacrosseUnlocked, forKey: "isLacrosseUnlocked")
                    newUser.setValue(isAstronautUnlocked, forKey: "isAstronautUnlocked")
                    newUser.setValue(rayGunUpgradeNumber, forKey: "rayGunUpgradeTracking")
                    newUser.setValue(barrierUpgradeNumber, forKey: "barrierUpgradeTracking")
                    newUser.setValue(hasExtraLife, forKey: "hasExtraLife")
                    newUser.setValue(hasIncreasedSpeed, forKey: "hasIncreasedSpeed")
                    newUser.setValue(fallingItemsDropped, forKey: "totalFallingItemsDropped")
                    newUser.setValue(totalPoints, forKey: "totalPoints")
                    newUser.setValue(redItemsCaught, forKey: "redItemsCaught")
                    newUser.setValue(greenItemsCaught, forKey: "greenItemsCaught")
                    newUser.setValue(yellowItemsCaught, forKey: "yellowItemsCaught")
                    newUser.setValue(totalItemsCaught, forKey: "totalFallingItemsCaught")
                    newUser.setValue(isWinterUnlocked, forKey: "isWinterBGUnlocked")
                    newUser.setValue(isJungleUnlocked, forKey: "isJungleBGUnlocked")
                    newUser.setValue(isOceanUnlocked, forKey: "isOceanBGUnlocked")
                    newUser.setValue(isSpaceUnlocked, forKey: "isSpaceBGUnlocked")
                    newUser.setValue(currentBackground, forKey: "currentBackground")
                    do {
                        try context.save()
                    } catch {
                        print("Couldn't save the context!")
                    }
                    
                    //viewController?.dismiss(animated: false, completion: {
                    viewController?.performSegue(withIdentifier: "playToEnd", sender: nil)
                    //})
                }
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
        
        if(PlayViewController.GlobalPause.paused == true) {
            worldNode.isPaused = true
            physicsWorld.speed = 0
            /*removeBarrierTimer.invalidate()
            toggleFallingItemTimerCheck.invalidate()
            spawnFallingItemTimer.invalidate()
            spawnBarrierOrRayGunTimer.invalidate() */
        } else {
            worldNode.isPaused = false
            physicsWorld.speed = 1
            /*removeBarrierTimer.fire()
            toggleFallingItemTimerCheck.fire()
            spawnFallingItemTimer.fire()
            spawnBarrierOrRayGunTimer.fire() */
        }
        
        checkFallingItemsOOB()
        checkLasersOOB()
    }
}
