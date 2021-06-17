//
//  ViewController.swift
//  EggTimer
//
//  Created by Ashish Kheveria on 17/12/2020.
//  Copyright © 2020 Ashish Kheveria. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var eggTimes = ["Soft": 3, "Medium": 5, "Hard": 7]
    var timer = Timer()
    var player: AVAudioPlayer!
    var totalTime = 0
    var secondsPassed = 0
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        // Used for timer. And Timers work in conjunction with run loops.
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
       
    }
    
    @objc func updateTimer() {
        
        if secondsPassed < totalTime {
            
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            
            //used for debugging to check why the prog bar didn't progress
//            print(Float(secondsPassed) / Float(totalTime))
//            print(Float(secondsPassed / totalTime))
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
    
}
