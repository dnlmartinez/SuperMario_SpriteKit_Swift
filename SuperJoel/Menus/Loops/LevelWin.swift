//
//  LevelWin.swift
//  SuperJoel
//
//  Created by daniel martinez gonzalez on 21/6/17.
//  Copyright © 2017 daniel martinez gonzalez. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation


class LevelWin : SKScene
{
    
    private var joelM : SKSpriteNode?
    
    var joelFrames : [SKTexture]!
    var joelFramesRun : [SKTexture]!

    var cryFrames : [SKTexture]!
    private var cry : SKSpriteNode?
    
    
    
    var labelScore1 : SKLabelNode?
    var labelScore2 : SKLabelNode?
    var labelScore3 : SKLabelNode?
    
    var enemy1 : SKSpriteNode?
    var enemy2 : SKSpriteNode?
    var enemy3 : SKSpriteNode?
    
    var stripe1 : SKSpriteNode?
    var stripe2 : SKSpriteNode?
    var stripe3 : SKSpriteNode?
    
    var fondoB1 : SKSpriteNode?
    var fondoB2 : SKSpriteNode?
    var fondoB3 : SKSpriteNode?

    var fondoW1 : SKSpriteNode?
    var fondoW2 : SKSpriteNode?
    var fondoW3 : SKSpriteNode?
    
    
    var backgroundMusicPlayer = AVAudioPlayer()
    
    override func didMove(to view: SKView){
        self.playBackgroundMusic()
        self.initialAnimationJoel()
        self.initSKNodes()
    }
    
    
    
    func initSKNodes(){
        
        self.labelScore1 = self.childNode(withName: "labelNum1") as? SKLabelNode
        self.labelScore2 = self.childNode(withName: "labelNum2") as? SKLabelNode
        self.labelScore3 = self.childNode(withName: "labelNum3") as? SKLabelNode
        
        self.enemy1 = self.childNode(withName: "enemy1") as? SKSpriteNode
        self.enemy2 = self.childNode(withName: "enemy2") as? SKSpriteNode
        self.enemy3 = self.childNode(withName: "enemy3") as? SKSpriteNode
        self.stripe1 = self.childNode(withName: "stripe1") as? SKSpriteNode
        self.stripe2 = self.childNode(withName: "stripe2") as? SKSpriteNode
        self.stripe3 = self.childNode(withName: "stripe3") as? SKSpriteNode
        self.fondoB1 = self.childNode(withName: "fondoB1") as? SKSpriteNode
        self.fondoB2 = self.childNode(withName: "fondoB2") as? SKSpriteNode
        self.fondoB3 = self.childNode(withName: "fondoB3") as? SKSpriteNode
        self.fondoW1 = self.childNode(withName: "fondoW1") as? SKSpriteNode
        self.fondoW2 = self.childNode(withName: "fondoW2") as? SKSpriteNode
        self.fondoW3 = self.childNode(withName: "fondoW3") as? SKSpriteNode
        
        let NivelSelected = UserDefaults.standard.integer(forKey: "mundoSelected")
        
        if NivelSelected == 1 || NivelSelected == 2{
           self.enemy3?.isHidden = true
           self.stripe3?.isHidden = true
           self.fondoB3?.isHidden = true
           self.fondoW3?.isHidden = true
           self.labelScore3?.isHidden = true
            
           let G = UserDefaults.standard.integer(forKey: "TempGoombaDied")
           let M = UserDefaults.standard.integer(forKey: "TempMisilDied")
            
           self.labelScore1?.text = "\(G)"
           self.labelScore2?.text = "\(M)"
           
           self.enemy1?.texture = SKTexture(imageNamed: "GoombaS")
           self.enemy2?.texture = SKTexture(imageNamed: "misil")
            
        }
        
    }
    
    
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
        
        
        self.joelM?.setScale(3.9)
        self.joelM?.zPosition = 8
        self.joelM?.position = CGPoint(x: self.frame.minX + 200 , y: self.frame.maxY - 340)
        
        self.addChild(joelM!)
        
    }

    
    func playBackgroundMusic() -> (){
        
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
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){
        let touch : UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let name = touchedNode.name{
            if name == "btMenu"{
                
                self.run(SKAction.playSoundFileNamed("powerup", waitForCompletion: false))
                
                if let view = self.view{
                    
                    if let scene = SKScene(fileNamed: "SceneMenuSelect"){
                        scene.scaleMode = .aspectFill
                        view.presentScene(scene)
                    }
                }
            }else if name == "btContinue"{
                
                self.run(SKAction.playSoundFileNamed("powerup", waitForCompletion: false))
                
                if let view = self.view{
                    var nameNivel : String = "Mundo_1_Nivel_"
                    var NivelSelected = UserDefaults.standard.integer(forKey: "mundoSelected")
                    NivelSelected += 1
                    UserDefaults.standard.set(NivelSelected, forKey: "mundoSelected")
                    
                    nameNivel = nameNivel + "\(NivelSelected)"

                    if let scene = SKScene(fileNamed: nameNivel){
                        scene.scaleMode = .aspectFill
                        view.presentScene(scene)
                    }
                }
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?){
    }
    
    override func update(_ currentTime: TimeInterval){
    }
    
}

