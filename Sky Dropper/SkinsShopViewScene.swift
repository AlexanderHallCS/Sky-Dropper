//
//  SkinsShopViewScene.swift
//  Sky Dropper
//
//  Created by Alexander Hall on 2/26/19.
//  Copyright © 2019 Hall Inc. All rights reserved.
//

import SpriteKit
import GameplayKit

class SkinsShopViewScene: SKScene {
    
    var defaultSkinButton = SKSpriteNode()
    var defaultSkinButtonTexture = SKTexture(imageNamed: "DefaultSkinButton")
    var astronautSkinButton = SKSpriteNode()
    var astronautSkinButtonTexture = SKTexture(imageNamed: "AstronautSkinButton")
    var lacrossePlayerSkinButton = SKSpriteNode()
    var lacrossePlayerSkinButtonTexture = SKTexture(imageNamed: "LacrossPlayerSkinButton")
    
    var topRectBuffer = SKShapeNode()
    
    override func didMove(to view: SKView) {
        topRectBuffer = SKShapeNode(rectOf: CGSize(width: self.size.width, height: self.size.height/16), cornerRadius: 2)
        topRectBuffer.fillColor = .orange
        topRectBuffer.position = CGPoint(x: 0, y: self.size.height/2)
        addChild(topRectBuffer)
        
        defaultSkinButton = SKSpriteNode(texture: defaultSkinButtonTexture)
        defaultSkinButton.name = "defaultSkinButton"
        defaultSkinButton.setScale(1.3)
        //defaultSkinButton.size = CGSize(width: self.size.width/4, height: self.size.height/5.1)
        defaultSkinButton.position = CGPoint(x: 0, y: self.size.height/4 + 40)
        addChild(defaultSkinButton)
        
        astronautSkinButton = SKSpriteNode(texture: astronautSkinButtonTexture)
        astronautSkinButton.name = "astronautSkinButton"
        astronautSkinButton.setScale(1.3)
        //astronautSkinButton.size = CGSize(width: self.size.width/4, height: self.size.height/5.1)
        astronautSkinButton.position = CGPoint(x: 0, y: self.size.height/4 - self.size.height/3.6)
        //print("Height: \(astronautSkinButton.size.height)\nDistance: \(self.size.height/4 - self.size.height/3.6 - self.size.height/4 + 40)")
        addChild(astronautSkinButton)
        
        lacrossePlayerSkinButton = SKSpriteNode(texture: lacrossePlayerSkinButtonTexture)
        lacrossePlayerSkinButton.name = "lacrossePlayerSkinButton"
        lacrossePlayerSkinButton.setScale(1.3)
        //lacrossePlayerSkinButton.size = CGSize(width: self.size.width/3.5, height: self.size.height/5.1)
        lacrossePlayerSkinButton.position = CGPoint(x: 0, y: self.size.height/4 - self.size.height/3.6 - 400)
        addChild(lacrossePlayerSkinButton)
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


