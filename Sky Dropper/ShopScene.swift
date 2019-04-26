//
//  ShopScene.swift
//  Sky Dropper
//
//  Created by Alexander Hall on 2/3/19.
//  Copyright © 2019 Hall Inc. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreData

class ShopScene: SKScene {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var extraLifeUpgrade = SKSpriteNode()
    var extraLifeUpgradeTexture = SKTexture(imageNamed: "ExtraLifeOnStartOfGameButtonLocked")
    var increasedSpeedUpgrade = SKSpriteNode()
    var increasedSpeedUpgradeTexture = SKTexture(imageNamed: "IncreasedSpeedNextGameLockedButton")
    
    let extraLifeUnlockedTexture = SKTexture(imageNamed: "ExtraLifeNextGame")
    let increasedSpeedUnlockedTexture = SKTexture(imageNamed: "IncreasedSpeedNextGameButton")
    
    var topRectBuffer = SKShapeNode()
    
    var cloudsCurrencyBar = SKSpriteNode()
    var cloudCurrencyBarTexture = SKTexture(imageNamed: "CloudsCurrencyBar")
    var clouds: UInt32 = 0
    let cloudsLabel = SKLabelNode()
    
    var isAstronautUnlocked: UInt32 = 0
    var isLacrosseUnlocked: UInt32 = 0
    //0 = default
    //1 = astronaut
    //2 = lacrosse
    var currentSkin: UInt32 = 0
    var rayGunUpgradeNumber: UInt32 = 0
    var barrierUpgradeNumber: UInt32 = 0
    var hasIncreasedSpeed: UInt32 = 0
    var hasExtraLife: UInt32 = 0
    
    let extraLifeCostLabel = SKLabelNode()
    let increasedSpeedCostLabel = SKLabelNode()
    
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
    
    
    override func didMove(to view: SKView) {
        
        do {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SkyDropperTracking")
            request.returnsObjectsAsFaults = false
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                clouds = (data.value(forKey: "totalClouds") as! UInt32)
                isAstronautUnlocked = (data.value(forKey: "isAstronautUnlocked") as! UInt32)
                isLacrosseUnlocked = (data.value(forKey: "isLacrosseUnlocked") as! UInt32)
                currentSkin = (data.value(forKey: "currentSkin") as! UInt32)
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
            }
        } catch {
            print("Failed")
        }
        
        print("Upgrades - isWinterUnlocked: \(isWinterUnlocked)")
        print("Upgrades - isJungleUnlocked: \(isJungleUnlocked)")
        print("Upgrades - isOceanUnlocked: \(isOceanUnlocked)")
        print("Upgrades - isSpaceUnlocked: \(isSpaceUnlocked)")
        print("Upgrades - current background: \(currentBackground)")
        
        topRectBuffer = SKShapeNode(rectOf: CGSize(width: self.size.width, height: self.size.height/16), cornerRadius: 2)
        topRectBuffer.fillColor = .orange
        topRectBuffer.position = CGPoint(x: 0, y: self.size.height/2)
        addChild(topRectBuffer)
        
        if(hasExtraLife == 0) {
        extraLifeCostLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        extraLifeCostLabel.text = "Cost: 150"
        extraLifeCostLabel.fontName = "Baskerville"
        extraLifeCostLabel.fontSize = 70
        extraLifeCostLabel.fontColor = .blue
        extraLifeCostLabel.position = CGPoint(x: -125, y: self.size.height/4 - 80 - 225)
        extraLifeCostLabel.zPosition = 3
        addChild(extraLifeCostLabel)
        }
        
        if(hasExtraLife == 0) {
            extraLifeUpgrade = SKSpriteNode(texture: extraLifeUpgradeTexture)
        } else if(hasExtraLife == 1) {
            extraLifeUpgrade = SKSpriteNode(texture: extraLifeUnlockedTexture)
        }
        extraLifeUpgrade.name = "extraLifeUpgrade"
        extraLifeUpgrade.size = CGSize(width: self.size.width/1.25, height: self.size.height/4)
        extraLifeUpgrade.position = CGPoint(x: 0, y: self.size.height/4 - 80)
        addChild(extraLifeUpgrade)

