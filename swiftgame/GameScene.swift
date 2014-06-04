//
//  GameScene.swift
//  swiftgame
//
//  Created by Stephen Chan on 6/3/14.
//  Copyright (c) 2014 Squid Ink Games. All rights reserved.
//

import Foundation
import SpriteKit

class GameScene: SKScene {
    
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
}
