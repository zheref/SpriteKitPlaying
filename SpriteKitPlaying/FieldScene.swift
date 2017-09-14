//
//  FieldScene.swift
//  SpriteKitPlaying
//
//  Created by Carlos Luis Urbina on 9/14/17.
//  Copyright © 2017 SappitoTech. All rights reserved.
//

import UIKit
import  SpriteKit

class FieldScene: SKScene {
    
    // Simulación de coordenadas recibidas por el servidor (aún no implementado)... Ref: http://www.escoladefutbol.com/beto/docs/sist_f11/sist_f11.htm#5
    
    fileprivate static let Formations: [String: [[Double]]] = [
        "4-3-3": [
            [1,4],// 1
            [2,1],// 2
            [2,7],// 3
            [2,3],// 4
            [2,5],// 5
            [3,4],// 6
            [5,1],// 7
            [3,2],// 8
            [5,4],// 9
            [3,6],// 10
            [5,7]// 11
        ], "4-4-2": [
            [1,4],// 1
            [2,1],// 2
            [2,7],// 3
            [2,3],// 4
            [2,5],// 5
            [3,3],// 6
            [4,1],// 7
            [3,5],// 8
            [5,5],// 9
            [5,3],// 10
            [4,7] // 11
        ], "4-4-1-1": [
            [1,4],// 1
            [2,1],// 2
            [2,7],// 3
            [2,3],// 4
            [2,5],// 5
            [3,3],// 6
            [4,1],// 7
            [3,5],// 8
            [6,4],// 9
            [5,4],// 10
            [4,7] // 11
        ], "4-5-1": [
            [1,4],// 1
            [2,1],// 2
            [2,7],// 3
            [2,3],// 4
            [2,5],// 5
            [3,4],// 6
            [3,1],// 7
            [3,2.5],// 8
            [5,4],// 9
            [3,5.5],// 10
            [3,7] // 11
        ]
    ]

    var formation: String = ""
    let background = SKSpriteNode(imageNamed: "soccer-field")
    
    init (size: CGSize, formation: String) {
        super.init(size: size)
        self.formation = formation
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        background.size = self.size
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        addChild(background)
        
        addPlayersFor(formation: self.formation)
    }
    
    private func addPlayersFor (formation: String) {
        if let players = FieldScene.Formations[formation] {
            for (i, position) in players.enumerated() { // Número total de jugadores en la cancha
                let player = SKSpriteNode(imageNamed: "soccer-ball")
                player.size = CGSize (width: 30, height: 30)
                player.position = CGPoint(x: frame.midX, y: frame.minY)
                let label = SKLabelNode(fontNamed:"Chalkduster")
                label.text = "\(i+1)"
                label.fontSize = 30
                label.fontColor = .red
                label.horizontalAlignmentMode = .right
                label.verticalAlignmentMode = .bottom
                player.addChild(label)
                
                addChild(player)
                
                addMovingActionTo(player: player, with: position)
            }
        }
    }
    
    private func addMovingActionTo (player: SKSpriteNode, with position: [Double]) {
        let actionMove = SKAction.move(to: getCGPointFor(position: position), duration: TimeInterval(random(min: 1.0, max: 3.0)))
        let actionMoveDone = SKAction.stop()
        player.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
    // MARK: - Helpers
    
    private func getCGPointFor (position: [Double]) -> CGPoint {
        let x = CGFloat(position[0])
        let y = CGFloat(position[1])
        
        return CGPoint (x: (frame.maxX/8) * x, y: (frame.maxY/8) * y)
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
}
