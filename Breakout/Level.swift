//
//  Level.swift
//  Breakout
//
//  Created by Albertino Padin on 10/27/14.
//  Copyright (c) 2014 Albertino Padin. All rights reserved.
//

import Foundation
import SceneKit

class Level
{
    class func createLevel() -> SCNNode
    {
        let levelNode = SCNNode()
        
        for i in 1...9
        {
            for j in 1...9
            {
                var blockNode = randomBlock()
                let width:Float = Float((blockNode.geometry as SCNBox).width)
                let height:Float = Float((blockNode.geometry as SCNBox).height)
                let jFloat = Float(j) * (width + 1)
                let iFloat = Float(i) * (height + 1)
                blockNode.position = SCNVector3Make(jFloat, iFloat, 0)
                levelNode.addChildNode(blockNode)
            }
        }
        
        // Add Walls
        levelNode.addChildNode(generateWalls())
        
        return levelNode
    }

    
    class func sideWallGeometry() -> SCNGeometry
    {
        let sideWallGeometry = SCNBox(width: 2, height: 86, length: 2, chamferRadius: 0.5)
        sideWallGeometry.firstMaterial!.diffuse.contents = UIColor.darkGrayColor()
        sideWallGeometry.firstMaterial!.specular.contents = UIColor.whiteColor()
        
        return sideWallGeometry
    }
    
    class func sideWallPhysicsBody() -> SCNPhysicsBody
    {
        let sideWallPhysicsShape = SCNPhysicsShape(geometry: sideWallGeometry(), options: nil)
        let sideWallPhysicsBody = SCNPhysicsBody(type: SCNPhysicsBodyType.Kinematic, shape: sideWallPhysicsShape)
        return sideWallPhysicsBody
    }
    
    
    class func generateWalls() -> SCNNode
    {
        let wallNode = SCNNode()
        
        
        let leftWall = SCNNode(geometry: sideWallGeometry())
        leftWall.position = SCNVector3Make(-1, 2, 0)
        leftWall.physicsBody = sideWallPhysicsBody()
        leftWall.name = "Wall"
        wallNode.addChildNode(leftWall)
        
        
        
        let topWallGeometry = SCNBox(width: 50, height: 2, length: 2, chamferRadius: 0.5)
        topWallGeometry.firstMaterial!.diffuse.contents = UIColor.darkGrayColor()
        topWallGeometry.firstMaterial!.specular.contents = UIColor.whiteColor()
        
        let topWallPhysicsShape = SCNPhysicsShape(geometry: topWallGeometry, options: nil)
        let topWallPhysics = SCNPhysicsBody(type: SCNPhysicsBodyType.Kinematic, shape: topWallPhysicsShape)
        
        let topWall = SCNNode(geometry: topWallGeometry)
        topWall.position = SCNVector3Make(25, 44, 0)
        topWall.physicsBody = topWallPhysics
        topWall.name = "Wall"
        wallNode.addChildNode(topWall)
        
        
        
        let rightWall = SCNNode(geometry: sideWallGeometry())
        rightWall.position = SCNVector3Make(51, 2, 0)
        rightWall.physicsBody = sideWallPhysicsBody()
        rightWall.name = "Wall"
        wallNode.addChildNode(rightWall)
        
        return wallNode
    }
    
    
    class func createLevel_Simple() -> SCNNode
    {
        let blockNode = SCNNode()
        
        let blueNode = SCNNode(geometry: Block.blueBlock())
        blueNode.position = SCNVector3Make(0, 0, 0)
        blockNode.addChildNode(blueNode)
        
        let redNode = SCNNode(geometry: Block.redBlock())
        redNode.position = SCNVector3Make(+6, 0, 0)
        blockNode.addChildNode(redNode)
        
        let greenNode = SCNNode(geometry: Block.greenBlock())
        greenNode.position = SCNVector3Make(-6, 0, 0)
        blockNode.addChildNode(greenNode)
        
        return blockNode
    }
    
    
    
    class func randomBlock() -> SCNNode
    {
        // Generate random number to pick block color
        let numberOfColors: UInt32 = UInt32(BlockColor.numberOfColors())
        let randomNumber = Int(arc4random_uniform(numberOfColors)) + 1
        let randomColor: BlockColor = BlockColor(rawValue: randomNumber)!
        
        return Block.generateBlockNodeOfColor(randomColor)
    }
    
}
