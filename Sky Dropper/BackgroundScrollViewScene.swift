//
//  BackgroundScrollViewScene.swift
//  Sky Dropper
//
//  Created by Alexander Hall on 2/22/19.
//  Copyright © 2019 Hall Inc. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreData

class BackgroundScrollViewScene: SKScene {
    
    var topRectBuffer = SKShapeNode()
    
    var scrollingNode = SKNode()
    var startY: CGFloat = 0.0
    var lastY: CGFloat = 0.0
    
    var defaultBGButton = SKSpriteNode()
    var defaultBGButtonTexture = SKTexture(imageNamed: "StartingBGShopButton")
    
    var winterBGButton = SKSpriteNode()
    var winterBGButtonTexture = SKTexture(imageNamed: "WinterBGShopButton")
    
    var jungleBGButton = SKSpriteNode()
    var jungleBGButtonTexture = SKTexture(imageNamed: "JungleBGShopButton")
    
    var oceanBGButton = SKSpriteNode()
    var oceanBGButtonTexture = SKTexture(imageNamed: "OceanBGShopButton")
    
    var spaceBGButton = SKSpriteNode()
    var spaceBGButtonTexture = SKTexture(imageNamed: "SpaceBGShopButton")
    
    var defaultBGLabel = SKLabelNode()
    var winterBGLabel = SKLabelNode()
    var winterBGCostLabel = SKLabelNode()
    var jungleBGLabel = SKLabelNode()
    var jungleBGCostLabel = SKLabelNode()
    var oceanBGLabel = SKLabelNode()
    var oceanBGCostLabel = SKLabelNode()
    var spaceBGLabel = SKLabelNode()
    var spaceBGCostLabel = SKLabelNode()
    
    var clouds: UInt32 = 0
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
    
    var cloudsCurrencyBar = SKSpriteNode()
    var cloudCurrencyBarTexture = SKTexture(imageNamed: "CloudsCurrencyBar")
    var cloudsLabel = SKLabelNode()
    
