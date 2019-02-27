//
//  ItemsShopViewScene.swift
//  Sky Dropper
//
//  Created by Alexander Hall on 2/26/19.
//  Copyright © 2019 Hall Inc. All rights reserved.
//

import SpriteKit
import GameplayKit

class ItemsShopViewScene: SKScene {
    
    var rayGunButton = SKSpriteNode()
    var barrierButton = SKSpriteNode()
    var rayGunTexture = SKTexture(imageNamed: "RayGunButton")
    var barrierTexture = SKTexture(imageNamed: "BarrierButton")
    
    var rayGunUpgradeBar = SKSpriteNode()
    var barrierUpgradeBar = SKSpriteNode()
    var upgradeTexture = SKTexture(imageNamed: "UpgradeBar0")
    
    var topRectBuffer = SKShapeNode()
    
    override func didMove(to view: SKView) {
        rayGunButton = SKSpriteNode(texture: rayGunTexture)
        rayGunButton.name = "rayGun"
        rayGunButton.size = CGSize(width: 300, height: 300)
        rayGunButton.position = CGPoint(x: 0, y: self.size.height/4)
        addChild(rayGunButton)
        
        rayGunUpgradeBar = SKSpriteNode(texture: upgradeTexture)
        rayGunUpgradeBar.name = "rayGunUpgrade0"
        rayGunUpgradeBar.size = CGSize(width: 400, height: 80)
        rayGunUpgradeBar.position = CGPoint(x: 0, y: self.size.height/4 - 220)
        addChild(rayGunUpgradeBar)
        
        barrierButton = SKSpriteNode(texture: barrierTexture)
        barrierButton.name = "barrier"
        barrierButton.size = CGSize(width: 300, height: 300)
        barrierButton.position = CGPoint(x: 0, y: self.size.height/4 - 550)
        addChild(barrierButton)
        
        barrierUpgradeBar = SKSpriteNode(texture: upgradeTexture)
        barrierUpgradeBar.name = "barrierUpgrade0"
        barrierUpgradeBar.size = CGSize(width: 400, height: 80)
        barrierUpgradeBar.position = CGPoint(x: 0, y: self.size.height/4 - 770)
        addChild(barrierUpgradeBar)
        
        topRectBuffer = SKShapeNode(rectOf: CGSize(width: self.size.width, height: self.size.height/16), cornerRadius: 2)
        topRectBuffer.fillColor = .orange
        topRectBuffer.position = CGPoint(x: 0, y: self.size.height/2)
        addChild(topRectBuffer)
        
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

