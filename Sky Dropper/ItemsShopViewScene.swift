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
    
    var rayGunButton = SKSpriteNode()
    var barrierButton = SKSpriteNode()
    var rayGunTexture = SKTexture(imageNamed: "RayGunButton")
    var barrierTexture = SKTexture(imageNamed: "BarrierButton")
    
    var rayGunUpgradeBar = SKSpriteNode()
    var barrierUpgradeBar = SKSpriteNode()
    var upgradeTexture = SKTexture(imageNamed: "UpgradeBar0")
    
    var topRectBuffer = SKShapeNode()
    
    let rayGunItemLabel = SKLabelNode()
    let barrierItemLabel = SKLabelNode()
    
    var cloudsCurrencyBar = SKSpriteNode()
    var cloudCurrencyBarTexture = SKTexture(imageNamed: "CloudsCurrencyBar")
    var clouds: UInt32 = 0
    let cloudsLabel = SKLabelNode()
    
    override func didMove(to view: SKView) {
        
        rayGunItemLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        rayGunItemLabel.text = "Ray Gun Upgrade"
        rayGunItemLabel.fontName = "Baskerville"
        rayGunItemLabel.fontSize = 75
        rayGunItemLabel.fontColor = .blue
        rayGunItemLabel.position = CGPoint(x: -160, y: self.size.height/4 + 130)
        rayGunItemLabel.zPosition = 2
        addChild(rayGunItemLabel)
        
        rayGunButton = SKSpriteNode(texture: rayGunTexture)
        rayGunButton.name = "rayGun"
        rayGunButton.size = CGSize(width: 250, height: 250)
        rayGunButton.position = CGPoint(x: 0, y: self.size.height/4 - 50)
        addChild(rayGunButton)
        
        rayGunUpgradeBar = SKSpriteNode(texture: upgradeTexture)
        rayGunUpgradeBar.name = "rayGunUpgrade0"
        rayGunUpgradeBar.size = CGSize(width: 375, height: 80)
        rayGunUpgradeBar.position = CGPoint(x: 0, y: self.size.height/4 - 250)
        addChild(rayGunUpgradeBar)
        
        barrierItemLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        barrierItemLabel.text = "Barrier Upgrade"
        barrierItemLabel.fontName = "Baskerville"
        barrierItemLabel.fontSize = 75
        barrierItemLabel.fontColor = .blue
        barrierItemLabel.position = CGPoint(x: -160, y: self.size.height/4 - 600 + 180)
        barrierItemLabel.zPosition = 2
        addChild(barrierItemLabel)
        
        barrierButton = SKSpriteNode(texture: barrierTexture)
        barrierButton.name = "barrier"
        barrierButton.size = CGSize(width: 250, height: 250)
        barrierButton.position = CGPoint(x: 0, y: self.size.height/4 - 600)
        addChild(barrierButton)
        
        barrierUpgradeBar = SKSpriteNode(texture: upgradeTexture)
        barrierUpgradeBar.name = "barrierUpgrade0"
        barrierUpgradeBar.size = CGSize(width: 375, height: 80)
        barrierUpgradeBar.position = CGPoint(x: 0, y: self.size.height/4 - 800)
        addChild(barrierUpgradeBar)
        
        topRectBuffer = SKShapeNode(rectOf: CGSize(width: self.size.width, height: self.size.height/16), cornerRadius: 2)
        topRectBuffer.fillColor = .orange
        topRectBuffer.position = CGPoint(x: 0, y: self.size.height/2)
        addChild(topRectBuffer)
        
        do {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SkyDropperTracking")
            request.returnsObjectsAsFaults = false
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                clouds = (data.value(forKey: "totalClouds") as! UInt32)
            }
        } catch {
            print("Failed")
        }
        
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
        /*for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "rayGun" {
               //what happens when the rayGun button is touched
            }
        } */
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

