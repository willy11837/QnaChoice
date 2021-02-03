//
//  ViewController.swift
//  QnaChoice
//
//  Created by Willy Kang on 2021/1/30.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet var choiceButton: [UIButton]!
    @IBOutlet weak var answerIsRightOrWrong: UILabel!
    @IBOutlet weak var finalScore: UILabel!
//    @IBOutlet weak var endButton: UIButton!
    
    
    
    var topics = [
        qna(question: "世界上最大的動物", answer: "藍鯨", choice: ["大象","大白鯊","犀牛","藍鯨"]),
        
        qna(question: "世界現存體型最大的爬行動物", answer: "鹹水鱷", choice: ["射紋龜","科莫多龍","鹹水鱷","黑刺尾鬣蜥"]),
        
        qna(question: "世界上哪個國家最小", answer: "梵蒂岡", choice: ["梵蒂岡","衣索比亞","新加坡","瑞士"]),
        
        qna(question: "世界現存最大的飛鳥", answer: "信天翁", choice: ["安地斯禿鷹","非洲鴕鳥","信天翁","疣鼻天鵝"]),
        
        qna(question: "世界上最小的鳥", answer: "吸蜜蜂鳥", choice: ["麻雀","七彩文鳥","吸蜜蜂鳥","奇異鳥(KiWiBird)"]),
        
        qna(question: "世界上最有錢的國家", answer: "卡達", choice: ["卡達","阿拉伯聯合大公園","盧森堡","挪威"]),
        
        qna(question: "世界上最窮的國家", answer: "辛巴威", choice: ["阿富汗","索馬尼亞","海地共和國","辛巴威"]),
        
        qna(question: "世界上最北的國家", answer: "挪威", choice: ["俄羅斯","阿拉斯加","冰島","挪威"]),
        
        qna(question: "世界上最高的國家", answer: "賴索托", choice: ["瑞士","不丹","賴索托","中國"]),
        
        qna(question: "世界上海拔最低的國家", answer: "荷蘭", choice: ["日本","馬爾地夫","荷蘭","希臘"])
    ]
    
    
    var choices:[String] = [] // 目前的題目選項陣列
    var totalScore:Int = 0 // 分數
    var top:qna? // 目前的題目物件
    var test:[Int] = [] // 題庫的出題順序
    var count = 0 // 算目前第幾題
    let roundString = [ "一", "二", "三", "四", "五", "六", "七", "八", "九", "十" ] // 題號以中文表示
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let num = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        test = num.shuffled()
        changeQuestion()
//        endButton.isEnabled = false
        
    }
    
    // 當按下答案即執行
    @IBAction func choice(_ sender: UIButton) {
        //代表所選button是array的第幾個成員
        let number = choiceButton.firstIndex(of: sender)
        if ( choiceButton[number!].currentTitle == top!.answer ) {
            totalScore += 10
            finalScore.text = String(totalScore)
            answerIsRightOrWrong.text = String("答對了！🥳👍🏽")
        }
        else {
            answerIsRightOrWrong.text = String("答錯ㄌ！🤨🖕🏻")
        }
        count += 1
        if count < 10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.changeQuestion()
            }
        }
        else {
//            endButton.isEnabled = true
            performSegue(withIdentifier: "showPage2", sender: self)
        }
    }
    
    // 更新題目
    func changeQuestion() {
        top = topics[test[count]]
        roundLabel.text =  roundString[count]
        questionLabel.text = top!.question
        choices = top!.choice.shuffled()
        choiceButton[0].setTitle(choices[0], for: .normal)
        choiceButton[1].setTitle(choices[1], for: .normal)
        choiceButton[2].setTitle(choices[2], for: .normal)
        choiceButton[3].setTitle(choices[3], for: .normal)
    }
    
    // 重新計算與遊戲
    @IBAction func restart(_ sender: Any) {
        let num = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        test = num.shuffled()
        count = 0
        totalScore = 0
        finalScore.text = String(totalScore)
        answerIsRightOrWrong.text = String("")
        changeQuestion()
    }
    
    @IBSegueAction func showResult(_ coder: NSCoder) -> ResultViewController? {

        let controller = ResultViewController(coder: coder)
        
        let finalScore = totalScore
        controller?.score = QnaScore(score: finalScore)
        return controller
        
    }
}
