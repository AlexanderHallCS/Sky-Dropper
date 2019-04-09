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
    
    var extraLifeUpgrade = SKSpriteNode()
    var extraLifeUpgradeTexture = SKTexture(imageNamed: "ExtraLifeOnStartOfGameButtonLocked")
    var increasedSpeedUpgrade = SKSpriteNode()
    var increasedSpeedUpgradeTexture = SKTexture(imageNamed: "IncreasedSpeedNextGameLockedButton")
    
    var topRectBuffer = SKShapeNode()
    
    var cloudsCurrencyBar = SKSpriteNode()
    var cloudCurrencyBarTexture = SKTexture(imageNamed: "CloudsCurrencyBar")
    var clouds: UInt32 = 0
    let cloudsLabel = SKLabelNode()
    
    override func didMove(to view: SKView) {
        topRectBuffer = SKShapeNode(rectOf: CGSize(width: self.size.width, height: self.size.height/16), cornerRadius: 2)
        topRectBuffer.fillColor = .orange
        topRectBuffer.position = CGPoint(x: 0, y: self.size.height/2)
        addChild(topRectBuffer)
        
        extraLifeUpgrade = SKSpriteNode(texture: extraLifeUpgradeTexture)
        extraLifeUpgrade.name = "extraLifeUpgrade"
        extraLifeUpgrade.size = CGSize(width: self.size.width/1.25, height: self.size.height/4)
        extraLifeUpgrade.position = CGPoint(x: 0, y: self.size.height/4 - 220)
        addChild(extraLifeUpgrade)

        increasedSpeedUpgrade = SKSpriteNode(texture: increasedSpeedUpgradeTexture)
        increasedSpeedUpgrade.name = "increasedSpeed"
        increasedSpeedUpgrade.size = CGSize(width: self.size.width/1.25, height: self.size.height/4)
        increasedSpeedUpgrade.position = CGPoint(x: 0, y: self.size.height/4 - 260 - self.size.height/4)
        addChild(increasedSpeedUpgrade)
        
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
