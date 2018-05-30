//
//  GameViewController.swift
//  SuperSpaceMan
//
//  Created by Franziska Pätzold on 28.05.18.
//  Copyright © 2018 Franziska Pätzold. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    var scene: GameScene!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //main view
        let skView = view as! SKView
        skView.showsFPS = false
        
        //game scene
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill //over the full screen
        
        //show scene
        skView.presentScene(scene)
        
    }
}
