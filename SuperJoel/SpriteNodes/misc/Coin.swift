//
//  Coin.swift
//  SuperJoel
//
//  Created by daniel martinez gonzalez on 4/6/17.
//  Copyright © 2017 daniel martinez gonzalez. All rights reserved.
//

import SpriteKit

class Coin: SKSpriteNode{
    
    var coinName : String = ""
    var FramesRun : [SKTexture]!
    
    init()
    {
        var texture = SKTexture()
        var FramesRun = [SKTexture]()
        let AnimatedAtlasRun : SKTextureAtlas = SKTextureAtlas(named: "coins.atlas")
     
        for i in 1 ..< 14{
            let TextureNameRun = "\(i).png"
            FramesRun.append(AnimatedAtlasRun.textureNamed(TextureNameRun))
        }

        self.FramesRun = FramesRun
        texture = SKTexture(imageNamed: "coin")
        
        super.init(texture: texture, color: UIColor() , size: texture.size())
        
        self.setScale(0.7)
        self.zPosition = 8
        self.run( SKAction.repeatForever(SKAction.animate(with: self.FramesRun, timePerFrame: 0.1, resize: false, restore: true)), withKey:"coinanimate")
        self.physicsBody = SKPhysicsBody(circleOfRadius: 15 , center: CGPoint(x: 0, y: -20))
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.restitution = 0
        self.physicsBody?.friction = 0.2
        self.physicsBody?.mass = 80
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.categoryBitMask = SKACategoryCoin;
        self.physicsBody?.collisionBitMask = SKACategoryFloor | SKACategoryWall;
    }
    
    required init(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCoin(delta: CFTimeInterval , positionXPlayer: CGFloat){
        let posEnemy = self.position.x
        let diff = positionXPlayer - posEnemy
        if diff > 450{
            self.removeFromParent()
        }
    }
    
}
