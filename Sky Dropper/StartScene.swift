//
//  GameScene.swift
//  Sky Dropper
//
//  Created by Alexander Hall on 1/9/19.
//  Copyright © 2019 Hall Inc. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreData

class StartScene: SKScene {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var cloudsCurrencyBar = SKSpriteNode()
    var cloudCurrencyBarTexture = SKTexture(imageNamed: "CloudsCurrencyBar")
    var clouds: UInt32 = 0
    
    var background = SKSpriteNode()
    var defaultBackground = SKTexture(imageNamed: "StartingBG")
    var winterBG = SKTexture(imageNamed: "WinterBG")
    var jungleBG = SKTexture(imageNamed: "JungleBG")
    var oceanBG = SKTexture(imageNamed: "OceanBG")
    var spaceBG = SKTexture(imageNamed: "SpaceBG")
    
    let cloudsLabel = SKLabelNode()
    
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
                currentBackground = (data.value(forKey: "currentBackground") as! UInt32)
            }
        } catch {
            print("Failed")
        }
        
        if(currentBackground == 0) {
            background = SKSpriteNode(texture: defaultBackground)
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
        
        cloudsLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        cloudsLabel.text = "\(clouds)"
        cloudsLabel.fontName = "Baskerville"
        cloudsLabel.fontSize = 55
        cloudsLabel.fontColor = .black
        cloudsLabel.position = CGPoint(x: -140, y: 610)
        cloudsLabel.zPosition = 3
        addChild(cloudsLabel)
        
        cloudsCurrencyBar = SKSpriteNode(texture: cloudCurrencyBarTexture)
        cloudsCurrencyBar.size = CGSize(width: 580, height: 60)
        cloudsCurrencyBar.position = CGPoint(x: -70, y: 630)
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
