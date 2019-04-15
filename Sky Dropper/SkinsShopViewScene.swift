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
    
    var isAstronautUnlocked: UInt32 = 0
    var isLacrosseUnlocked: UInt32 = 0
    //0 = default
    //1 = astronaut
    //2 = lacrosse
    var currentSkin: UInt32 = 0
    
    var rayGunUpgradeNumber: UInt32 = 0
    var barrierUpgradeNumber: UInt32 = 0
    
    override func didMove(to view: SKView) {
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
                isAstronautUnlocked = (data.value(forKey: "isAstronautUnlocked") as! UInt32)
                isLacrosseUnlocked = (data.value(forKey: "isLacrosseUnlocked") as! UInt32)
                currentSkin = (data.value(forKey: "currentSkin") as! UInt32)
                rayGunUpgradeNumber = (data.value(forKey: "rayGunUpgradeTracking") as! UInt32)
                barrierUpgradeNumber = (data.value(forKey: "barrierUpgradeTracking") as! UInt32)
            }
        } catch {
            print("Failed")
        }
        
        print("Clouds: \(clouds)")
        print("isAstronautUnlocked: \(isAstronautUnlocked)")
        print("isLacrosseSkinUnlocked: \(isLacrosseUnlocked)")
        print("current skin: \(currentSkin)")
        print("rayGunUpgradeNumber: \(rayGunUpgradeNumber)")
        print("barrierUpgradeNumber: \(barrierUpgradeNumber)")
        
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
        
        if(currentSkin == 0) {
            defaultSelectedBox = SKSpriteNode(texture: selectedBoxTexture)
        } else {
            defaultSelectedBox = SKSpriteNode(texture: unselectedBoxTexture)
        }
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
        
        if(isAstronautUnlocked == 0) {
        astronautCostLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        astronautCostLabel.text = "Cost: 500 Clouds"
        astronautCostLabel.fontName = "Baskerville"
        astronautCostLabel.fontSize = 50
        astronautCostLabel.fontColor = .blue
        astronautCostLabel.position = CGPoint(x: -120, y: self.size.height/4 - self.size.height/3.6 - 140)
        astronautCostLabel.zPosition = 2
        addChild(astronautCostLabel)
        }
        
        if(currentSkin == 1) {
            astronautSelectedBox = SKSpriteNode(texture: selectedBoxTexture)
        } else {
            astronautSelectedBox = SKSpriteNode(texture: unselectedBoxTexture)
        }
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
        
        if(isLacrosseUnlocked == 0) {
        lacrosseCostLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        lacrosseCostLabel.text = "Cost: 500 Clouds"
        lacrosseCostLabel.fontName = "Baskerville"
        lacrosseCostLabel.fontSize = 50
        lacrosseCostLabel.fontColor = .blue
        lacrosseCostLabel.position = CGPoint(x: -120, y: self.size.height/4 - self.size.height/3.6 - 490)
        lacrosseCostLabel.zPosition = 2
        addChild(lacrosseCostLabel)
        }
        
        if(currentSkin == 2) {
            lacrosseSelectedBox = SKSpriteNode(texture: selectedBoxTexture)
        } else {
            lacrosseSelectedBox = SKSpriteNode(texture: unselectedBoxTexture)
        }
        lacrosseSelectedBox.setScale(1)
        lacrosseSelectedBox.position = CGPoint(x: 150, y: self.size.height/4 - self.size.height/3.6 - 350 - 70)
        addChild(lacrosseSelectedBox)
        
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
                if(name == "astronautSkinButton" && isAstronautUnlocked == 0 && clouds >= 500)
                {
                    clouds = clouds - 500
                    isAstronautUnlocked = 1
                    if(currentSkin == 0) {
                        defaultSelectedBox.texture = unselectedBoxTexture
                    } else if(currentSkin == 2) {
                        lacrosseSelectedBox.texture = unselectedBoxTexture
                    }
                    currentSkin = 1
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
                    cloudsLabel.text = "\(clouds)"
                    astronautSelectedBox.texture = selectedBoxTexture
                    astronautCostLabel.removeFromParent()
                } else if(name == "astronautSkinButton" && isAstronautUnlocked == 1) {
                    if(currentSkin == 0) {
                        defaultSelectedBox.texture = unselectedBoxTexture
                    } else if(currentSkin == 2) {
                        lacrosseSelectedBox.texture = unselectedBoxTexture
                    }
                    currentSkin = 1
                    astronautSelectedBox.texture = selectedBoxTexture
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
                
                if(name == "lacrossePlayerSkinButton" && isLacrosseUnlocked == 0 && clouds >= 500) {
                    clouds = clouds - 500
                    isLacrosseUnlocked = 1
                    if(currentSkin == 0) {
                        defaultSelectedBox.texture = unselectedBoxTexture
                    } else if(currentSkin == 1) {
                        astronautSelectedBox.texture = unselectedBoxTexture
                    }
                    currentSkin = 2
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
                    cloudsLabel.text = "\(clouds)"
                    lacrosseSelectedBox.texture = selectedBoxTexture
                    lacrosseCostLabel.removeFromParent()
                } else if(name == "lacrossePlayerSkinButton" && isLacrosseUnlocked == 1) {
                    if(currentSkin == 0) {
                        defaultSelectedBox.texture = unselectedBoxTexture
                    } else if(currentSkin == 1) {
                        astronautSelectedBox.texture = unselectedBoxTexture
                    }
                    currentSkin = 2
                    lacrosseSelectedBox.texture = selectedBoxTexture
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
                
                if(name == "defaultSkinButton") {
                    if(currentSkin == 1) {
                        astronautSelectedBox.texture = unselectedBoxTexture
                    } else if(currentSkin == 2) {
                        lacrosseSelectedBox.texture = unselectedBoxTexture
                    }
                    currentSkin = 0
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
                    defaultSelectedBox.texture = selectedBoxTexture
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


