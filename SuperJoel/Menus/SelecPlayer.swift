//
//  SelectPlayer.swift
//  SuperJoel
//
//  Created by daniel martinez gonzalez on 7/7/17.
//  Copyright © 2017 daniel martinez gonzalez. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import AVFoundation


class SelecPlayer: SKScene
{
    
    private var tubeGreen : SKSpriteNode?
    
    
    
    private var joelM : SKSpriteNode?
    var joel : SKSpriteNode!
    var joelFrames : [SKTexture]!
    
    
    
    var backgroundMusicPlayer = AVAudioPlayer()
    
    
    
    override func didMove(to view: SKView)
    {
        
        
        
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
                                if let scene = SKScene(fileNamed: "SceneMenu")
                                {
                                    scene.scaleMode = .aspectFill
                                    view.presentScene(scene)
                                }
                            }
                    })
                    
                    
                }
                
                
                
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
        
    }
    
    
}
