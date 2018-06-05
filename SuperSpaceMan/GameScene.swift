//
//  GameScene.swift
//  SuperSpaceMan
//
//  Created by Franziska Pätzold on 28.05.18.
//  Copyright © 2018 Franziska Pätzold. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let backgroundNode = SKSpriteNode(imageNamed: "background")
    let playerNode = SKSpriteNode(imageNamed: "player")
    let brick1Node = SKSpriteNode(imageNamed: "brick1")
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize){
        super.init(size: size)
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -0.1)
        
        //ability for user to apply an impulse
        isUserInteractionEnabled = true
        
        //configuration background
        backgroundNode.size.width = frame.size.width //sets the Node to the views frame
        
        //position is a point in the view and anchorPoint is the a relative point in the picture that adjusts to the position point
        backgroundNode.anchorPoint = CGPoint(x: 0.5, y: 0.0) //on which point the node is set (0.5 & 0 is bottom center of the node)
        backgroundNode.position = CGPoint (x: size.width / 2.0, y: 0.0) //set node to the middle and the bottom of the scene
        addChild(backgroundNode) // adds node to scene
        
        //configuration player
        playerNode.physicsBody = SKPhysicsBody(circleOfRadius: playerNode.size.width / 2)
        playerNode.physicsBody?.isDynamic = true
        playerNode.position = CGPoint(x: size.width/2.0, y: 80.0) // anchorPoint is the middle
        //let it look like the ball falls through air
        playerNode.physicsBody?.linearDamping = 1.0
        //stop rotation by collision
        //playerNode.physicsBody?.allowsRotation = false
        addChild(playerNode)
        
        brick1Node.position = CGPoint(x:150.0, y: size.height - 25.0)
        brick1Node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: brick1Node.size.width, height: brick1Node.size.height))
        brick1Node.physicsBody = SKPhysicsBody(circleOfRadius: brick1Node.size.width / 2)
        brick1Node.physicsBody?.isDynamic = false
        addChild(brick1Node)
        
    }
    
    //needs isUserInteractionEnabled = true in initializer
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        playerNode.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 40.0))
    }
}
