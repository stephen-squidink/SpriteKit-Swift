//
//  GameScene.swift
//  swiftgame
//
//  Created by Stephen Chan on 6/3/14.
//  Copyright (c) 2014 Squid Ink Games. All rights reserved.
//

import Foundation
import SpriteKit

struct ContactCategory {
    static let charactor : UInt32 = 0x1 << 0;
    static let star      : UInt32 = 0x1 << 1;
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var isJump : Bool = false;
    
    var background : SKSpriteNode!
    var parallax : ParallaxSprite[]!
    var player : SKSpriteNode!
    var stars : SKSpriteNode[] = [];
    
    var starCounter : Int = 0;
    
    override func didMoveToView(view: SKView) {
        let ref = CreateManager.createBackground(self);
        
        background = ref.background;
        parallax = ref.parallax;
    
        player = CreateManager.createCharacter(self);
        
        self.physicsWorld.contactDelegate = self;
        self.physicsWorld.gravity = CGVectorMake(0, 0);
    }
   
    override func update(currentTime: CFTimeInterval) {
        for p : ParallaxSprite in parallax {
            p.update();
        }
        
        self.updateStars();
    }
    
    func updateStars() {
        starCounter++;
        
        if(starCounter % 50 == 0){
            stars.insert(CreateManager.createStar(self), atIndex: 0);
        }
        
        for var index = stars.count - 1; index >= 0; --index {
            let s : SKSpriteNode = stars[index];
            s.position.x -= 10;
            
            if(s.position.x < 0 - s.size.width){
                stars.removeAtIndex(index);
            }
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if(!isJump){
            let touch : AnyObject = touches.anyObject();
            if (touch != nil) {
                
                let jumpAction : SKAction = SKAction.moveTo(CGPointMake(player.position.x, player.position.y + 200), duration: 0.3);
                let fallAction : SKAction = SKAction.moveTo(CGPointMake(player.position.x, CGRectGetMidY(self.frame) - 150), duration: 0.3);
                let completeAction : SKAction = SKAction.runBlock({
                    self.isJump = false;
                });

                player.runAction(SKAction.sequence([jumpAction, fallAction, completeAction]));
                
                isJump = true;
            }
        }
    }
    
    func didBeginContact(contact : SKPhysicsContact){
        var firstBody : SKPhysicsBody;
        var secondBody : SKPhysicsBody;
        
        if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
            firstBody = contact.bodyA;
            secondBody = contact.bodyB;
        } else {
            firstBody = contact.bodyB;
            secondBody = contact.bodyA;
        }
    
        if ((firstBody.categoryBitMask & ContactCategory.star) != 0) {
            self.destroyStar(firstBody.node);
        }
    }
    
    func destroyStar(star : SKNode) {
        for var index = stars.count - 1; index >= 0; --index {
            let s : SKSpriteNode = stars[index];
    
            if(s == star){
                stars.removeAtIndex(index)
                star.removeFromParent();
                
                return;
            }
        }
    }
}
