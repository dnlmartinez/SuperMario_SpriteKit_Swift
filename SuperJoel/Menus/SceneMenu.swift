//
//  SceneMenu.swift
//  SuperJoel
//
//  Created by daniel martinez gonzalez on 27/3/17.
//  Copyright © 2017 daniel martinez gonzalez. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation


class SceneMenu: SKScene
{
    private var tubeRed : SKSpriteNode?
    private var tubeGreen : SKSpriteNode?
    private var champiBatman : SKSpriteNode?
    private var champiPrince : SKSpriteNode?
    private var joelM : SKSpriteNode?
    private var labelGame : SKSpriteNode?
    private var labelExtra : SKSpriteNode?

    
    private var viewBlur : SKSpriteNode?
    private var btClose : SKSpriteNode?
    
    private var labelScore : SKLabelNode?
    
    var backgroundMusicPlayer = AVAudioPlayer()
    
    var coin : SKSpriteNode!
    var coinFrames : [SKTexture]!
    
    var Coins : Array<SKSpriteNode> = Array<SKSpriteNode>()
    
    let arrayX : NSArray = ["-259" , "-259" , "259" , "259" , "-280" , "280" , "280"]
    let ArrayY : NSArray = ["131" , "-38" , "136" , "-38" , "-220" , "-220" , "-220"]
    
    let textNames : [String] = ["1T.png" , "2T.png" , "3T.png" , "4T.png" , "5T.png"]
    var textIndex : Int = 1
    
    
    var CoinsSaved : Int = 0
    
