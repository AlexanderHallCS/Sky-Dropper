//
//  ItemsShopViewScene.swift
//  Sky Dropper
//
//  Created by Alexander Hall on 2/26/19.
//  Copyright © 2019 Hall Inc. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreData

class ItemsShopViewScene: SKScene {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var rayGunButton = SKSpriteNode()
    var barrierButton = SKSpriteNode()
    var rayGunTexture = SKTexture(imageNamed: "RayGunButton")
    var barrierTexture = SKTexture(imageNamed: "BarrierButton")
    
    var rayGunUpgradeBar = SKSpriteNode()
    var barrierUpgradeBar = SKSpriteNode()
    var upgradeTexture0 = SKTexture(imageNamed: "UpgradeBar0")
    var upgradeTexture1 = SKTexture(imageNamed: "UpgradeBar1")
    var upgradeTexture2 = SKTexture(imageNamed: "UpgradeBar2")
    var upgradeTexture3 = SKTexture(imageNamed: "UpgradeBar3")
    var upgradeTexture4 = SKTexture(imageNamed: "UpgradeBar4")
    var upgradeTexture5 = SKTexture(imageNamed: "UpgradeBar5")
 
    var topRectBuffer = SKShapeNode()
    
    let rayGunItemLabel = SKLabelNode()
    let barrierItemLabel = SKLabelNode()
    let rayGunCurrencyLabel = SKLabelNode()
    let barrierCurrencyLabel = SKLabelNode()
    
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
            }
        } catch {
            print("Failed")
        }
        
        rayGunItemLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        rayGunItemLabel.text = "Ray Gun Upgrade"
        rayGunItemLabel.fontName = "Baskerville"
        rayGunItemLabel.fontSize = 75
        rayGunItemLabel.fontColor = .blue
        rayGunItemLabel.position = CGPoint(x: -230, y: self.size.height/4 + 130)
        rayGunItemLabel.zPosition = 2
        addChild(rayGunItemLabel)
        
        rayGunButton = SKSpriteNode(texture: rayGunTexture)
        rayGunButton.name = "rayGun"
        rayGunButton.size = CGSize(width: 250, height: 250)
        rayGunButton.position = CGPoint(x: 0, y: self.size.height/4 - 50)
        addChild(rayGunButton)
        
        if(rayGunUpgradeNumber == 0) {
            rayGunUpgradeBar = SKSpriteNode(texture: upgradeTexture0)
        } else if(rayGunUpgradeNumber == 1) {
            rayGunUpgradeBar = SKSpriteNode(texture: upgradeTexture1)
        } else if(rayGunUpgradeNumber == 2) {
            rayGunUpgradeBar = SKSpriteNode(texture: upgradeTexture2)
        } else if(rayGunUpgradeNumber == 3) {
            rayGunUpgradeBar = SKSpriteNode(texture: upgradeTexture3)
        } else if(rayGunUpgradeNumber == 4) {
            rayGunUpgradeBar = SKSpriteNode(texture: upgradeTexture4)
        } else if(rayGunUpgradeNumber == 5) {
            rayGunUpgradeBar = SKSpriteNode(texture: upgradeTexture5)
        }
        rayGunUpgradeBar.name = "rayGunUpgrade"
        rayGunUpgradeBar.size = CGSize(width: 375, height: 80)
        rayGunUpgradeBar.position = CGPoint(x: 0, y: self.size.height/4 - 240)
        addChild(rayGunUpgradeBar)
        
        if(rayGunUpgradeNumber != 5) {
        rayGunCurrencyLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        rayGunCurrencyLabel.text = "Cost: 350"
        rayGunCurrencyLabel.fontName = "Baskerville"
        rayGunCurrencyLabel.fontSize = 65
        rayGunCurrencyLabel.fontColor = .blue
        rayGunCurrencyLabel.position = CGPoint(x: -120, y: self.size.height/4 - 340)
        rayGunCurrencyLabel.zPosition = 2
        addChild(rayGunCurrencyLabel)
        }
        
        barrierItemLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        barrierItemLabel.text = "Barrier Upgrade"
        barrierItemLabel.fontName = "Baskerville"
        barrierItemLabel.fontSize = 75
        barrierItemLabel.fontColor = .blue
        barrierItemLabel.position = CGPoint(x: -230, y: self.size.height/4 - 600 + 180)
        barrierItemLabel.zPosition = 2
        addChild(barrierItemLabel)
        
        barrierButton = SKSpriteNode(texture: barrierTexture)
        barrierButton.name = "barrier"
        barrierButton.size = CGSize(width: 250, height: 250)
        barrierButton.position = CGPoint(x: 0, y: self.size.height/4 - 600)
        addChild(barrierButton)
        
        barrierUpgradeBar = SKSpriteNode(texture: upgradeTexture0)
        barrierUpgradeBar.name = "barrierUpgrade"
        barrierUpgradeBar.size = CGSize(width: 375, height: 80)
        barrierUpgradeBar.position = CGPoint(x: 0, y: self.size.height/4 - 790)
        addChild(barrierUpgradeBar)
        
        barrierCurrencyLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        barrierCurrencyLabel.text = "Cost: 350"
        barrierCurrencyLabel.fontName = "Baskerville"
        barrierCurrencyLabel.fontSize = 65
        barrierCurrencyLabel.fontColor = .blue
        barrierCurrencyLabel.position = CGPoint(x: -120, y: self.size.height/4 - 890)
        barrierCurrencyLabel.zPosition = 2
        addChild(barrierCurrencyLabel)
        
        topRectBuffer = SKShapeNode(rectOf: CGSize(width: self.size.width, height: self.size.height/16), cornerRadius: 2)
        topRectBuffer.fillColor = .orange
        topRectBuffer.position = CGPoint(x: 0, y: self.size.height/2)
        addChild(topRectBuffer)
        
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
                if(name == "rayGun" && rayGunUpgradeNumber != 5 && clouds >= 350)
                {
                    clouds = clouds - 350
                    if(rayGunUpgradeNumber == 0) {
                        rayGunUpgradeNumber = rayGunUpgradeNumber + 1
                        rayGunUpgradeBar.texture = upgradeTexture1
                    } else if(rayGunUpgradeNumber == 1) {
                        rayGunUpgradeNumber = rayGunUpgradeNumber + 1
                        rayGunUpgradeBar.texture = upgradeTexture2
                    } else if(rayGunUpgradeNumber == 2) {
                        rayGunUpgradeNumber = rayGunUpgradeNumber + 1
                        rayGunUpgradeBar.texture = upgradeTexture3
                    } else if(rayGunUpgradeNumber == 3) {
                        rayGunUpgradeNumber = rayGunUpgradeNumber + 1
                        rayGunUpgradeBar.texture = upgradeTexture4
                    } else if(rayGunUpgradeNumber == 4) {
                        rayGunUpgradeNumber = rayGunUpgradeNumber + 1
                        rayGunUpgradeBar.texture = upgradeTexture5
                        rayGunCurrencyLabel.removeFromParent()
                    }
                    let context = appDelegate.persistentContainer.viewContext
                    let entity = NSEntityDescription.entity(forEntityName: "SkyDropperTracking", in: context)
                    let newUser = NSManagedObject(entity: entity!, insertInto: context)
                    newUser.setValue(currentSkin, forKey: "currentSkin")
                    newUser.setValue(isLacrosseUnlocked, forKey: "isLacrosseUnlocked")
                    newUser.setValue(isAstronautUnlocked, forKey: "isAstronautUnlocked")
                    newUser.setValue(clouds, forKey: "totalClouds")
                    newUser.setValue(rayGunUpgradeNumber, forKey: "rayGunUpgradeTracking")
                    newUser.setValue(barrierUpgradeNumber, forKey: "barrierUpgradeTracking")
                    do {
                        try context.save()
                    } catch {
                        print("Couldn't save the context!")
                    }
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

