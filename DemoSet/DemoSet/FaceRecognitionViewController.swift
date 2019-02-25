//
//  FaceRecognitionViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/9/16.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit
import AVFoundation

class FaceRecognitionViewController: BaseViewController,AVCaptureMetadataOutputObjectsDelegate,AVCaptureVideoDataOutputSampleBufferDelegate {

    private let session = AVCaptureSession()
    private let face = UIImageView()
    private var sessionLayer = AVCaptureVideoPreviewLayer()
    private var boxs:[CAShapeLayer] = []//框框
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()

        start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {

    }
    

    func start() {
        //设备
        let device = AVCaptureDevice.default(for: AVMediaType(rawValue: convertFromAVMediaType(AVMediaType.video)))
        
        //session
        
        session.sessionPreset = AVCaptureSession.Preset(rawValue: convertFromAVCaptureSessionPreset(AVCaptureSession.Preset.high))
        
        //输入流
        var input:AVCaptureDeviceInput
        do {
            input = try AVCaptureDeviceInput.init(device: device!)
            session.addInput(input)
        } catch _ {
        }
        
        //输出流
        let output:AVCaptureMetadataOutput = AVCaptureMetadataOutput.init()
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        session.addOutput(output)//先添加输出流
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.face]
        //上 左 高 宽
        output.rectOfInterest = CGRect.init(x: 0.1, y: 0.1, width: 0.8, height: 0.8)
        
        //layer
        sessionLayer = AVCaptureVideoPreviewLayer.init(session: session)
        sessionLayer.videoGravity = AVLayerVideoGravity(rawValue: convertFromAVLayerVideoGravity(AVLayerVideoGravity.resizeAspectFill))
        sessionLayer.frame = CGRect.init(x: 30, y: 100, width: view.width-60, height: view.height-300)
        view.layer.insertSublayer(sessionLayer, at: 0)
        
        let sessionbox = CAShapeLayer.init()
        let p = UIBezierPath.init(rect: CGRect.init(x: sessionLayer.frame.size.width*output.rectOfInterest.origin.y, y: sessionLayer.frame.size.height*output.rectOfInterest.origin.x, width: sessionLayer.frame.size.width*output.rectOfInterest.size.height, height: sessionLayer.frame.size.height*output.rectOfInterest.size.width))
        sessionbox.path = p.cgPath
        sessionbox.strokeColor = UIColor.green.cgColor
        sessionbox.lineWidth = 0.5
        sessionbox.fillColor = UIColor.clear.cgColor
        sessionLayer.addSublayer(sessionbox)
        
        session.startRunning()
    }
    
    func metadataOutput(_ captureOutput: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count > 0 {
            while metadataObjects.count > boxs.count {
                let box = CAShapeLayer.init()
                boxs.append(box)
            }
            for layer in boxs {
                layer.removeFromSuperlayer()
            }
            
            for i in 0..<metadataObjects.count {
                let metadata = metadataObjects[i] as! AVMetadataFaceObject
                print(metadata.faceID)
                //更新框框
                let w = sessionLayer.frame.size.width
                let h = sessionLayer.frame.size.height
                //上 左 高 宽
                //从右往左
                let bw = w*metadata.bounds.size.height
                let bh = h*metadata.bounds.size.width
                let bx = w*(1-metadata.bounds.origin.y)-bw
                let by = h*metadata.bounds.origin.x
                
                let path = UIBezierPath.init(roundedRect: CGRect.init(x: bx, y: by, width: bw, height: bh), cornerRadius: 2)
                
                let box = boxs[i]
                box.path = path.cgPath
                box.lineWidth = 2
                box.strokeColor = UIColor.red.cgColor
                box.fillColor = UIColor.clear.cgColor
                
                
                if metadata.hasRollAngle {//？？？啥用
                    box.strokeColor = UIColor.yellow.cgColor
                    print(metadata.rollAngle)
                }
                if metadata.hasYawAngle {
                    box.cornerRadius = 20
                    print(metadata.yawAngle)
                }else{
                    box.cornerRadius = 0
                }
                
                sessionLayer.addSublayer(box)
            }
        }
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        //
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        //
    }

}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVMediaType(_ input: AVMediaType) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVCaptureSessionPreset(_ input: AVCaptureSession.Preset) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVMetadataObjectObjectType(_ input: AVMetadataObject.ObjectType) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVLayerVideoGravity(_ input: AVLayerVideoGravity) -> String {
	return input.rawValue
}
