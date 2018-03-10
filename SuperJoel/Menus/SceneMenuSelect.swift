//
//  SceneMenuSelect.swift
//  SuperJoel
//
//  Created by daniel martinez gonzalez on 5/4/17.
//  Copyright © 2017 daniel martinez gonzalez. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import AVFoundation



class SceneMenuSelect: SKScene
{
    
    private var labelExtra : SKSpriteNode?
    private var joelM : SKSpriteNode?
    
    var backgroundMusicPlayer = AVAudioPlayer()
    
    var joel : SKSpriteNode!
    var joelFrames : [SKTexture]!
    var labelScore : SKLabelNode?

    var CoinsSaved : Int = 0
    
    var BTmenu1 : SKSpriteNode?
    var BTmenu2 : SKSpriteNode?
    var BTmenu3 : SKSpriteNode?
    var BTmenu4 : SKSpriteNode?
    var BTmenu5 : SKSpriteNode?
    var BTmenu6 : SKSpriteNode?
    
    var N1Enabled : Bool = false
    var N2Enabled : Bool = false
    var N3Enabled : Bool = false
    var N4Enabled : Bool = false
    var N5Enabled : Bool = false
    var N6Enabled : Bool = false
    

    override func didMove(to view: SKView)
    {
        
        N1Enabled = UserDefaults.standard.bool(forKey: "nivel-1-completed")
        N2Enabled = UserDefaults.standard.bool(forKey: "nivel-2-completed")
        N3Enabled = UserDefaults.standard.bool(forKey: "nivel-3-completed")
        N4Enabled = UserDefaults.standard.bool(forKey: "nivel-4-completed")
        N5Enabled = UserDefaults.standard.bool(forKey: "nivel-5-completed")
        N6Enabled = UserDefaults.standard.bool(forKey: "nivel-6-completed")
        

        
        self.CoinsSaved = UserDefaults.standard.value(forKey: "score") as! Int
        
        self.labelScore = self.childNode(withName: "labelScore") as? SKLabelNode
        self.labelScore?.text = String.localizedStringWithFormat("%i", self.CoinsSaved)
        self.labelScore?.fontSize = 30
        self.labelScore?.name = "labelScore"
        
        
        // Button Niveles
        
        self.BTmenu1 = self.childNode(withName: "nivel1") as? SKSpriteNode
        
        
        if N1Enabled
        {
            self.BTmenu2 = self.childNode(withName: "nivel2") as? SKSpriteNode
            self.BTmenu2?.texture = SKTexture(imageNamed: "Nivel2")
            self.BTmenu2?.setScale(0.35)
        }
        
        if N2Enabled
        {
            self.BTmenu3 = self.childNode(withName: "nivel3") as? SKSpriteNode
            self.BTmenu3?.texture = SKTexture(imageNamed: "Nivel3")
            self.BTmenu3?.setScale(0.35)
        }
        
        if N3Enabled
        {
            self.BTmenu4 = self.childNode(withName: "nivel4") as? SKSpriteNode
            self.BTmenu4?.texture = SKTexture(imageNamed: "Nivel4")
            self.BTmenu4?.setScale(0.35)
        }
        
        if N4Enabled
        {
            self.BTmenu5 = self.childNode(withName: "nivel5") as? SKSpriteNode
            self.BTmenu5?.texture = SKTexture(imageNamed: "Nivel5")
            self.BTmenu5?.setScale(0.35)
        }
        
        if N5Enabled
        {
            self.BTmenu6 = self.childNode(withName: "nivel6") as? SKSpriteNode
            self.BTmenu6?.texture = SKTexture(imageNamed: "Nivel6")
            self.BTmenu6?.setScale(0.35)
        }
        
        
        
        
        
        
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
        self.joelM?.zPosition = 8
        self.joelM?.position = CGPoint(x: self.frame.minX + 90 , y: self.frame.maxY - 140)
        self.joelM?.run( SKAction.repeatForever(SKAction.animate(with: self.joelFrames, timePerFrame: 0.1, resize: false, restore: true)), withKey:"JoelMarcador")
        
        
        
//        self.labelExtra = SKSpriteNode(imageNamed: "LabelTubeGreen")
//        self.labelExtra?.zPosition = 1
//        self.labelExtra?.position = CGPoint(x: self.frame.midX - 275 , y: self.frame.minY + 160)
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
        
        DispatchQueue.main.async
        {
//                self.addChild(self.labelExtra!)
                self.addChild(self.joelM!)
        }

    }
    
    
    func playBackgroundMusic() -> ()
    {
        
        let backgroundMusicURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: "menu-2", ofType: "mp3")!)
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
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch : UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        
        
        
        if let name = touchedNode.name
        {
            if name == "tubeBack"
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
                            if let scene = SKScene(fileNamed: "SceneMenu")
                            {
                                scene.scaleMode = .aspectFill
                                view.presentScene(scene)
                            }
                        }
                })
                
            }
            
            if name == "nivel1"
            {
                
                UserDefaults.standard.set(1, forKey: "mundoSelected")
                
                let nivel = touchedNode
                
                let music = SKAction.playSoundFileNamed("tube.wav", waitForCompletion: false)
                let scaleIn = SKAction.scale(by: 1.2 , duration: 0.2)
                let scaleOut = SKAction.scale(by: 0.8 , duration: 0.2)

                let seq = SKAction.sequence([music , scaleIn , scaleOut])
                
                nivel.run(seq, completion:
                {
                        if let view = self.view
                        {
                            if let scene = SKScene(fileNamed: "Mundo_1_Nivel_1")
                            {
                                scene.scaleMode = .aspectFill
                                view.presentScene(scene)
                            }
                        }
                })
            

            }

            
            
            if name == "nivel2"  && N1Enabled
            {
                
                UserDefaults.standard.set(2, forKey: "mundoSelected")
                
                let nivel = touchedNode
                
                let music = SKAction.playSoundFileNamed("tube.wav", waitForCompletion: false)
                let scaleIn = SKAction.scale(by: 1.2 , duration: 0.2)
                let scaleOut = SKAction.scale(by: 0.8 , duration: 0.2)
                
                let seq = SKAction.sequence([music , scaleIn , scaleOut])
                
                nivel.run(seq, completion:
                    {
                        if let view = self.view
                        {
                            if let scene = SKScene(fileNamed: "Mundo_1_Nivel_2")
                            {
                                scene.scaleMode = .aspectFill
                                view.presentScene(scene)
                            }
                        }
                })
                
                
            }
            
            if name == "nivel3"  && N2Enabled
            {
                
                UserDefaults.standard.set(3, forKey: "mundoSelected")
                
                let nivel = touchedNode
                
                let music = SKAction.playSoundFileNamed("tube.wav", waitForCompletion: false)
                let scaleIn = SKAction.scale(by: 1.2 , duration: 0.2)
                let scaleOut = SKAction.scale(by: 0.8 , duration: 0.2)
                
                let seq = SKAction.sequence([music , scaleIn , scaleOut])
                
                nivel.run(seq, completion:
                    {
                        if let view = self.view
                        {
                            if let scene = SKScene(fileNamed: "Mundo_1_Nivel_3")
                            {
                                scene.scaleMode = .aspectFill
                                view.presentScene(scene)
                            }
                        }
                })
                
                
            }

            
            if name == "nivel4"  && N3Enabled
            {
                
                UserDefaults.standard.set(4, forKey: "mundoSelected")
                
                let nivel = touchedNode
                
                let music = SKAction.playSoundFileNamed("tube.wav", waitForCompletion: false)
                let scaleIn = SKAction.scale(by: 1.2 , duration: 0.2)
                let scaleOut = SKAction.scale(by: 0.8 , duration: 0.2)
                
                let seq = SKAction.sequence([music , scaleIn , scaleOut])
                
                nivel.run(seq, completion:
                    {
                        if let view = self.view
                        {
                            if let scene = SKScene(fileNamed: "Mundo_1_Nivel_4")
                            {
                                scene.scaleMode = .aspectFill
                                view.presentScene(scene)
                            }
                        }
                })
                
                
            }

            if name == "nivel5"  && N4Enabled
            {
                
                UserDefaults.standard.set(5, forKey: "mundoSelected")
                
                let nivel = touchedNode
                
                let music = SKAction.playSoundFileNamed("tube.wav", waitForCompletion: false)
                let scaleIn = SKAction.scale(by: 1.2 , duration: 0.2)
                let scaleOut = SKAction.scale(by: 0.8 , duration: 0.2)
                
                let seq = SKAction.sequence([music , scaleIn , scaleOut])
                
                nivel.run(seq, completion:
                    {
                        if let view = self.view
                        {
                            if let scene = SKScene(fileNamed: "Mundo_1_Nivel_5")
                            {
                                scene.scaleMode = .aspectFill
                                view.presentScene(scene)
                            }
                        }
                })
                
                
            }
            
            if name == "nivel6"  && N5Enabled
            {
                
                UserDefaults.standard.set(6, forKey: "mundoSelected")
                
                let nivel = touchedNode
                
                let music = SKAction.playSoundFileNamed("tube.wav", waitForCompletion: false)
                let scaleIn = SKAction.scale(by: 1.2 , duration: 0.2)
                let scaleOut = SKAction.scale(by: 0.8 , duration: 0.2)
                
                let seq = SKAction.sequence([music , scaleIn , scaleOut])
                
                nivel.run(seq, completion:
                    {
                        if let view = self.view
                        {
                            if let scene = SKScene(fileNamed: "Mundo_1_Nivel_6")
                            {
                                scene.scaleMode = .aspectFill
                                view.presentScene(scene)
                            }
                        }
                })
                
                
            }




            
            
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        // Called before each frame is rendered
    }
}