    var fallingItemsDropped: UInt32 = 0
    var redItemsCaught: UInt32 = 0
    var greenItemsCaught: UInt32 = 0
    var yellowItemsCaught: UInt32 = 0
    var totalItemsCaught: UInt32 = 0
    var totalPoints: UInt32 = 0
    
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
            }
        } catch {
            print("Failed")
        }
        
        scrollingNode.position = CGPoint(x: 0, y: 0)
        self.addChild(scrollingNode)
        
        topRectBuffer = SKShapeNode(rectOf: CGSize(width: self.size.width, height: self.size.height/16), cornerRadius: 2)
        topRectBuffer.fillColor = .orange
        topRectBuffer.position = CGPoint(x: 0, y: self.size.height/2)
        topRectBuffer.zPosition = 2
        addChild(topRectBuffer)
        
        defaultBGLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        defaultBGLabel.text = "Default Farm Background"
        defaultBGLabel.fontName = "Baskerville"
        defaultBGLabel.fontSize = 30
        defaultBGLabel.fontColor = .blue
        defaultBGLabel.position = CGPoint(x: -135, y: self.size.height/4 + 140)
        defaultBGLabel.zPosition = 3
        scrollingNode.addChild(defaultBGLabel)
        
        defaultBGButton = SKSpriteNode(texture: defaultBGButtonTexture)
        defaultBGButton.position = CGPoint(x: 0, y: self.size.height/4)
        defaultBGButton.size = CGSize(width: 400, height: 250)
        scrollingNode.addChild(defaultBGButton)
        
        winterBGLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        winterBGLabel.text = "Winter Background"
        winterBGLabel.fontName = "Baskerville"
        winterBGLabel.fontSize = 30
        winterBGLabel.fontColor = .blue
        winterBGLabel.position = CGPoint(x: -125, y: self.size.height/4 - 250)
        winterBGLabel.zPosition = 3
        scrollingNode.addChild(winterBGLabel)
        
        winterBGButton = SKSpriteNode(texture: winterBGButtonTexture)
        winterBGButton.position = CGPoint(x: 0, y: self.size.height/4 - 380)
        winterBGButton.size = CGSize(width: 400, height: 250)
        scrollingNode.addChild(winterBGButton)
        
        winterBGCostLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        winterBGCostLabel.text = "Cost: 500"
        winterBGCostLabel.fontName = "Baskerville"
        winterBGCostLabel.fontSize = 30
        winterBGCostLabel.fontColor = .blue
        winterBGCostLabel.position = CGPoint(x: -55, y: self.size.height/4 - 270 - 255)
        winterBGCostLabel.zPosition = 3
        scrollingNode.addChild(winterBGCostLabel)
        
        jungleBGLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        jungleBGLabel.text = "Jungle Background"
        jungleBGLabel.fontName = "Baskerville"
        jungleBGLabel.fontSize = 30
        jungleBGLabel.fontColor = .blue
        jungleBGLabel.position = CGPoint(x: -125, y: self.size.height/4 - 650)
        jungleBGLabel.zPosition = 3
        scrollingNode.addChild(jungleBGLabel)
        
        jungleBGButton = SKSpriteNode(texture: jungleBGButtonTexture)
        jungleBGButton.position = CGPoint(x: 0, y: self.size.height/4 - 780)
        jungleBGButton.size = CGSize(width: 400, height: 250)
        scrollingNode.addChild(jungleBGButton)
        
        jungleBGCostLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        jungleBGCostLabel.text = "Cost: 500"
        jungleBGCostLabel.fontName = "Baskerville"
        jungleBGCostLabel.fontSize = 30
        jungleBGCostLabel.fontColor = .blue
        jungleBGCostLabel.position = CGPoint(x: -55, y: self.size.height/4 - 670 - 255)
        jungleBGCostLabel.zPosition = 3
        scrollingNode.addChild(jungleBGCostLabel)
        
        oceanBGLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        oceanBGLabel.text = "Ocean Background"
        oceanBGLabel.fontName = "Baskerville"
        oceanBGLabel.fontSize = 30
        oceanBGLabel.fontColor = .blue
        oceanBGLabel.position = CGPoint(x: -125, y: self.size.height/4 - 1050)
        oceanBGLabel.zPosition = 3
        scrollingNode.addChild(oceanBGLabel)
        
        oceanBGButton = SKSpriteNode(texture: oceanBGButtonTexture)
        oceanBGButton.position = CGPoint(x: 0, y: self.size.height/4 - 1180)
        oceanBGButton.size = CGSize(width: 400, height: 250)
        scrollingNode.addChild(oceanBGButton)
        
        oceanBGCostLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        oceanBGCostLabel.text = "Cost: 500"
        oceanBGCostLabel.fontName = "Baskerville"
        oceanBGCostLabel.fontSize = 30
        oceanBGCostLabel.fontColor = .blue
        oceanBGCostLabel.position = CGPoint(x: -55, y: self.size.height/4 - 1070 - 255)
        oceanBGCostLabel.zPosition = 3
        scrollingNode.addChild(oceanBGCostLabel)
        
        spaceBGLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        spaceBGLabel.text = "Space Background"
        spaceBGLabel.fontName = "Baskerville"
        spaceBGLabel.fontSize = 30
        spaceBGLabel.fontColor = .blue
        spaceBGLabel.position = CGPoint(x: -105, y: self.size.height/4 - 1450)
        spaceBGLabel.zPosition = 3
        scrollingNode.addChild(spaceBGLabel)
        
        spaceBGButton = SKSpriteNode(texture: spaceBGButtonTexture)
        spaceBGButton.position = CGPoint(x: 0, y: self.size.height/4 - 1580)
        spaceBGButton.size = CGSize(width: 400, height: 250)
        scrollingNode.addChild(spaceBGButton)
        
        spaceBGCostLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        spaceBGCostLabel.text = "Cost: 500"
        spaceBGCostLabel.fontName = "Baskerville"
        spaceBGCostLabel.fontSize = 30
        spaceBGCostLabel.fontColor = .blue
        spaceBGCostLabel.position = CGPoint(x: -55, y: self.size.height/4 - 1470 - 255)
        spaceBGCostLabel.zPosition = 3
        scrollingNode.addChild(spaceBGCostLabel)
        
        cloudsCurrencyBar = SKSpriteNode(texture: cloudCurrencyBarTexture)
        cloudsCurrencyBar.size = CGSize(width: 530, height: 120)
        //cloudsCurrencyBar.position = CGPoint(x: -105, y: -700)
        cloudsCurrencyBar.position = CGPoint(x: -110, y: -1430)
        cloudsCurrencyBar.zPosition = 3
        scrollingNode.addChild(cloudsCurrencyBar)
        
        cloudsLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        cloudsLabel.text = "\(clouds)"
        cloudsLabel.fontName = "Baskerville"
        cloudsLabel.fontSize = 55
        cloudsLabel.fontColor = .black
        cloudsLabel.position = CGPoint(x: -60, y: -1450)
        cloudsLabel.zPosition = 4
        scrollingNode.addChild(cloudsLabel)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // store the starting position of the touch
        if let touch = touches.first {
            let location = touch.location(in: self)
            startY = location.y
            lastY = location.y
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
        // set the new location of touch
            let currentY = location.y
        
        // Set Top and Bottom scroll distances, measured in screenlengths
            let topLimit:CGFloat = 0.0
            let bottomLimit:CGFloat = 0.6
        
        // Set scrolling speed - Higher number is faster speed
            let scrollSpeed:CGFloat = 1.0
        
        // calculate distance moved since last touch registered and add it to current position
            let newY = scrollingNode.position.y + ((currentY - lastY)*scrollSpeed)
        
        // perform checks to see if new position will be over the limits, otherwise set as new position
        if newY < self.size.height*(-topLimit) {
            scrollingNode.position = CGPoint(x: scrollingNode.position.x, y: self.size.height*(-topLimit))
        }
        else if newY > self.size.height*bottomLimit {
            scrollingNode.position = CGPoint(x: scrollingNode.position.x, y: self.size.height*bottomLimit)
        }
        else {
            scrollingNode.position = CGPoint(x: scrollingNode.position.x, y: newY)
            }
        // Set new last location for next time
        lastY = currentY
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

