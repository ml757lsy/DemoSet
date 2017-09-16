//
//  QRCodeViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/9/16.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class QRCodeViewController: BaseViewController,AVCaptureMetadataOutputObjectsDelegate {

    private let session = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creat()
        start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func creat() {
        
        let image = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        image.image = QRCodeModule.initQRCode()
        view.addSubview(image)
    }
    
    func start() {
        //设备
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        //session
        
        session.sessionPreset = AVCaptureSessionPresetHigh
        
        //输入流
        var input:AVCaptureDeviceInput
        do {
            input = try AVCaptureDeviceInput.init(device: device)
            session.addInput(input)
        } catch _ {
        }
        
        //输出流
        let output:AVCaptureMetadataOutput = AVCaptureMetadataOutput.init()
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        session.addOutput(output)//先添加输出流
        //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
        //不讲究就全部兼容吧
        //[AVMetadataObjectTypeQRCode]
        output.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        output.rectOfInterest = CGRect.init(x: 0.05, y: 0.2, width: 0.7, height: 0.6)
        
        //layer
        let layer = AVCaptureVideoPreviewLayer.init(session: session)
        layer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        layer?.frame = CGRect.init(x: 30, y: 100, width: view.width-60, height: view.height-300)
        view.layer.insertSublayer(layer!, at: 0)
        
        session.startRunning()
        
    }
    
    //MARK: delegate
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        if metadataObjects.count > 0 {
//            session.stopRunning()
            
            
            let metadata = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            print(metadata)
            
            let data = metadata.stringValue
            
            AlertModule.showToast(title: nil, conetent: data, from: self, duration: 1, complate: {
                //
            })
        }
    }
}
