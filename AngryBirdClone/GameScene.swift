//
//  GameScene.swift
//  AngryBirdClone
//
//  Created by Ali Atakan AKMAN on 1.10.2020.
//  Copyright © 2020 Ali Atakan AKMAN. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //var bird2 = SKSpriteNode()
    
    var bird = SKSpriteNode()
    var box1 = SKSpriteNode()
    var box2 = SKSpriteNode()
    var box3 = SKSpriteNode()
    var box4 = SKSpriteNode()
    var box5 = SKSpriteNode()
    var gameStarted = false
    var originalPosition: CGPoint?
    
    var score = 0
    var scorelabel = SKLabelNode()
    var lastScoreLabel = SKLabelNode()
    var lastScore = 0
    var lastScoreLabel1 = SKLabelNode()
    var bestScore = 0
    var bestScoreLabel = SKLabelNode()
    var bestScoreLabel1 = SKLabelNode()
    
    // Çarpışmaları yaparken isteğe göre oluşturuyoruz.
    enum ColliderType: UInt32 {
        case Bird = 1
        case Box = 2
    }
    
    
     
    override func didMove(to view: SKView) {
        
        //Kodlama ile ekleme bu şekilde yapılıyor.
       /* let texture = SKTexture(imageNamed: "bird")
        bird2 = SKSpriteNode(texture: texture)
        bird2.position = CGPoint(x: 0, y: 0)
        bird2.size = CGSize(width: self.frame.width / 16, height: self.frame.height / 10)
        bird2.zPosition = 1
        self.addChild(bird2) */
        
        
        
        //***************************Pyhsics Body*********************************//
        //Ekran sınırları için
        self.physicsBody = SKPhysicsBody.init(edgeLoopFrom: frame)
        self.scene?.scaleMode = .aspectFit
        self.physicsWorld.contactDelegate = self //Artık contactları algılıyoruz.
        
        //Kuşa fiziksel kütle tanımlama ve fiziksel olarak nelerden etkilenecek?
        bird = childNode(withName: "bird") as! SKSpriteNode
        let birdTexture = SKTexture(imageNamed: "bird")
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 13)
        bird.physicsBody?.affectedByGravity = false
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.mass = 0.15
        originalPosition = bird.position
        bird.physicsBody?.allowsRotation = true
        
        bird.physicsBody?.contactTestBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.categoryBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.collisionBitMask = ColliderType.Box.rawValue
        
        //***************************---Box---*********************************//
        
        let boxTexture = SKTexture(imageNamed: "brick")
        let size = CGSize(width: boxTexture.size().width / 6, height: boxTexture.size().height / 6)
        
        box1 = childNode(withName: "box1") as! SKSpriteNode
        box1.physicsBody = SKPhysicsBody(rectangleOf: size )
        box1.physicsBody?.isDynamic = true
        box1.physicsBody?.affectedByGravity = true
        box1.physicsBody?.allowsRotation = true
        box1.physicsBody?.mass = 0.2
        
        box1.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box2 = childNode(withName: "box2") as! SKSpriteNode
        box2.physicsBody = SKPhysicsBody(rectangleOf: size )
        box2.physicsBody?.isDynamic = true
        box2.physicsBody?.affectedByGravity = true
        box2.physicsBody?.allowsRotation = true
        box2.physicsBody?.mass = 0.2
        
        box2.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box3 = childNode(withName: "box3") as! SKSpriteNode
        box3.physicsBody = SKPhysicsBody(rectangleOf: size )
        box3.physicsBody?.isDynamic = true
        box3.physicsBody?.affectedByGravity = true
        box3.physicsBody?.allowsRotation = true
        box3.physicsBody?.mass = 0.2
        
        box3.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box4 = childNode(withName: "box4") as! SKSpriteNode
        box4.physicsBody = SKPhysicsBody(rectangleOf: size )
        box4.physicsBody?.isDynamic = true
        box4.physicsBody?.affectedByGravity = true
        box4.physicsBody?.allowsRotation = true
        box4.physicsBody?.mass = 0.2
        
        box4.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        
        box5 = childNode(withName: "box5") as! SKSpriteNode
        box5.physicsBody = SKPhysicsBody(rectangleOf: size )
        box5.physicsBody?.isDynamic = true
        box5.physicsBody?.affectedByGravity = true
        box5.physicsBody?.allowsRotation = true
        box5.physicsBody?.mass = 0.2
        
        box5.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        
        
        //***************************---Score Label---*********************************//
        
        
        scorelabel.fontName = "Helvetica"
        scorelabel.fontSize = 60
        scorelabel.text = "0"
        scorelabel.position = CGPoint(x: 0, y: self.frame.height / 4)
        scorelabel.zPosition = 2
        self.addChild(scorelabel)
        
        
        
        lastScoreLabel1.fontName = "Helvetica"
        lastScoreLabel1.fontSize = 40
        lastScoreLabel1.text = "Last Score :"
        lastScoreLabel1.fontColor = UIColor.red
        lastScoreLabel1.position = CGPoint(x: -(self.frame.width / 7), y: self.frame.height / 3)
        lastScoreLabel1.zPosition = 2
        self.addChild(lastScoreLabel1)
        
        lastScoreLabel.fontName = "Helvetica"
        lastScoreLabel.fontSize = 50
        lastScoreLabel.text = "0"
        lastScoreLabel.position = CGPoint(x: 0, y: self.frame.height / 3)
        lastScoreLabel.zPosition = 2
        self.addChild(lastScoreLabel)
        
               bestScoreLabel.fontName = "Helvetica"
               bestScoreLabel.fontSize = 40
               bestScoreLabel.text = "Best Score :"
               bestScoreLabel.fontColor = UIColor.red
               bestScoreLabel.position = CGPoint(x: -(self.frame.width / 7), y: self.frame.height / 2.4)
               bestScoreLabel.zPosition = 2
               self.addChild(bestScoreLabel)
        
        
                bestScoreLabel1.fontName = "Helvetica"
                bestScoreLabel1.fontSize = 50
                bestScoreLabel1.text = "0"
                bestScoreLabel1.position = CGPoint(x: 0, y: self.frame.height / 2.4)
                bestScoreLabel1.zPosition = 2
                self.addChild(bestScoreLabel1)
        
        
        
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.collisionBitMask == ColliderType.Bird.rawValue || contact.bodyB.collisionBitMask == ColliderType.Bird.rawValue {
            
            score += 1
            scorelabel.text = String(score)
            
            
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint){
    }
    
    func touchMoved(toPoint pos : CGPoint){
    }
    
    func touchUp(atPoint pos : CGPoint){
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        /*bird.physicsBody?.affectedByGravity = true
        bird.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 100)) */
        
        if gameStarted == false {
            
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                
                                
                                
                                
                            }
                        }
                    }
                }
            }
            
        }
        
        
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){
        
        if gameStarted == false {
            
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                bird.position = touchLocation
                                
                            }
                        }
                    }
                }
            }
            
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){
        
        if gameStarted == false {
                
                if let touch = touches.first {
                    let touchLocation = touch.location(in: self)
                    let touchNodes = nodes(at: touchLocation)
                    
                    if touchNodes.isEmpty == false {
                        for node in touchNodes {
                            if let sprite = node as? SKSpriteNode {
                                if sprite == bird {
                                    
                                    let dx = -(touchLocation.x - originalPosition!.x)
                                    let dy = -(touchLocation.y - originalPosition!.y)
                                    
                                    let impulse = CGVector(dx: dx, dy: dy)
                                    
                                    bird.physicsBody?.applyImpulse(impulse)
                                    bird.physicsBody?.affectedByGravity = true
                                    
                                    gameStarted = true
                                    
                                    
                                    
                                }
                            }
                        }
                    }
                }
                
            }
            
        }
        
       
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?){
        
    }
    
    
    //Kuşun hızını kontrol etmek için
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
       if let birdPhysicsBody = bird.physicsBody {
                  
        if  birdPhysicsBody.velocity.dx <= 0.1 && birdPhysicsBody.velocity.dy <= 0.1 && birdPhysicsBody.angularVelocity <= 0.1 && gameStarted == true {
                      
                      bird.physicsBody!.affectedByGravity = false
                      bird.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
                      bird.physicsBody!.angularVelocity = 0
                      bird.zPosition = 1
                      bird.position = originalPosition!
                      gameStarted = false
                      lastScore = score
                      lastScoreLabel.text = String(lastScore)
                        
            
            if !(lastScore < bestScore){
                
                bestScore = lastScore
                bestScoreLabel1.text = String(bestScore)
                
            }
                    
            
                      score = 0
                      scorelabel.text = String(score)
                      
                  }
                  
              }
        
    }

}
