//
//  ViewController.swift
//  SpriteKitPlaying
//
//  Created by Carlos Luis Urbina on 9/14/17.
//  Copyright © 2017 SappitoTech. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    let formations:[String] = ["4-3-3","4-4-2","4-4-1-1", "4-5-1"]
    var currentIndex = 0
    
    @IBOutlet weak var fieldView: SKView!
    @IBOutlet weak var formationLabel: UILabel!
    
    var fieldScene: SKScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        formationLabel.text = formations[currentIndex]
        setupScene(formation:  formations[currentIndex])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupScene (formation: String) {
        fieldScene = FieldScene (size: self.fieldView.bounds.size, formation: formation)
        fieldView.presentScene(fieldScene)
        
        
        
    }

    @IBAction func changeFormationButtonTapped(_ sender: Any) {
        if currentIndex == formations.count - 1 {
            currentIndex = 0
        } else {
            currentIndex += 1
        }
        formationLabel.text = formations[currentIndex]
        setupScene(formation: formations[currentIndex])
    }

}