        if(hasIncreasedSpeed == 0) {
        increasedSpeedCostLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        increasedSpeedCostLabel.text = "Cost: 150"
        increasedSpeedCostLabel.fontName = "Baskerville"
        increasedSpeedCostLabel.fontSize = 70
        increasedSpeedCostLabel.fontColor = .blue
        increasedSpeedCostLabel.position = CGPoint(x: -125, y: self.size.height/4 - 320 - self.size.height/4 - 225)
        increasedSpeedCostLabel.zPosition = 3
        addChild(increasedSpeedCostLabel)
        }
        
        if(hasIncreasedSpeed == 0) {
        increasedSpeedUpgrade = SKSpriteNode(texture: increasedSpeedUpgradeTexture)
        } else if(hasIncreasedSpeed == 1) {
           increasedSpeedUpgrade = SKSpriteNode(texture: increasedSpeedUnlockedTexture)
        }
        increasedSpeedUpgrade.name = "increasedSpeed"
        increasedSpeedUpgrade.size = CGSize(width: self.size.width/1.25, height: self.size.height/4)
        increasedSpeedUpgrade.position = CGPoint(x: 0, y: self.size.height/4 - 320 - self.size.height/4)
        addChild(increasedSpeedUpgrade)
        
        cloudsLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        cloudsLabel.text = "\(clouds)"
        cloudsLabel.fontName = "Baskerville"
        cloudsLabel.fontSize = 55
        cloudsLabel.fontColor = .black
        cloudsLabel.position = CGPoint(x: -60, y: -660)
        cloudsLabel.zPosition = 3
        addChild(cloudsLabel)
        
        cloudsCurrencyBar = SKSpriteNode(texture: cloudCurrencyBarTexture)
        cloudsCurrencyBar.size = CGSize(width: 530, height: 120)
        cloudsCurrencyBar.position = CGPoint(x: -110, y: -640)
        cloudsCurrencyBar.zPosition = 2
        addChild(cloudsCurrencyBar)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            let positionInScene = touch.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            if let name = touchedNode.name
            {
                if(name == "extraLifeUpgrade" && hasExtraLife == 0 && clouds >= 150) {
                    clouds = clouds - 150
                    hasExtraLife = 1
                    cloudsLabel.text = "\(clouds)"
                    let context = appDelegate.persistentContainer.viewContext
                    let entity = NSEntityDescription.entity(forEntityName: "SkyDropperTracking", in: context)
                    let newUser = NSManagedObject(entity: entity!, insertInto: context)
                    newUser.setValue(currentSkin, forKey: "currentSkin")
                    newUser.setValue(isLacrosseUnlocked, forKey: "isLacrosseUnlocked")
                    newUser.setValue(isAstronautUnlocked, forKey: "isAstronautUnlocked")
                    newUser.setValue(clouds, forKey: "totalClouds")
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
                    extraLifeUpgrade.texture = extraLifeUnlockedTexture
                    extraLifeCostLabel.removeFromParent()
                }
                if(name == "increasedSpeed" && hasIncreasedSpeed == 0 && clouds >= 150) {
                    clouds = clouds - 150
                    hasIncreasedSpeed = 1
                    cloudsLabel.text = "\(clouds)"
                    let context = appDelegate.persistentContainer.viewContext
                    let entity = NSEntityDescription.entity(forEntityName: "SkyDropperTracking", in: context)
                    let newUser = NSManagedObject(entity: entity!, insertInto: context)
                    newUser.setValue(currentSkin, forKey: "currentSkin")
                    newUser.setValue(isLacrosseUnlocked, forKey: "isLacrosseUnlocked")
                    newUser.setValue(isAstronautUnlocked, forKey: "isAstronautUnlocked")
                    newUser.setValue(clouds, forKey: "totalClouds")
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
                    increasedSpeedUpgrade.texture = increasedSpeedUnlockedTexture
                    increasedSpeedCostLabel.removeFromParent()
                }
            }
        }
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
