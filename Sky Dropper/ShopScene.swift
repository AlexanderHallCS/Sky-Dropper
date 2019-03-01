//
//  ShopScene.swift
//  Sky Dropper
//
//  Created by Alexander Hall on 2/3/19.
//  Copyright © 2019 Hall Inc. All rights reserved.
//

import SpriteKit
import GameplayKit

class ShopScene: SKScene {
    
    var extraLifeUpgrade = SKSpriteNode()
    var extraLifeUpgradeTexture = SKTexture(imageNamed: "ExtraLifeOnStartOfGameButtonLocked")
    var increasedSpeedUpgrade = SKSpriteNode()
    var increasedSpeedUpgradeTexture = SKTexture(imageNamed: "IncreasedSpeedNextGameLockedButton")
    
    var topRectBuffer = SKShapeNode()
    
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
