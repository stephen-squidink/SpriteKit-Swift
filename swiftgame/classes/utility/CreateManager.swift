//
//  CreateManager.swift
//  swiftgame
//
//  Created by Stephen Chan on 6/4/14.
//  Copyright (c) 2014 Squid Ink Games. All rights reserved.
//

import SpriteKit

struct CreateManager {
   
    static func createBackground(parent : SKScene)->(background : SKSpriteNode, parallax : ParallaxSprite[]){
        let background = SKSpriteNode(imageNamed: "BGSky.jpg");
        background.position = CGPointMake(CGRectGetMidX(parent.frame), CGRectGetMidY(parent.frame));
        
        parent.addChild(background);

        let layer1 = ParallaxSprite(name: "BGCloud", speed: 2, frame: parent.frame);
        let layer2 = ParallaxSprite(name: "BGMountains", speed: 3, frame: parent.frame);
        let layer3 = ParallaxSprite(name: "BGCloud2", speed: 4, frame: parent.frame);
        let layer4 = ParallaxSprite(name: "BGGrass", speed: 5, frame: parent.frame);
        
        parent.addChild(layer1);
        parent.addChild(layer2);
        parent.addChild(layer3);
        parent.addChild(layer4);
        
        return (background, [layer1, layer2, layer3, layer4]);
    }
    
    static func createCharacter(parent : SKScene)->SKSpriteNode{
        let atlas : SKTextureAtlas = SKTextureAtlas(named: "character");
        let f1 : SKTexture = atlas.textureNamed("character_01.png");
        let f2 : SKTexture = atlas.textureNamed("character_02.png");
        let f3 : SKTexture = atlas.textureNamed("character_03.png");
        let f4 : SKTexture = atlas.textureNamed("character_04.png");
        let f5 : SKTexture = atlas.textureNamed("character_05.png");
        let f6 : SKTexture = atlas.textureNamed("character_06.png");
        let f7 : SKTexture = atlas.textureNamed("character_07.png");
        let f8 : SKTexture = atlas.textureNamed("character_08.png");
        let f9 : SKTexture = atlas.textureNamed("character_09.png");
        let f10 : SKTexture = atlas.textureNamed("character_10.png");
        let f11 : SKTexture = atlas.textureNamed("character_11.png");
        let f12 : SKTexture = atlas.textureNamed("character_12.png");
        let f13 : SKTexture = atlas.textureNamed("character_13.png");
        let f14 : SKTexture = atlas.textureNamed("character_14.png");
        
        let characterFrames : Array = [f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14];
        
        let player : SKSpriteNode = SKSpriteNode(imageNamed: "character_01.png");
        player.position =  CGPointMake(CGRectGetMidX(parent.frame) - 50, CGRectGetMidY(parent.frame) - 150);
        
        parent.addChild(player);
        
        let action : SKAction = SKAction.repeatActionForever(SKAction.animateWithTextures(characterFrames, timePerFrame: 0.1));
        player.runAction(action);
        
        player.physicsBody = SKPhysicsBody(rectangleOfSize: player.size);
        
        return player;
    }
    
    static func createStar(parent : SKScene)->SKSpriteNode{
        let star : SKSpriteNode = SKSpriteNode(imageNamed: "Star");
        let rnd : CGFloat = CGFloat(arc4random() % 100);
        star.position.x = parent.frame.width + star.size.width;
        star.position.y = CGFloat(CGRectGetMidY(parent.frame) - 10 + rnd);
        
        
        star.physicsBody = SKPhysicsBody(rectangleOfSize: star.size);
        star.physicsBody.categoryBitMask = ContactCategory.star;
        star.physicsBody.collisionBitMask = ContactCategory.star | ContactCategory.charactor;
        star.physicsBody.contactTestBitMask = ContactCategory.star | ContactCategory.charactor;
        
        parent.addChild(star);
        
        return star;
    }
}
