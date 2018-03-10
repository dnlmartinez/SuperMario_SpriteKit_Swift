//
//  Mundo_1_Nivel_1.swift
//  SuperJoel
//
//  Created by daniel martinez gonzalez on 7/4/17.
//  Copyright © 2017 daniel martinez gonzalez. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import AVFoundation


class Mundo_1_Nivel_1: SKScene , SKPhysicsContactDelegate
{

    
    private var joelM : SKSpriteNode?
    
    var backgroundMusicPlayer = AVAudioPlayer()
    var enemies : [enemyLevel1] = [enemyLevel1]()
    var coins : [Coin] = [Coin]()
    
    var map : SKATiledMap = SKATiledMap()
    
    var joelFrames : [SKTexture]!
    var joelFramesRun : [SKTexture]!
    var labelTimer : SKLabelNode?
    var labelScore : SKLabelNode?
    
    var jump : Bool = false
    var countJump : Int = 0
    var SuperPower : Bool = false
    var loser : Bool = false
    var winer : Bool = false
    
    var enemyTimer: Timer!
    var coinTimer: Timer!
    var TempTimer : Timer!
    var TempPower : Timer!
    var MultiplicateEnemiesTimer : Timer!

    var timerNum : Int = 150
    var CoinsSaved : Int = 0
    var CoinsTemp : Int = 0
    var TempGoomba : Int = 0
    var TempMisil : Int = 0

    
    override func didMove(to view: SKView)
    {
        
        self.playBackgroundMusic()
        
        view.ignoresSiblingOrder = true
        physicsWorld.contactDelegate = self
        
        self.loadScore()
        self.initialAnimationJoel()
        
        self.joelM?.setScale(0.9)
        self.joelM?.zPosition = 8
        
        self.joelM?.position = CGPoint(x: self.frame.minX + 90 , y: self.frame.minY + 240)
        self.joelM?.physicsBody = SKPhysicsBody(circleOfRadius: 15 , center: CGPoint(x: 0, y: -20))
        self.joelM?.physicsBody?.allowsRotation = false
        self.joelM?.physicsBody?.restitution = 0
        self.joelM?.physicsBody?.friction = 0.2
        self.joelM?.physicsBody?.mass = 100
        self.joelM?.physicsBody?.affectedByGravity = true
        self.joelM?.physicsBody?.categoryBitMask = SKACategoryPlayer;
        
        
        self.joelM?.physicsBody?.collisionBitMask = SKACategoryFloor | SKACategoryWall | SKACategoryCoin | SKACategoryEnemy1 | SKACategoryEnemy2 ;
        
        self.joelM?.physicsBody?.contactTestBitMask = SKACategoryFloor | SKACategoryWall | SKACategoryCoin | SKACategoryEnemy1 | SKACategoryEnemy2 ;
        
        
        self.map = SKATiledMap.init(mapName: "SampleMapKenny")
        self.map.autoFollowNode = self.joelM
        
        self.map.addChild(self.joelM!)
        self.addChild(self.map)
        self.initTimers()
    }
    
    
    func didBegin(_ contact: SKPhysicsContact)
    {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        countJump = 0
        
        if contactMask == 9437184
        {
            let coin = contact.bodyB
            let music = SKAction.playSoundFileNamed("coin.wav", waitForCompletion: false)
            self.run(music)
            self.AddScore(value: 1)
            
            coin.node?.removeFromParent()
            
        }
        else if contactMask == 17825792
        {
            NSLog("Enemy -1-")
            
            if !self.SuperPower
            {
                let enemy = contact.bodyB
                
                let valuePlayer : CGFloat = (self.joelM?.position.y)! - 55.0
                let valueEnemy : CGFloat = (enemy.node?.position.y)!
                
                let diff = valueEnemy - valuePlayer
                
                
                if abs(diff) < 30 && abs(diff) > 0
                {
                    enemy.node?.removeFromParent()
                    countJump = 1
                    TempGoomba = TempGoomba + 1
                }
                else
                {
                    NSLog("Diff-->   1--> \(diff)")
                    self.Lose(type: 1)
                }

            }
            else
            {
                self.AddScore(value: 1)
                TempGoomba = TempGoomba + 1
                let enemy = contact.bodyB
                enemy.node?.removeFromParent()
            }
            
            
        }
        else if contactMask == 34603008
        {
            NSLog("Enemy -2-")
            if !self.SuperPower
            {
                let enemy = contact.bodyB
                
                let valuePlayer : CGFloat = (self.joelM?.position.y)! - 55.0
                let valueEnemy : CGFloat = (enemy.node?.position.y)!
                
                let diff = valueEnemy - valuePlayer
                
                
                if abs(diff) < 30 && abs(diff) > 0
                {
                    enemy.node?.removeFromParent()
                    countJump = 1
                    TempMisil = TempMisil + 1
                }
                else
                {
                    NSLog("Diff-->   2--> \(diff)")
                    self.Lose(type: 1)
                }
            }
            else
            {
                self.AddScore(value: 1)
                TempMisil = TempMisil + 1
                let enemy = contact.bodyB
                enemy.node?.removeFromParent()
            }
            
        }
        else
        {
            NSLog("------> Contact mask \(contactMask)")
        }
        
        
    }


    
    func playBackgroundMusic() -> ()
    {
        
        let backgroundMusicURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: "mario-theme", ofType: "mp3")!)
        do
        {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: backgroundMusicURL as URL)
            backgroundMusicPlayer.numberOfLoops = -1
            backgroundMusicPlayer.prepareToPlay()
            backgroundMusicPlayer.play()
        }
        catch
        {}
    }
    
    
    func loadScore()
    {
        self.CoinsSaved = UserDefaults.standard.value(forKey: "score") as! Int
        
        self.labelScore = self.childNode(withName: "labelScore") as? SKLabelNode
        self.labelScore?.text = String.localizedStringWithFormat("%i", self.CoinsSaved)
        self.labelScore?.fontSize = 30
        self.labelScore?.name = "labelScore"
        
        self.labelTimer = self.childNode(withName: "timerCounter") as? SKLabelNode
        self.labelTimer?.text = String.localizedStringWithFormat("%i", self.timerNum)
        self.labelTimer?.name = "timerCounter"
        
    }

    
    func initTimers()
    {
        
        enemyTimer = Timer.scheduledTimer(timeInterval: 3 , target: self, selector: #selector(addEnemy), userInfo: nil, repeats: true)
        
        
        coinTimer = Timer.scheduledTimer(timeInterval: 0.6 , target: self, selector: #selector(addCoin), userInfo: nil, repeats: true)
        
        
        TempTimer = Timer.scheduledTimer(timeInterval: 1 , target: self, selector: #selector(Temporizador), userInfo: nil, repeats: true)
        
    }
    
    
    func Temporizador()
    {
        
        self.timerNum -= 1
        
        if self.timerNum < 30
        {
            
            if self.timerNum < 15
            {
                self.labelTimer?.color = UIColor.red
            }
            else
            {
                self.labelTimer?.color = UIColor.yellow
            }
        }
        
        
        if self.timerNum < 0
        {
            self.timerNum = 0
            self.Lose(type: 0)
        }
        
        self.labelTimer?.text = String.localizedStringWithFormat("%i", self.timerNum)
    }
    
    
    
    func addCoin()
    {
        
        let coin : Coin = Coin()
        coin.position = CGPoint(x: (self.joelM?.position.x)!  + 450 , y: (self.joelM?.position.y)! + 450)
        self.coins.append(coin)
        self.map.addChild(coin)
    }
    
    func MoreEnemies()
    {
        self.addCoin()
        self.addEnemy()
        self.addCoin()
    }
    
    
    func addEnemy()
    {
        
        let randomNum:UInt32 = arc4random_uniform(2)
        let someInt : Int = Int(randomNum) + 1
        
        
        let enemy : enemyLevel1 = enemyLevel1(type: someInt)
        
        switch someInt
        {
            case 1:
                enemy.position = CGPoint(x: (self.joelM?.position.x)!  + 450 , y: (self.joelM?.position.y)! + 450)
            
            case 2:
                
                let randomNum:UInt32 = arc4random_uniform(300)
                let someInt : Int = Int(randomNum)
                
                enemy.position = CGPoint(x: (self.joelM?.position.x)!  + 450 , y: (self.joelM?.position.y)! + CGFloat(someInt))
            
                
            case 3:
                enemy.position = CGPoint(x: (self.joelM?.position.x)!  + 450 , y: (self.joelM?.position.y)! + 450)
                
            case 4:
                enemy.position = CGPoint(x: (self.joelM?.position.x)!  + 450 , y: (self.joelM?.position.y)! + 450)
                
            case 5:
                enemy.position = CGPoint(x: (self.joelM?.position.x)!  + 450 , y: (self.joelM?.position.y)! + 450)
            
                
            default:
                enemy.position = CGPoint(x: (self.joelM?.position.x)!  + 450 , y: (self.joelM?.position.y)! + 450)
        }
        
        if (self.joelM?.position.x)! < CGFloat(19800)
        {
            
            self.enemies.append(enemy)
            self.map.addChild(enemy)
            
        }
        
        
    }
    
    
    
    func AddScore(value: Int)
    {
        
        self.CoinsTemp = self.CoinsTemp + value
        
        self.CoinsSaved = self.CoinsSaved  + value
        self.labelScore?.text = String.localizedStringWithFormat("%i", self.CoinsSaved)
        self.labelScore?.run(SKAction.sequence([SKAction.scale(to: 1.5 , duration: 0.1),
                                                SKAction.scale(to: 1.0 , duration: 0.1)]))
        
        UserDefaults.standard.set(self.CoinsSaved, forKey: "score")
        
    }

    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if !jump && countJump < 2
        {
            self.joelM?.physicsBody?.velocity = CGVector(dx: (self.joelM?.physicsBody?.velocity.dx)! , dy: 700)
            jump = true
            countJump += 1
        }
    }
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        jump = false
    }
    
    
    override func update(_ currentTime: TimeInterval)
    {
        if !self.loser || !self.winer
        {
        
            if SuperPower
            {
                
                if !jump && (self.joelM?.position.y)! < self.frame.minY + 280
                {
                    self.joelM?.physicsBody?.velocity = CGVector(dx: 450 , dy: (self.joelM?.physicsBody?.velocity.dy)!)
                }
                else
                {
                    self.joelM?.physicsBody?.velocity = CGVector(dx: 400 , dy: (self.joelM?.physicsBody?.velocity.dy)!)
                }
                
            }
            else
            {
                
                if !jump && (self.joelM?.position.y)! < self.frame.minY + 280
                {
                    self.joelM?.physicsBody?.velocity = CGVector(dx: 150 , dy: (self.joelM?.physicsBody?.velocity.dy)!)
                }
                else
                {
                    self.joelM?.physicsBody?.velocity = CGVector(dx: 200 , dy: (self.joelM?.physicsBody?.velocity.dy)!)
                }
                
                
            }
            
            
            let playerIndex : CGPoint = self.map.index(for: self.joelM!.position)
            
            self.map.cullAroundIndexX(Int(playerIndex.x) , indexY: Int(playerIndex.y) , columnWidth: 180, rowHeight: 70)
            
            self.map.update()
            
            
            if (self.joelM?.position.y)! < CGFloat(-850)
            {
                // LOSE PLAYER
                self.Lose(type: 0)
            }
            
            
            if (self.joelM?.position.x)! > CGFloat(20800)
            {
                // WIN PLAYER
                self.Win(type: 0)
            }
            
            
            
            for enemy in enemies
            {
                enemy.updateEnemy(delta: currentTime , positionXPlayer: (self.joelM?.position.x)!)
            }
            
            for coin in coins
            {
                coin.updateCoin(delta: currentTime , positionXPlayer: (self.joelM?.position.x)!)
            }
            
            
            if CoinsTemp > 20
            {
                CoinsTemp = 0
                
                if !self.SuperPower
                {
                    self.PowerModeOn()
                }
            }
            
        }
        
        
    }
    
    
    //MARK: ANIMACIONES PLAYER
    
    
    func initialAnimationJoel()
    {
        // Joel
        let joelAnimatedAtlas : SKTextureAtlas = SKTextureAtlas(named: "joelScore.atlas")
        var joelsFrames = [SKTexture]()
        
        for i in 1 ..< 7
        {
            let joelTextureName = "\(i).png"
            joelsFrames.append(joelAnimatedAtlas.textureNamed(joelTextureName))
        }
        
        self.joelFrames = joelsFrames
        
        let tempJ : SKTexture = self.joelFrames[0]
        
        // Run
        let joelAnimatedAtlasRun : SKTextureAtlas = SKTextureAtlas(named: "JoelRun.atlas")
        var joelsFramesRun = [SKTexture]()
        
        for i in 1 ..< 7
        {
            let joelTextureNameRun = "\(i).png"
            joelsFramesRun.append(joelAnimatedAtlasRun.textureNamed(joelTextureNameRun))
        }
        
        self.joelFramesRun = joelsFramesRun
        self.joelM = SKSpriteNode(texture: tempJ)
        
        
        let run = SKAction.repeatForever(SKAction.animate(with: self.joelFramesRun, timePerFrame: 0.1, resize: false, restore: true))
        
        let cabeza = SKAction.repeatForever(SKAction.animate(with: self.joelFrames, timePerFrame: 0.1, resize: false, restore: true))
        
        
        self.joelM?.run(SKAction.group([run , cabeza]))
        
    }

    
    
    func PowerModeOn()
    {
        
        
        self.backgroundMusicPlayer.pause()
        self.SuperPower = true
        self.joelM?.removeAllActions()
        
        
        TempPower = Timer.scheduledTimer(timeInterval: 15 , target: self, selector: #selector(PowerModeOff), userInfo: nil, repeats: false)
        
        MultiplicateEnemiesTimer = Timer.scheduledTimer(timeInterval: 0.5 , target: self, selector: #selector(MoreEnemies), userInfo: nil, repeats: true)
        
        
        let joelPowerAtlas : SKTextureAtlas = SKTextureAtlas(named: "power.atlas")
        var joelsFramesPower = [SKTexture]()
        
        for i in 1 ..< 24
        {
            joelsFramesPower.append(joelPowerAtlas.textureNamed("\(i).png"))
        }
        
        self.joelFramesRun = joelsFramesPower
        let powerBall = SKAction.animate(with: joelsFramesPower , timePerFrame: 0.005, resize: false, restore: true)
        
        
        // Run
        let joelAnimatedAtlasRun : SKTextureAtlas = SKTextureAtlas(named: "powerHulk.atlas")
        var joelsFramesPowerHulk = [SKTexture]()
        
        
        for i in 1 ..< 7
        {
            joelsFramesPowerHulk.append(joelAnimatedAtlasRun.textureNamed("H\(i).png"))
        }
        
        
        let run = SKAction.repeatForever(SKAction.animate(with: joelsFramesPowerHulk, timePerFrame: 0.1, resize: false, restore: true))
        
        let jump = SKAction.applyImpulse(CGVector(dx: (self.joelM?.physicsBody?.velocity.dx)! , dy: 700)
, duration: 0.5)
        
        let scale = SKAction.scale(to: 1.8, duration: 0.5)
        let group = SKAction.group([powerBall , scale , run])
        
        self.joelM?.run(SKAction.sequence([jump , group]))
        
    }
    
    
    
    func PowerModeOff()
    {
        self.SuperPower = false
        self.joelM?.setScale(0.9)
        self.joelM?.removeAllActions()
        self.backgroundMusicPlayer.play()
        
        self.MultiplicateEnemiesTimer.invalidate()
        
    }

    
    //MARK: Win & Lose
    
    
    func Win(type: Int)
    {
        
        if type == 0
        {
            self.backgroundMusicPlayer.stop()
            self.winer = true
            
            UserDefaults.standard.set(true , forKey: "nivel-1-completed")
            
            
            let music = SKAction.playSoundFileNamed("level-complete.mp3", waitForCompletion: false)
            self.run(music)
            
            Utils().delayWithSeconds(3, completion:
                {
                    //PLAYER ANIMATION
                    
                    self.AddScore(value: 25)
                    self.AddScore(value: 25)
                    self.AddScore(value: 25)
                    self.AddScore(value: 25)
                    
                    self.SaveEnemiesDied()
                    
                    // GO TO VIEW
                    Utils().delayWithSeconds(2, completion:
                        {
                            if let view = self.view
                            {
                                if let scene = SKScene(fileNamed: "LevelWin")
                                {
                                    scene.scaleMode = .aspectFill
                                    view.presentScene(scene)
                                }
                            }
                    })
            })
            
        }
        else
        {
         
            
        }
        
    }
    
    
    
    func Lose(type: Int)
    {
        if type == 0
        {
            self.backgroundMusicPlayer.stop()
            self.loser = true
            
            let music = SKAction.playSoundFileNamed("gameover.wav", waitForCompletion: true)
            
            let action = SKAction.colorize(with: UIColor.white, colorBlendFactor: 0.4, duration: 0.5)
            
            let seq = SKAction.sequence([music , action])
            
            self.joelM?.run(seq, completion:
            {
                self.backgroundMusicPlayer.stop()
                if let view = self.view
                {
                    if let scene = SKScene(fileNamed: "ReStart")
                    {
                        scene.scaleMode = .aspectFill
                        view.presentScene(scene)
                    }
                }
            })
            
            
            
        }
        else if type == 1
        {
            self.backgroundMusicPlayer.stop()
            
            if let view = self.view
            {
                if let scene = SKScene(fileNamed: "ReStart")
                {
                    scene.scaleMode = .aspectFill
                    view.presentScene(scene)
                }
            }
        }
    }
    
    
    
    func SaveEnemiesDied()
    {
        var Goomba : Int = UserDefaults.standard.integer(forKey: "GoombaDied")
        var Misil : Int = UserDefaults.standard.integer(forKey: "MisilDied")
        
        Goomba = Goomba + TempGoomba
        Misil = Misil + TempMisil

        
        UserDefaults.standard.set(TempGoomba, forKey: "TempGoombaDied")
        UserDefaults.standard.set(TempMisil, forKey: "TempMisilDied")
        
        UserDefaults.standard.set(Goomba, forKey: "GoombaDied")
        UserDefaults.standard.set(Misil, forKey: "MisilDied")
        

    }
    
    

}











