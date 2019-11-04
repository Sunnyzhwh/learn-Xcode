//
//  ViewController.swift
//  T_minus
//
//  Created by Sunny on 2019/10/25.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBAction func checkButton(_ sender: UIButton) {
        lotteryVC.startNum = Int(startLabel.text!)!
        lotteryVC.endNum = Int(endLabel.text!)!
        present(lotteryVC, animated: true, completion: nil)
    }
    @IBOutlet weak var startLabel: UILabel!
    
    @IBOutlet weak var endLabel: UILabel!
    
    @IBAction func startSlider(_ sender: UISlider) {
        let result = Int(sender.value)
        startLabel.text = String(result)
    }
    
    @IBAction func endSlider(_ sender: UISlider) {
        let result = Int(sender.value)
        endLabel.text = String(result)
    }
    var audioPlayer: AVAudioPlayer?
    var lotteryVC = lotteryViewController()
    let url = NSURL(fileURLWithPath: Bundle.main.path(forResource: "T-minus", ofType: "mp3")!)
    private lazy var number: UILabel = {
        let labelNum = UILabel()
        labelNum.frame = CGRect(x: 0, y: 0, width: 120, height: 40)
        return labelNum
    }()
    var cycleTimer: Timer?
    var num = 3
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        view.addSubview(number)
//        number.center = view.center
//        removeCycleTimer()
//        addCycleTimer()
    }
    @objc private func changeLabeltext(){
        if num == 0 {
            removeCycleTimer()
            configureLabel(number, string: String(num))
            audioPlayerDidFinishPlaying(audioPlayer!, successfully: true)
            return
        }else {
            configureLabel(number, string: String(num))
            num -= 1
        }
    }
    private func configureLabel(_ label: UILabel, string: String){
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(32)
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        let paragraphStyler = NSMutableParagraphStyle()
        paragraphStyler.alignment = .center
        let textShadow = NSShadow()
        textShadow.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        textShadow.shadowOffset = CGSize(width: 2, height: 2)
        textShadow.shadowBlurRadius = 1.0
        let attributes: [NSAttributedString.Key : Any] = [
            .foregroundColor : UIColor.white,
            .font : font,
            .paragraphStyle : paragraphStyler,
            .shadow : textShadow
        ]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        label.attributedText = attributedString
        label.center = view.center
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.4, delay: 0.4, options: [], animations: {
            label.transform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
        }) { (position) in
            label.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
        }
        do{
        audioPlayer = try AVAudioPlayer(contentsOf: url as URL)
        }catch{print(url)}
        audioPlayer!.play()
    }
    private func addCycleTimer() {
        cycleTimer = Timer(fireAt: Date(timeIntervalSinceNow: 0), interval: 1.0, target: self, selector: #selector(changeLabeltext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .common)
    }
    private func removeCycleTimer() {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        present(lotteryVC, animated: true, completion: nil)
    }
}

