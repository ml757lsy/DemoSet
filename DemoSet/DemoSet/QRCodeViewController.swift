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
        //start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func creat() {
        
        let image = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 162, height: 162))
        image.image = QRCodeModule.initQRCode()
        view.addSubview(image)
        
        
        let data = QRCodeModule.data(with: QRCodeModule.initQRCode())
        /*
        for i in 0..<data.count{
            let line = data[i]
            for j in 0..<line.count {
                if line[j] == 0 {
                    let v = UIView.init(frame: CGRect.init(x: CGFloat(j)*6, y: CGFloat(i)*6+180, width: 6, height: 6))
                    v.backgroundColor = UIColor.black
                    view.addSubview(v)
                }
            }
        }
 */
        
        
        let header = UIImage.init(named: "testImage3")
        
        //
        let reheader = header?.resize(with: .none, rate: CGFloat(data.count)*3/(header?.size.width)!)
        
        let image2 = UIImageView.init(frame: CGRect.init(x: 180, y: 0, width: 162, height: 162))
        image2.image = reheader
        view.addSubview(image2)
        
        let image3 = UIImageView.init(frame: CGRect.init(x: 180, y: 180, width: 162, height: 162))
        image3.image = reheader?.binaryzation()
        //view.addSubview(image3)
        
        var dataImge:[[Int]] = (reheader?.binaryzation().black())!
        print(dataImge.count)
        //
        for l in 0..<data.count {
            let line = data[l]
            for i in 0..<line.count {
                dataImge[l*3+1][i*3+1] = line[i]
            }
        }
        //固定的显示的
        for l in 0..<data.count {
            let line = data[l]
            for i in 0..<line.count {
                var sta:Bool = false
                if l == 7 {
                    //
                    sta = true
                }else
                    if i == 7 {
                        //
                        sta = true
                }else
                        if l <= 8 && i <= 8 {
                            //
                            sta = true
                }else
                            if i >= data.count - 9 && l <= 8 {
                                //
                                sta = true
                }else
                                if i <= 8 && l >= data.count - 9 {
                                    //
                                    sta = true
                }else
                                    if i <= data.count - 6 && i > data.count - 6 - 5 && l <= data.count - 6 && l > data.count - 6 - 5 {
                                        //
                                        sta = true
                }
                if sta {
                    for a in 0..<3 {
                        for b in 0..<3 {
                            dataImge[l*3+a][i*3+b] = line[i]
                        }
                    }
                }
                
            }
        }
        
        for i in 0..<dataImge.count{
            let line = dataImge[i]
            for j in 0..<line.count {
                if line[j] == 0 {
                    let v = UIView.init(frame: CGRect.init(x: CGFloat(j)*2, y: CGFloat(i)*2+180, width: 2, height: 2))
                    v.backgroundColor = UIColor.black
                    view.addSubview(v)
                }
            }
        }
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
