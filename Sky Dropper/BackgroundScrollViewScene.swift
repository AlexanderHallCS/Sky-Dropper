//
//  BackgroundScrollViewScene.swift
//  Sky Dropper
//
//  Created by Alexander Hall on 2/22/19.
//  Copyright © 2019 Hall Inc. All rights reserved.
//

import SpriteKit
import GameplayKit

class BackgroundScrollViewScene: SKScene {
    
    var topRectBuffer = SKShapeNode()
    
    var scrollingNode = SKNode()
    var startY: CGFloat = 0.0
    var lastY: CGFloat = 0.0
    
    var scrollingNodeTest = SKSpriteNode()
    var scrollingNodeTestTexture = SKTexture(imageNamed: "BackArrow")
    
    override func didMove(to view: SKView) {
        scrollingNode.position = CGPoint(x: 0, y: 0)
        self.addChild(scrollingNode)
        
        topRectBuffer = SKShapeNode(rectOf: CGSize(width: self.size.width, height: self.size.height/16), cornerRadius: 2)
        topRectBuffer.fillColor = .orange
        topRectBuffer.position = CGPoint(x: 0, y: self.size.height/2)
        //scrollingNode.addChild(topRectBuffer)
        addChild(topRectBuffer)
        
        
        //this is just to test how the screen scrolls
        scrollingNodeTest = SKSpriteNode(texture: scrollingNodeTestTexture)
        scrollingNodeTest.size = CGSize(width: 40, height: 40)
        scrollingNodeTest.position = CGPoint(x: -self.size.width/2, y: 0)
        scrollingNode.addChild(scrollingNodeTest)
        //remove after used
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

