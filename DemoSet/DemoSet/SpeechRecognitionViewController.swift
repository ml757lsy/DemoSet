//
//  SpeechRecognitionViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2019/3/28.
//  Copyright © 2019 Far. All rights reserved.
//

import UIKit
import Speech

/// 语音识别
class SpeechRecognitionViewController: BaseViewController {
    
    var engine = AVAudioEngine()
    var recognizeRequest = SFSpeechAudioBufferRecognitionRequest()
    var speechRecognizer = SFSpeechRecognizer()
    var speechTask = SFSpeechRecognitionTask()
    
    var textview = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()

        textview = UITextView.init(frame: CGRect.init(x: 20, y: 20, width: SCREENWIDTH-40, height: 500))
        view.addSubview(textview)
        
        // Do any additional setup after loading the view.
//        recongnizerResource()
        recongnizerRecord()
    }
    
    
    /// 识别音频文件
    func recongnizerResource() {
        let recongnizer = SFSpeechRecognizer.init(locale: Locale.init(identifier: "zh_CN"))
        let url = Bundle.main.url(forResource: "83", withExtension: "mp3")
        let request = SFSpeechURLRecognitionRequest.init(url: url!)
        recongnizer?.recognitionTask(with: request, resultHandler: { (result, er) in
            //
            print("recongnizer")
            if (er != nil) {
                print("error")
                print(er?.localizedDescription)
            }else{
                print("ok")
                self.textview.text = "\(result?.bestTranscription.formattedString)"
                print(result?.bestTranscription.formattedString)
            }
        })
    }
    
    
    /// 直接识别语音
    func recongnizerRecord() {
        engine = AVAudioEngine.init()
        
        recognizeRequest = SFSpeechAudioBufferRecognitionRequest.init()
        
        SFSpeechRecognizer.requestAuthorization { (status) in
            if status != .authorized {
                return
            }
            
            self.engine.inputNode.installTap(onBus: 0, bufferSize: 1024, format: self.engine.inputNode.outputFormat(forBus: 0), block: { (buffer, time) in
                //
                self.recognizeRequest.append(buffer)
            })
            self.engine.prepare()
        }
        
        //start wait 0.01
        startAudiRecognize()
        
    }
    
    func startAudiRecognize() {
        do {
            try engine.start()
            self.speechTask =
            self.speechRecognizer?.recognitionTask(with: self.recognizeRequest, resultHandler: { (result, error) in
                //
                if result == nil {
                    print("===>>>nil")
                    return
                }
                let str = result?.bestTranscription.formattedString ?? ""
                print(str)
                self.textview.text = str
            }) ?? SFSpeechRecognitionTask()
        } catch let error {
            print("error\(error)")
        }
    }
    
    func stopAudiRecognize() {
        //
        self.engine.stop()
        self.recognizeRequest.endAudio()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