    var joel : SKSpriteNode!
    var joelFrames : [SKTexture]!
    
    
    override func didMove(to view: SKView)
    {
        
        
        self.CoinsSaved = UserDefaults.standard.value(forKey: "score") as! Int
        
        self.viewBlur = self.childNode(withName: "viewBlur") as? SKSpriteNode
        self.viewBlur?.isHidden = true
        
        
        self.btClose = self.childNode(withName: "btClose") as? SKSpriteNode
        
        
        self.playBackgroundMusic()
        
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
        
        self.joelM = SKSpriteNode(texture: tempJ)
        self.joelM?.setScale(0.9)
        self.joelM?.position = CGPoint(x: self.frame.minX + 90 , y: self.frame.maxY - 140)
        self.joelM?.run( SKAction.repeatForever(SKAction.animate(with: self.joelFrames, timePerFrame: 0.1, resize: false, restore: true)), withKey:"JoelMarcador")
        
        // Title Image Game
        
        self.tubeRed = SKSpriteNode(imageNamed: "tubeRed")
        self.tubeRed?.zPosition = 1
        self.tubeRed?.position = CGPoint(x: self.frame.midX - 100 , y: self.frame.minY + 30)
        self.tubeRed?.alpha = 0.0
        self.tubeRed?.setScale(1.5)
        self.tubeRed?.name = "tubeRed"
        
        if let tubeRed = self.tubeRed
        {
            
            tubeRed.run(SKAction.sequence([SKAction.moveTo(y: -200 , duration: 0.0),
                                            SKAction.fadeIn(withDuration: 0.0),
                                            SKAction.moveTo(y: self.frame.minY + 30, duration: 0.5)]))
        }

        
        self.tubeGreen = SKSpriteNode(imageNamed: "tubeGreen")
        self.tubeGreen?.zPosition = 1
        self.tubeGreen?.position = CGPoint(x: self.frame.midX + 100 , y: self.frame.minY + 30)
        self.tubeGreen?.alpha = 0.0
        self.tubeGreen?.setScale(1.5)
        self.tubeGreen?.name = "tubeGreen"
        
        if let tubeGreen = self.tubeGreen
        {
            
            tubeGreen.run(SKAction.sequence([SKAction.moveTo(y: -200 , duration: 0.0),
                                           SKAction.fadeIn(withDuration: 0.0),
                                           SKAction.moveTo(y: self.frame.minY + 30, duration: 0.5)]))
        }
        
        
//        // LABELS 
//        
//        self.labelGame = SKSpriteNode(imageNamed: "LabelTubeRed")
//        self.labelGame?.zPosition = 1
//        self.labelGame?.position = CGPoint(x: self.frame.midX - 100 , y: self.frame.minY + 130)
//        self.labelGame?.setScale(3.0)
//        self.labelGame?.name = "LabelGame"
//        
//        if let label = self.labelGame
//        {
//            label.alpha = 0.0
//            label.run(SKAction.group([SKAction.wait(forDuration: 0.8),
//                                      SKAction.repeatForever(SKAction.sequence([SKAction.fadeIn(withDuration: 2.0),
//                                                                SKAction.wait(forDuration: 0.5),
//                                                                SKAction.fadeOut(withDuration: 0.5)]))]))
//        }
//        
//        
//        self.labelExtra = SKSpriteNode(imageNamed: "LabelTubeGreen")
//        self.labelExtra?.zPosition = 1
//        self.labelExtra?.position = CGPoint(x: self.frame.midX + 100 , y: self.frame.minY + 135)
//        self.labelExtra?.setScale(3.0)
//        self.labelExtra?.name = "labelExtra"
//        
//        if let label = self.labelExtra
//        {
//            label.alpha = 0.0
//            label.run(SKAction.group([SKAction.wait(forDuration: 0.8),
//                                      SKAction.repeatForever(SKAction.sequence([SKAction.fadeIn(withDuration: 2.0),
//                                                                                SKAction.wait(forDuration: 0.5),
//                                                                                SKAction.fadeOut(withDuration: 0.5)]))]))
//        }
        

        self.labelScore = self.childNode(withName: "labelScore") as? SKLabelNode
        self.labelScore?.text = String.localizedStringWithFormat("%i", self.CoinsSaved)
        self.labelScore?.fontSize = 30
        self.labelScore?.name = "labelScore"

        
        self.champiBatman = SKSpriteNode(imageNamed: "champiBatman")
        self.champiBatman?.zPosition = 1
        self.champiBatman?.position = CGPoint(x: self.frame.midX , y: self.frame.midY - 210)
        self.champiBatman?.setScale(1.6)
        self.champiBatman?.name = "champiBatman"
        
        self.champiPrince = SKSpriteNode(imageNamed: "champiPrince")
        self.champiPrince?.zPosition = 1
        self.champiPrince?.position = CGPoint(x: self.frame.midX  , y: self.frame.midY + 100)
        self.champiPrince?.setScale(1.6)
        self.champiPrince?.name = "champiPrince"

        
        DispatchQueue.main.async
        {
                self.addChild(self.tubeRed!)
                self.addChild(self.tubeGreen!)
                //self.addChild(self.labelGame!)
                //self.addChild(self.labelExtra!)
            
                self.addChild(self.champiBatman!)
                self.addChild(self.champiPrince!)
            
                self.addChild(self.joelM!)
        }
        
        DispatchQueue.main.async
        {
            // Coins
            let coinAnimatedAtlas : SKTextureAtlas = SKTextureAtlas(named: "coins.atlas")
            var coinsFrames = [SKTexture]()
            
            for i in 1 ..< 14
            {
                let coinTextureName = "\(i).png"
                coinsFrames.append(coinAnimatedAtlas.textureNamed(coinTextureName))
            }
            
            self.coinFrames = coinsFrames

            
            let temp : SKTexture = self.coinFrames[0]
            
            for var i in 0 ..< 6
            {
                let posx = Int(self.arrayX.object(at: i) as! String)
                let posy = Int(self.ArrayY.object(at: i) as! String)
                let coin = SKSpriteNode(texture: temp)
                
                coin.setScale(0.6)
                coin.position = CGPoint(x: posx!, y: posy!)
                coin.run( SKAction.repeatForever(SKAction.animate(with: self.coinFrames, timePerFrame: 0.1, resize: false, restore: true)), withKey:"walkingInPlaceBear")
                
                self.addChild(coin)
                self.Coins.append(coin)
            }
            
            
        }
        
        
    }
    
    
    
