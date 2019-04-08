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

    override func viewDidLoad() {
        super.viewDidLoad()

        let textview = UITextView.init(frame: CGRect.init(x: 20, y: 20, width: SCREENWIDTH-40, height: 500))
        view.addSubview(textview)
        
        // Do any additional setup after loading the view.
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
                textview.text = "\(result?.bestTranscription.formattedString)"
                print(result?.bestTranscription.formattedString)
            }
        })
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
