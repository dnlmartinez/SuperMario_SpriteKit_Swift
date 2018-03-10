//
//  Player.swift
//  Koalio
//
//  Created by Rodrigo Villatoro on 7/6/14.
//  Copyright (c) 2014 RVD. All rights reserved.
//

import SpriteKit


class enemyLevel1: SKSpriteNode{
    
    var enemyName : String = ""
    var FramesRun : [SKTexture]!
    var enemyType : Int = 1
    
    init(type: Int){
        
        var texture = SKTexture()
        var FramesRun = [SKTexture]()
        self.enemyType = type
        
        switch type{
            case 1:
                
                let AnimatedAtlasRun : SKTextureAtlas = SKTextureAtlas(named: "GoombaSeila.atlas")
                self.enemyName = "GoombaS"
                
                for i in 1 ..< 5{
                    let TextureNameRun = "G\(i).png"
                    FramesRun.append(AnimatedAtlasRun.textureNamed(TextureNameRun))
                }
                self.FramesRun = FramesRun
                texture = SKTexture(imageNamed: "GoombaS")
            
            case 2:
                texture = SKTexture(imageNamed: "misil")
            
            case 3:
                let AnimatedAtlasRun : SKTextureAtlas = SKTextureAtlas(named: "GoombaPedro.atlas")
                self.enemyName = "GoombaP"
                
                for i in 1 ..< 5{
                    let TextureNameRun = "G\(i).png"
                    FramesRun.append(AnimatedAtlasRun.textureNamed(TextureNameRun))
                }
                
                self.FramesRun = FramesRun
                texture = SKTexture(imageNamed: "GoombaP")
            
            case 4:
                texture = SKTexture(imageNamed: "Dany")
            
            case 5:
                texture = SKTexture(imageNamed: "Dany")
            
            default:
                texture = SKTexture(imageNamed: "Dany")
        }
        
        super.init(texture: texture, color: UIColor() , size: texture.size())
        
        switch type
        {
        case 1:
            
            self.setScale(0.25)
            self.zPosition = 4
            self.run( SKAction.repeatForever(SKAction.animate(with: self.FramesRun, timePerFrame: 0.1, resize: false, restore: true)), withKey:"enemyRun")
            self.physicsBody = SKPhysicsBody(circleOfRadius: 25 , center: CGPoint(x: 0, y: -10))
            self.physicsBody?.allowsRotation = false
            self.physicsBody?.restitution = 0
            self.physicsBody?.friction = 0.2
            self.physicsBody?.mass = 80
            self.physicsBody?.affectedByGravity = true
            self.physicsBody?.categoryBitMask = SKACategoryEnemy1;
            self.physicsBody?.collisionBitMask = SKACategoryFloor | SKACategoryWall;
            self.physicsBody?.contactTestBitMask =  SKACategoryPlayer;

        case 2:
            
            self.setScale(0.40)
            self.zPosition = 4
            self.physicsBody = SKPhysicsBody(circleOfRadius: 35 , center: CGPoint(x: 0, y: -10))
            self.physicsBody?.allowsRotation = false
            self.physicsBody?.restitution = 0
            self.physicsBody?.friction = 0.2
            self.physicsBody?.mass = 80
            self.physicsBody?.affectedByGravity = false
            self.physicsBody?.categoryBitMask = SKACategoryEnemy2;
            self.physicsBody?.collisionBitMask = SKACategoryFloor | SKACategoryWall;
            self.physicsBody?.contactTestBitMask =  SKACategoryPlayer;
            
        case 3:
            self.setScale(0.25)
            self.zPosition = 4
            self.run( SKAction.repeatForever(SKAction.animate(with: self.FramesRun, timePerFrame: 0.1, resize: false, restore: true)), withKey:"enemyRun")
            self.physicsBody = SKPhysicsBody(circleOfRadius: 25 , center: CGPoint(x: 0, y: -10))
            self.physicsBody?.allowsRotation = false
            self.physicsBody?.restitution = 0
            self.physicsBody?.friction = 0.2
            self.physicsBody?.mass = 80
            self.physicsBody?.affectedByGravity = true
            self.physicsBody?.categoryBitMask = SKACategoryEnemy1;
            self.physicsBody?.collisionBitMask = SKACategoryFloor | SKACategoryWall;
            self.physicsBody?.contactTestBitMask =  SKACategoryPlayer;
            
        case 4:
            self.setScale(0.25)
            self.zPosition = 8
            self.physicsBody = SKPhysicsBody(circleOfRadius: 15 , center: CGPoint(x: 0, y: -20))
            self.physicsBody?.allowsRotation = false
            self.physicsBody?.restitution = 0
            self.physicsBody?.friction = 0.2
            self.physicsBody?.mass = 80
            self.physicsBody?.affectedByGravity = true
            self.physicsBody?.categoryBitMask = SKACategoryFloor;
            self.physicsBody?.collisionBitMask = SKACategoryFloor | SKACategoryWall;
            self.physicsBody?.contactTestBitMask =  SKACategoryPlayer;
            
        case 5:
            self.setScale(0.25)
            self.zPosition = 8
            self.physicsBody = SKPhysicsBody(circleOfRadius: 15 , center: CGPoint(x: 0, y: -20))
            self.physicsBody?.allowsRotation = false
            self.physicsBody?.restitution = 0
            self.physicsBody?.friction = 0.2
            self.physicsBody?.mass = 80
            self.physicsBody?.affectedByGravity = true
            self.physicsBody?.categoryBitMask = SKACategoryFloor;
            self.physicsBody?.collisionBitMask = SKACategoryFloor | SKACategoryWall;
            self.physicsBody?.contactTestBitMask =  SKACategoryPlayer;
            
        default:
            self.setScale(0.25)
            self.zPosition = 8
            self.physicsBody = SKPhysicsBody(circleOfRadius: 15 , center: CGPoint(x: 0, y: -20))
            self.physicsBody?.allowsRotation = false
            self.physicsBody?.restitution = 0
            self.physicsBody?.friction = 0.2
            self.physicsBody?.mass = 80
            self.physicsBody?.affectedByGravity = true
            self.physicsBody?.categoryBitMask = SKACategoryFloor;
            self.physicsBody?.collisionBitMask = SKACategoryFloor | SKACategoryWall;
            self.physicsBody?.contactTestBitMask =  SKACategoryPlayer;
        }
    }
    
    
    required init(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func updateEnemy(delta: CFTimeInterval , positionXPlayer: CGFloat){
        
        
        switch self.enemyType
        {
            case 1:
                self.physicsBody?.velocity = CGVector(dx: -100 , dy: (self.physicsBody?.velocity.dy)!)
            
            case 2:
                self.physicsBody?.velocity = CGVector(dx: -180 , dy: (self.physicsBody?.velocity.dy)!)
            
            case 3:
                self.physicsBody?.velocity = CGVector(dx: -100 , dy: (self.physicsBody?.velocity.dy)!)
            
            case 4:
                self.physicsBody?.velocity = CGVector(dx: -100 , dy: (self.physicsBody?.velocity.dy)!)
            
            case 5:
                self.physicsBody?.velocity = CGVector(dx: -100 , dy: (self.physicsBody?.velocity.dy)!)

            default:
                self.physicsBody?.velocity = CGVector(dx: -100 , dy: (self.physicsBody?.velocity.dy)!)

        }
        
        let posEnemy = self.position.x
        let diff = positionXPlayer - posEnemy
        if diff > 500{
            self.died()
        }
    }
    
    func died(){
        self.removeFromParent()
    }
    
}
