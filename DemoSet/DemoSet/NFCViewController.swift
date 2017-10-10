//
//  NFCViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/9/25.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit
import CoreNFC

@available(iOS 11.0, *)
class NFCViewController: BaseViewController,NFCNDEFReaderSessionDelegate {
    
    

    var nfcSession:NFCNDEFReaderSession!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if NFCNDEFReaderSession.readingAvailable {
            print("NFC Avaiable")
        }

        nfcSession = NFCNDEFReaderSession.init(delegate: self, queue: DispatchQueue.main, invalidateAfterFirstRead: true)
        nfcSession.begin()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -
    
    func readerSessionDidBecomeActive(_ session: NFCReaderSession) {
        print("ac")
    }
    
    func readerSession(_ session: NFCReaderSession, didDetect tags: [NFCTag]) {
        print(tags)
    }

    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        print("NFC========")
        for message in messages {
            for recored in message.records{
                print(recored.identifier)
                print(recored.payload)
                print(recored.type)
                print(recored.typeNameFormat)
            }
        }
    }
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print(error)
    }
}
