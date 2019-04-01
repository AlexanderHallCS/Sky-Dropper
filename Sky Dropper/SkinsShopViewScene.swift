//
//  SkinsShopViewScene.swift
//  Sky Dropper
//
//  Created by Alexander Hall on 2/26/19.
//  Copyright © 2019 Hall Inc. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreData

class SkinsShopViewScene: SKScene {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var defaultSkinButton = SKSpriteNode()
    var defaultSkinButtonTexture = SKTexture(imageNamed: "DefaultSkinButton")
    var astronautSkinButton = SKSpriteNode()
    var astronautSkinButtonTexture = SKTexture(imageNamed: "AstronautSkinButton")
    var lacrossePlayerSkinButton = SKSpriteNode()
    var lacrossePlayerSkinButtonTexture = SKTexture(imageNamed: "LacrossPlayerSkinButton")
    
    var unselectedBoxTexture = SKTexture(imageNamed: "UnselectedCheckBox")
    var selectedBoxTexture = SKTexture(imageNamed: "SelectedCheckBox")
    var defaultSelectedBox = SKSpriteNode()
    var astronautSelectedBox = SKSpriteNode()
    var lacrosseSelectedBox = SKSpriteNode()
    
    var topRectBuffer = SKShapeNode()
    
    var cloudsCurrencyBar = SKSpriteNode()
    var cloudCurrencyBarTexture = SKTexture(imageNamed: "CloudsCurrencyBar")
    var clouds: UInt32 = 0
    
    let cloudsLabel = SKLabelNode()
    
    let happyCharacterLabel = SKLabelNode()
    let astronautCharacterLabel = SKLabelNode()
    let lacrosseCharacterLabel = SKLabelNode()
    
    let happinessCostLabel = SKLabelNode()
    let astronautCostLabel = SKLabelNode()
    let lacrosseCostLabel = SKLabelNode()
    
    override func didMove(to view: SKView) {
        topRectBuffer = SKShapeNode(rectOf: CGSize(width: self.size.width, height: self.size.height/16), cornerRadius: 2)
        topRectBuffer.fillColor = .orange
        topRectBuffer.position = CGPoint(x: 0, y: self.size.height/2)
        addChild(topRectBuffer)
        
        defaultSkinButton = SKSpriteNode(texture: defaultSkinButtonTexture)
        defaultSkinButton.name = "defaultSkinButton"
        defaultSkinButton.setScale(1)
        //defaultSkinButton.size = CGSize(width: self.size.width/4, height: self.size.height/5.1)
        defaultSkinButton.position = CGPoint(x: 0, y: self.size.height/4 - 10)
        addChild(defaultSkinButton)
        
        happyCharacterLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        happyCharacterLabel.text = "Happiness"
        happyCharacterLabel.fontName = "Baskerville"
        happyCharacterLabel.fontSize = 75
        happyCharacterLabel.fontColor = .blue
        happyCharacterLabel.position = CGPoint(x: -160, y: self.size.height/4 + 130)
        happyCharacterLabel.zPosition = 2
        addChild(happyCharacterLabel)
        
        defaultSelectedBox = SKSpriteNode(texture: selectedBoxTexture)
        defaultSelectedBox.setScale(1)
        defaultSelectedBox.position = CGPoint(x: 150, y: self.size.height/4 - 10 - 70)
        addChild(defaultSelectedBox)
        
        astronautSkinButton = SKSpriteNode(texture: astronautSkinButtonTexture)
        astronautSkinButton.name = "astronautSkinButton"
        astronautSkinButton.setScale(1)
        //astronautSkinButton.size = CGSize(width: self.size.width/4, height: self.size.height/5.1)
        astronautSkinButton.position = CGPoint(x: 0, y: self.size.height/4 - self.size.height/3.6)
        //print("Height: \(astronautSkinButton.size.height)\nDistance: \(self.size.height/4 - self.size.height/3.6 - self.size.height/4 + 40)")
        addChild(astronautSkinButton)
        
        astronautCharacterLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        astronautCharacterLabel.text = "Astronaut"
        astronautCharacterLabel.fontName = "Baskerville"
        astronautCharacterLabel.fontSize = 75
        astronautCharacterLabel.fontColor = .blue
        astronautCharacterLabel.position = CGPoint(x: -160, y: self.size.height/4 - self.size.height/3.6 + 120)
        astronautCharacterLabel.zPosition = 2
        addChild(astronautCharacterLabel)
        
        astronautCostLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        astronautCostLabel.text = "Cost: 500 Clouds"
        astronautCostLabel.fontName = "Baskerville"
        astronautCostLabel.fontSize = 50
        astronautCostLabel.fontColor = .blue
        astronautCostLabel.position = CGPoint(x: -120, y: self.size.height/4 - self.size.height/3.6 - 140)
        astronautCostLabel.zPosition = 2
        addChild(astronautCostLabel)
        
        astronautSelectedBox = SKSpriteNode(texture: unselectedBoxTexture)
        astronautSelectedBox.setScale(1)
        astronautSelectedBox.position = CGPoint(x: 150, y: self.size.height/4 - self.size.height/3.6 - 70)
        addChild(astronautSelectedBox)
        
        lacrossePlayerSkinButton = SKSpriteNode(texture: lacrossePlayerSkinButtonTexture)
        lacrossePlayerSkinButton.name = "lacrossePlayerSkinButton"
        lacrossePlayerSkinButton.setScale(1)
        //lacrossePlayerSkinButton.size = CGSize(width: self.size.width/3.5, height: self.size.height/5.1)
        lacrossePlayerSkinButton.position = CGPoint(x: 0, y: self.size.height/4 - self.size.height/3.6 - 350)
        addChild(lacrossePlayerSkinButton)
        
        lacrosseCharacterLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        lacrosseCharacterLabel.text = "Lacrosse Player"
        lacrosseCharacterLabel.fontName = "Baskerville"
        lacrosseCharacterLabel.fontSize = 75
        lacrosseCharacterLabel.fontColor = .blue
        lacrosseCharacterLabel.position = CGPoint(x: -220, y: self.size.height/4 - self.size.height/3.6 - 230)
        lacrosseCharacterLabel.zPosition = 2
        addChild(lacrosseCharacterLabel)
        
        lacrosseCostLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        lacrosseCostLabel.text = "Cost: 500 Clouds"
        lacrosseCostLabel.fontName = "Baskerville"
        lacrosseCostLabel.fontSize = 50
        lacrosseCostLabel.fontColor = .blue
        lacrosseCostLabel.position = CGPoint(x: -120, y: self.size.height/4 - self.size.height/3.6 - 490)
        lacrosseCostLabel.zPosition = 2
        addChild(lacrosseCostLabel)
        
        lacrosseSelectedBox = SKSpriteNode(texture: unselectedBoxTexture)
        lacrosseSelectedBox.setScale(1)
        lacrosseSelectedBox.position = CGPoint(x: 150, y: self.size.height/4 - self.size.height/3.6 - 350 - 70)
        addChild(lacrosseSelectedBox)
        
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


