//
//  ResultViewController.swift
//  QnaChoice
//
//  Created by Willy Kang on 2021/1/30.
//

import UIKit

class ResultViewController: UIViewController {
    
    
    var score: QnaScore!

    @IBOutlet weak var finalScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        finalScoreLabel.text = String(score.score)

    }

}
