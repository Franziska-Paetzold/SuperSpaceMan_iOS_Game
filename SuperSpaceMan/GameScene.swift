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
    let foregroundNode = SKSpriteNode()
    let playerNode = SKSpriteNode(imageNamed: "player")
    //let brick1Node = SKSpriteNode(imageNamed: "brick1")
    let seaShellNode = SKSpriteNode(imageNamed: "seashell")
    
    let collisionCategoryPlayer : UInt32 = 0x1 << 1
    let collisionCategoryPowerUpShells : UInt32 = 0x1 << 2
    
    var impulseCount = 4
    
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize){
        super.init(size: size)
        // needed for extension
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -5.0)
        
        //ability for user to apply an impulse
        isUserInteractionEnabled = true
        
        
        //============configuration background==============
        backgroundNode.size.width = frame.size.width //sets the Node to the views frame
        
        //position is a point in the view and anchorPoint is the a relative point in the picture that adjusts to the position point
        backgroundNode.anchorPoint = CGPoint(x: 0.5, y: 0.0) //on which point the node is set (0.5 & 0 is bottom center of the node)
        backgroundNode.position = CGPoint (x: size.width / 2.0, y: 0.0) //set node to the middle and the bottom of the scene
        addChild(backgroundNode) // adds node to scene
        //============add foreground==============
        addChild(foregroundNode)
        
        //============configuration player============
        playerNode.physicsBody = SKPhysicsBody(circleOfRadius: playerNode.size.width / 2)
        playerNode.physicsBody?.isDynamic = false //false, because the ball shouldnt fall out of the screen
        playerNode.position = CGPoint(x: size.width/2.0, y: 180.0) // anchorPoint is the middle
        //let it look like the ball falls through air
        playerNode.physicsBody?.linearDamping = 1.0
        //stop rotation by collision
        //playerNode.physicsBody?.allowsRotation = false
        playerNode.physicsBody?.categoryBitMask = collisionCategoryPlayer
        playerNode.physicsBody?.contactTestBitMask = collisionCategoryPowerUpShells
        //playerNode.physicsBody?.collisionBitMask = 0 //handle collision on our own s
        foregroundNode.addChild(playerNode)
        
        //============configuration brick1Node============
        /*
        brick1Node.position = CGPoint(x:150.0, y: size.height - 25.0)
        brick1Node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: brick1Node.size.width, height: brick1Node.size.height))
        //brick1Node.physicsBody = SKPhysicsBody(circleOfRadius: brick1Node.size.width / 2)
        brick1Node.physicsBody?.isDynamic = false
        foregroundNode.addChild(brick1Node)
        */
        
        //============configuration seaShellNode============
        seaShellNode.name = "SEA_SHELL"
        seaShellNode.position = CGPoint(x: 150.0, y: size.width - 25)
        seaShellNode.physicsBody = SKPhysicsBody(circleOfRadius: seaShellNode.size.width / 2)
        seaShellNode.physicsBody?.isDynamic = false
        seaShellNode.physicsBody?.categoryBitMask = collisionCategoryPowerUpShells
        //seaShellNode.physicsBody?.collisionBitMask = 0 //0 = we dont want the program to handle the collision for us
        foregroundNode.addChild(seaShellNode)
        
        
    }
    
    //needs isUserInteractionEnabled = true in initializer
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !playerNode.physicsBody!.isDynamic {
            playerNode.physicsBody?.isDynamic = true
        }
        
        if impulseCount > 0 {
            playerNode.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 40.0))
            impulseCount -= 1
        }
    }
    
    
    
}

extension GameScene: SKPhysicsContactDelegate{
    func didBegin(_ contact: SKPhysicsContact) {
        print("There has been contact")
        //a represents first body in the contact (player), b property represents second body
        let contactNode = contact.bodyB.node
        if contactNode?.name == "SEA_SHELL" {
            contactNode?.removeFromParent()
            impulseCount += 4
        }
    }
}