    func playBackgroundMusic() -> ()
    {
        
        let backgroundMusicURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: "SelectGame", ofType: "mp3")!)
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

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch : UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        var touchedNode = self.atPoint(positionInScene)
        
        if let name = touchedNode.name
        {
            if name == "tubeGreen" || name == "tubeRed" || name == "labelExtra" || name == "labelGame"
            {
                
                    if name == "tubeGreen"
                    {
                        let tube = touchedNode
                        
                        let music = SKAction.playSoundFileNamed("tube.wav", waitForCompletion: false)
                        let scaleIn = SKAction.scale(by: 1.2 , duration: 0.2)
                        let scaleOut = SKAction.scale(by: 0.8 , duration: 0.2)
                        
                        let seq = SKAction.sequence([music , scaleIn , scaleOut])
                        
                        tube.run(seq, completion:
                        {
                                if let view = self.view
                                {
                                    if let scene = SKScene(fileNamed: "SceneMenuSelect")
                                    {
                                        scene.scaleMode = .aspectFill
                                        view.presentScene(scene)
                                    }
                                }
                        })

                        
                    }

                if name == "tubeRed"
                {
                    let tube = touchedNode
                    
                    let music = SKAction.playSoundFileNamed("tube.wav", waitForCompletion: false)
                    let scaleIn = SKAction.scale(by: 1.2 , duration: 0.2)
                    let scaleOut = SKAction.scale(by: 0.8 , duration: 0.2)
                    
                    let seq = SKAction.sequence([music , scaleIn , scaleOut])
                    
                    tube.run(seq, completion:
                        {
                            if let view = self.view
                            {
                                if let scene = SKScene(fileNamed: "SelecPlayer")
                                {
                                    scene.scaleMode = .aspectFill
                                    view.presentScene(scene)
                                }
                            }
                    })
                    
                }

                
                
            }
        }
        
        
        for coin in self.Coins
        {
            if coin == touchedNode
            {
                
                let action1 = SKAction.sequence([SKAction.scale(to: 0.9 , duration: 0.1),
                                                SKAction.scale(to: 0.6 , duration: 0.1)])
                
                let music = SKAction.playSoundFileNamed("coin.wav", waitForCompletion: false)
                
            
                coin.run(SKAction.group([action1 , music]))
                
                self.AddScore(value: 1)
                
                let when = DispatchTime.now() + 0.2
                DispatchQueue.main.asyncAfter(deadline: when)
                {
                    coin.removeFromParent()
                }
                
            }
            
        }
        
        
        
        if let name = touchedNode.name
        {
            if name == "champiBatman" || name == "champiPrince"
            {
                let action1 = SKAction.sequence([SKAction.scale(to: 2.0 , duration: 0.1),
                                                 SKAction.scale(to: 1.6 , duration: 0.1)])
                
                let music = SKAction.playSoundFileNamed("jump.wav", waitForCompletion: false)
                
                
                if name == "champiBatman"
                {
                    let emitter = SKEmitterNode(fileNamed: "MyParticle.sks")
                    emitter?.targetNode = self
                    
                    
                    let actionParticle = SKAction.run
                    {
                        touchedNode.addChild(emitter!)
                    }
                    
                    let actionParticle2 = SKAction.run
                    {
                        touchedNode.removeAllChildren()
                    }
                    
                    let wait = SKAction.wait(forDuration: 0.5)
                    
                    touchedNode.run(SKAction.sequence([SKAction.group([actionParticle , action1 , music]) , wait , actionParticle2 ]))
                }
                else
                {
                    touchedNode.run(SKAction.group([action1 , music]))

                }
            }
            else if name == "textos"
            {
                let music = SKAction.playSoundFileNamed("coin.wav", waitForCompletion: false)
                let action1 = SKAction.fadeOut(withDuration: 0.2)
                let action2 = SKAction.fadeIn(withDuration: 0.2)
                let action3 = SKAction.setTexture(SKTexture(imageNamed: self.textNames[textIndex]))
                let seq = SKAction.sequence([action1 , action3 , action2])
                
                touchedNode.run(SKAction.group([music , seq]))
                
                self.AddScore(value: 10)
                
                textIndex += 1
                
                if textIndex > 4
                {
                    textIndex = 0
                }
                
            }
            
        }
        
        
        
        if let name = touchedNode.name
        {
            if name == "cajaGif"
            {
                self.viewBlur?.isHidden = false
            }
        }
        
        
        if let name = touchedNode.name
        {
            if name == "btClose"
            {
                touchedNode.run(SKAction.playSoundFileNamed("jump.wav", waitForCompletion: true))
                self.viewBlur?.isHidden = true
            }
        }

        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        // Called before each frame is rendered
    }


    func AddScore(value: Int)
    {
        
        self.CoinsSaved = self.CoinsSaved  + value
        self.labelScore?.text = String.localizedStringWithFormat("%i", self.CoinsSaved)
        self.labelScore?.run(SKAction.sequence([SKAction.scale(to: 1.5 , duration: 0.1),
                                                SKAction.scale(to: 1.0 , duration: 0.1)]))
        
        UserDefaults.standard.set(self.CoinsSaved, forKey: "score")
        
    }






}
