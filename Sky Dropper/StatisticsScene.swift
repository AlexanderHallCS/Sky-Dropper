//
//  LevelsScene.swift
//  Sky Dropper
//
//  Created by Alexander Hall on 1/9/19.
//  Copyright © 2019 Hall Inc. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreData

class StatisticsScene: SKScene {
    
    var statisticsLabel = SKLabelNode()
    
    var fallingItemsDropped: UInt32 = 0
    var redItemsCaught: UInt32 = 0
    var greenItemsCaught: UInt32 = 0
    var yellowItemsCaught: UInt32 = 0
    var totalItemsCaught: UInt32 = 0
    var totalPoints: UInt32 = 0
    
    var fallingItemsDroppedLabel = SKLabelNode()
    var redItemsCaughtLabel = SKLabelNode()
    var greenItemsCaughtLabel = SKLabelNode()
    var yellowItemsCaughtLabel = SKLabelNode()
    var totalItemsCaughtLabel = SKLabelNode()
    var totalPointsLabel = SKLabelNode()

    
    override func didMove(to view: SKView) {
        
        do {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SkyDropperTracking")
            request.returnsObjectsAsFaults = false
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
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
        
        
        statisticsLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        statisticsLabel.text = "Statistics"
        statisticsLabel.fontName = "Baskerville"
        statisticsLabel.fontSize = 85
        statisticsLabel.fontColor = .blue
        statisticsLabel.position = CGPoint(x: -125, y: self.size.height/4 + 230)
        statisticsLabel.zPosition = 2
        addChild(statisticsLabel)
        
        totalItemsCaughtLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        totalItemsCaughtLabel.text = "Total Items Caught: \(totalItemsCaught)"
        totalItemsCaughtLabel.fontName = "Baskerville"
        totalItemsCaughtLabel.fontSize = 45
        totalItemsCaughtLabel.fontColor = .blue
        totalItemsCaughtLabel.position = CGPoint(x: -345, y: self.size.height/4 + 80)
        totalItemsCaughtLabel.zPosition = 2
        addChild(totalItemsCaughtLabel)
        
        redItemsCaughtLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        redItemsCaughtLabel.text = "Red Items Caught: \(redItemsCaught)"
        redItemsCaughtLabel.fontName = "Baskerville"
        redItemsCaughtLabel.fontSize = 45
        redItemsCaughtLabel.fontColor = .blue
        redItemsCaughtLabel.position = CGPoint(x: -265, y: totalItemsCaughtLabel.position.y - 100)
        redItemsCaughtLabel.zPosition = 2
        addChild(redItemsCaughtLabel)
        
        greenItemsCaughtLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        greenItemsCaughtLabel.text = "Green Items Caught: \(greenItemsCaught)"
        greenItemsCaughtLabel.fontName = "Baskerville"
        greenItemsCaughtLabel.fontSize = 45
        greenItemsCaughtLabel.fontColor = .blue
        greenItemsCaughtLabel.position = CGPoint(x: -265, y: redItemsCaughtLabel.position.y - 100)
        greenItemsCaughtLabel.zPosition = 2
        addChild(greenItemsCaughtLabel)
        
        yellowItemsCaughtLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        yellowItemsCaughtLabel.text = "Yellow Items Caught: \(yellowItemsCaught)"
        yellowItemsCaughtLabel.fontName = "Baskerville"
        yellowItemsCaughtLabel.fontSize = 45
        yellowItemsCaughtLabel.fontColor = .blue
        yellowItemsCaughtLabel.position = CGPoint(x: -265, y: greenItemsCaughtLabel.position.y - 100)
        yellowItemsCaughtLabel.zPosition = 2
        addChild(yellowItemsCaughtLabel)
        
        fallingItemsDroppedLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        fallingItemsDroppedLabel.text = "Falling Items Dropped: \(fallingItemsDropped)"
        fallingItemsDroppedLabel.fontName = "Baskerville"
        fallingItemsDroppedLabel.fontSize = 45
        fallingItemsDroppedLabel.fontColor = .blue
        fallingItemsDroppedLabel.position = CGPoint(x: -345, y: yellowItemsCaughtLabel.position.y - 100)
        fallingItemsDroppedLabel.zPosition = 2
        addChild(fallingItemsDroppedLabel)
        
        totalPointsLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        totalPointsLabel.text = "Total Points: \(totalPoints)"
        totalPointsLabel.fontName = "Baskerville"
        totalPointsLabel.fontSize = 45
        totalPointsLabel.fontColor = .blue
        totalPointsLabel.position = CGPoint(x: -345, y: fallingItemsDroppedLabel.position.y - 100)
        totalPointsLabel.zPosition = 2
        addChild(totalPointsLabel)

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
