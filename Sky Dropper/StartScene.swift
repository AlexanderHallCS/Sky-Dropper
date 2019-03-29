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
    
    let cloudsLabel = SKLabelNode()
    
    override func didMove(to view: SKView) {
        
        background = SKSpriteNode(texture: defaultBackground)
        background.size = self.frame.size
        addChild(background)
        
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
        
        cloudsLabel.text = "\(clouds)"
        cloudsLabel.fontName = "Baskerville"
        cloudsLabel.fontSize = 60
        cloudsLabel.fontColor = .black
        cloudsLabel.position = CGPoint(x: -150, y: 500)
        cloudsLabel.zPosition = 3
        addChild(cloudsLabel)
        
        cloudsCurrencyBar = SKSpriteNode(texture: cloudCurrencyBarTexture)
        cloudsCurrencyBar.position = CGPoint(x: -200, y: 500)
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
