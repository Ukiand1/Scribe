//
//  ViewController.swift
//  Scribe
//
//  Created by Uroš Đurđević on 15/09/16.
//  Copyright © 2016 Uroš Đurđević. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

import AVFoundation
class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var transcriptionTextField: UITextView!
    
    //to play something you need to make an audio player
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activitySpinner.isHidden = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        activitySpinner.stopAnimating()
        activitySpinner.isHidden = true
    }
    
    func requestSpeechAuth() {
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                if let path = Bundle.main.url(forResource: "Tibet", withExtension: "mp3"){
                    do {
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.audioPlayer = sound //explain
                        self.audioPlayer.delegate = self
                        sound.play()
                        
                    } catch {
                        print ("Error!")
                    }
                    
                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    recognizer?.recognitionTask(with: request) { (result, error) in
                        if let error = error {
                            print("There was an error: \(error)")
                        } else {
                            self.transcriptionTextField.text = result?.bestTranscription.formattedString
                        }
                    
                    }
                    
                }
            }
        }
    }

    @IBAction func playBtnPressed(_ sender: AnyObject) {
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        requestSpeechAuth()
        
    }
    
    
    


}

