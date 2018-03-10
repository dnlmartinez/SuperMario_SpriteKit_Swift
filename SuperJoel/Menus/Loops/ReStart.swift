//
//  ReStart.swift
//  SuperJoel
//
//  Created by daniel martinez gonzalez on 4/6/17.
//  Copyright © 2017 daniel martinez gonzalez. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation


class ReStart: SKScene
{
    
    
    var cryFrames : [SKTexture]!
    private var cry : SKSpriteNode?
    
    
    var backgroundMusicPlayer = AVAudioPlayer()
    
    override func didMove(to view: SKView)
    {
        self.playBackgroundMusic()
        
        let cryAtlas : SKTextureAtlas = SKTextureAtlas(named: "cryAtlas.atlas")
        var cryFrames = [SKTexture]()
        
        for i in 1 ..< 5
        {
            let cryTextureName = "Cry\(i).png"
            cryFrames.append(cryAtlas.textureNamed(cryTextureName))
        }
        
        self.cryFrames = cryFrames
        self.cry = self.childNode(withName: "cry") as? SKSpriteNode
        self.cry?.setScale(1.9)
        self.cry?.zPosition = 8
        
        self.cry?.run( SKAction.repeatForever(SKAction.animate(with: self.cryFrames, timePerFrame: 0.2, resize: false, restore: true)), withKey:"crying")
        
        
        
        
    }
    
    
    func playBackgroundMusic() -> ()
    {
        
        let backgroundMusicURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: "mario-theme-2", ofType: "mp3")!)
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
            if name == "btRestart"
            {
                
                self.run(SKAction.playSoundFileNamed("powerup", waitForCompletion: false))
                
                if let view = self.view
                {
                    
                    var nameNivel : String = "Mundo_1_Nivel_"
                    let NivelSelected = UserDefaults.standard.integer(forKey: "mundoSelected")
                    
                    nameNivel = nameNivel + "\(NivelSelected)"
                    
                    if let scene = SKScene(fileNamed: nameNivel)
                    {
                        scene.scaleMode = .aspectFill
                        view.presentScene(scene)
                    }
                }
            }
            else if name == "btMenu"
            {
             
                self.run(SKAction.playSoundFileNamed("powerup", waitForCompletion: false))
                
                if let view = self.view
                {
                    if let scene = SKScene(fileNamed: "SceneMenu")
                    {
                        scene.scaleMode = .aspectFill
                        view.presentScene(scene)
                    }
                }
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
