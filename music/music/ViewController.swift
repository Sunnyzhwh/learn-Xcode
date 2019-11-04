//
//  ViewController.swift
//  music
//
//  Created by Sunny on 2019/7/17.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var control: UIImageView!
    
    var songs = [AVAudioPlayer]()
    
    var preTag: Int? = nil
    
    let songFileNames = ["中国话","谢谢你的温柔","Super Star","波斯猫"]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        control.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        control.layer.cornerRadius = 50
        control.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        control.layer.shadowRadius = 10
        control.layer.opacity = 1
        control.layer.shadowOpacity = 1
        let shadowSize: CGFloat = 110.0
        let Cx: CGFloat = 0.0
        let Cy: CGFloat = 0.0
        let circle = CGPath(ellipseIn: CGRect(x: Cx , y: Cy, width: shadowSize, height: shadowSize), transform: nil)
        
        control.layer.shadowPath = circle
//        control.isHidden = true
        
        for sound in songFileNames {
            do {
            let url = NSURL(fileURLWithPath: Bundle.main.path(forResource: sound, ofType: "mp3")!)
            let song = try AVAudioPlayer(contentsOf: url as URL)
            songs.append(song)
            }catch {
                songs.append(AVAudioPlayer())
            }
        }
    }

    @IBAction func songname(_ sender: UIButton) {
        if (preTag != nil) {
            songs[preTag!].stop()
            songs[preTag!].currentTime = 0
            print("\(String(describing: preTag ?? nil))")
            preTag = sender.tag
        }else {
            preTag = sender.tag
        }
        let avplayer = songs[sender.tag]
//        avplayer.prepareToPlay()
        avplayer.play()
    }
    
}

