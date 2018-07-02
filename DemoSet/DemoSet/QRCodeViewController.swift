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
    private var isShow:Bool = false//显示标签
    private let box = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        customNavigationBar()
        
        if !UIDevice.isSimulator() {
            start()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        stop()
    }
    
    func customNavigationBar() {
        let creatButton = UIButton.init(type: .custom)
        creatButton.setTitle("生成", for: .normal)
        creatButton.addTarget(self, action: #selector(toCreate), for: .touchUpInside)
        
        let right = UIBarButtonItem.init(customView: creatButton)
        navigationItem.rightBarButtonItem = right
    }
    
    func toCreate() {
        navigationController?.pushViewController(QRCodeCreateViewController(), animated: true)
    }
    
    func stop() {
        session.stopRunning()
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
        
        view.addSubview(box)
        box.frame = CGRect.init(x: 30, y: 100, width: view.width-60, height: view.height-300)
        box.backgroundColor = UIColor.init(red: 1, green: 0, blue: 0, alpha: 0.3)
        
        session.startRunning()
        
    }
    
    func update(corners:[CGPoint]) {
        print("Box~~")
        
        
        
        if box.layer.sublayers != nil {
            for la in box.layer.sublayers! {
                la.removeFromSuperlayer()
            }
        }
        
        let path = UIBezierPath.init()
        let start = CGPoint.init(x: (1-corners[0].y)*box.width, y: corners[0].x*box.height)
        path.move(to: start)
        for i in 1..<corners.count {
            //
            let p = CGPoint.init(x: (1-corners[i].y)*box.width, y: corners[i].x*box.height)
            path.addLine(to: p)
        }
        path.addLine(to: start)
        path.lineWidth = 1
        
        let boxlayer = CAShapeLayer.init()
        boxlayer.path = path.cgPath
        boxlayer.lineWidth = 4
        boxlayer.strokeColor = UIColor.init(red: 0.6, green: 0.9, blue: 0.1, alpha: 0.8).cgColor
        boxlayer.fillColor = UIColor.init(red: 0.6, green: 0.9, blue: 0.1, alpha: 0.8).cgColor
        
        box.layer.addSublayer(boxlayer)
    }
    
    //MARK: delegate
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        if metadataObjects.count > 0 {
//            session.stopRunning()
            let metadata = metadataObjects[0] as! AVMetadataMachineReadableCodeObject

            var points:[CGPoint] = []
            for c in metadata.corners {
                let p = CGPoint.init(dictionaryRepresentation: c as! CFDictionary)
                points.append(p!)
            }
            update(corners: points)
            //
            let data = metadata.stringValue
            
            if !isShow {
                isShow = true
                AlertModule.showToast(title: nil, conetent: data, from: self, duration: 1, complate: {
                    //
                    self.isShow = false
                })
            }
        }
    }
}
