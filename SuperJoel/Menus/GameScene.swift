//
//  GameScene.swift
//  SuperJoel
//
//  Created by daniel martinez gonzalez on 27/3/17.
//  Copyright © 2017 daniel martinez gonzalez. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation



class GameScene: SKScene
{
    
    private var label : SKLabelNode?
    private var TitleImg : SKSpriteNode?
    private var PlayerImg : SKSpriteNode?
    var backgroundMusicPlayer = AVAudioPlayer()
    
    
    override func didMove(to view: SKView)
    {
        
        self.playBackgroundMusic()
        
        
        // Label Animate
        self.label = SKLabelNode(fontNamed: "AvenirNext-Bold")
        self.label?.text = "Pulsa para Comenzar!!"
        self.label?.fontSize = 30
        self.label?.name = "label"
        self.label?.fontColor = SKColor.white
        self.label?.zPosition = 1
        self.label?.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 60)
        
        if let label = self.label
        {
            label.alpha = 0.0
            label.run(SKAction.repeatForever(SKAction.sequence([SKAction.fadeIn(withDuration: 2.0),
                                                                SKAction.wait(forDuration: 0.5),
                                                                SKAction.fadeOut(withDuration: 2.0)])))
        }
        
        
        // Title Image Game
        
        self.TitleImg = SKSpriteNode(imageNamed: "LogoName")
        self.TitleImg?.zPosition = 1
        self.TitleImg?.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 460)
        self.TitleImg?.alpha = 0.0
        
        if let TitleImg = self.TitleImg
        {
            
            TitleImg.run(SKAction.sequence([SKAction.moveTo(x: -400 , duration: 0.0),
                                                SKAction.fadeIn(withDuration: 0.0),
                                                SKAction.moveTo(x: self.frame.midX, duration: 0.5)]))
        }

        
        // Player Image
        
        self.PlayerImg = SKSpriteNode(imageNamed: "Joel")
        self.PlayerImg?.zPosition = 1
        self.PlayerImg?.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 460)
        self.PlayerImg?.alpha = 0.0
        self.PlayerImg?.setScale(1.4)
        if let PlayerImg = self.PlayerImg
        {
            
            PlayerImg.run(SKAction.sequence([SKAction.moveTo(x: -400 , duration: 0.0),
                                            SKAction.fadeIn(withDuration: 0.0),
                                            SKAction.moveTo(x: self.frame.midX, duration: 0.5)]))
        }

        // ADD Child Nodes
        
        self.addChild(self.label!)
        self.addChild(self.TitleImg!)
        self.addChild(self.PlayerImg!)
    }
    
    
    func playBackgroundMusic() -> ()
    {
        
        let backgroundMusicURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: "menu-1", ofType: "mp3")!)
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
    
        if let view = self.view 
        {
            if let scene = SKScene(fileNamed: "SceneMenu")
            {
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
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
