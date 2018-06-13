//
//  QRCodeCreateViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2018/6/13.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

class QRCodeCreateViewController: BaseViewController {

    private var data:[[Int]] = []
    private var backScroll:UIScrollView = UIScrollView()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initView()
        
        creat()
        qrcode(color: UIColor.purple)
        qrcode(type: 0)
    }
    
    func initView () {
        backScroll = UIScrollView.init(frame: view.bounds)
        view.addSubview(backScroll)
    }
    
    
    func creat() {
        let space:CGFloat = 10
        let qrsize:CGFloat = (SCREENWIDTH - space * 3) / 2
        
        //1.base
        let qrcodimage = QRCodeModule.initQRCode(message: "哈哈哈哈哈哈嗝···")
        let qrview = UIImageView.init(frame: CGRect.init(x: space, y: space, width: qrsize, height: qrsize))
        qrview.image = qrcodimage
        backScroll.addSubview(qrview)
        
        data = QRCodeModule.data(with: qrcodimage)
        
        
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
        let size:CGFloat = 1.5
        //        for i in 0..<dataImge.count{
        //            let line = dataImge[i]
        //            for j in 0..<line.count {
        //                if line[j] == 0 {
        //                    let v = UIView.init(frame: CGRect.init(x: CGFloat(j)*size, y: CGFloat(i)*size+180, width: size, height: size))
        //                    v.backgroundColor = UIColor.black
        //                    view.addSubview(v)
        //                }
        //            }
        //        }
        
        //color
        //
        let imageview3 = UIImageView.init(frame: CGRect.init(x: 10, y: 00+CGFloat(dataImge.count)*size, width: CGFloat(dataImge.count)*size, height: CGFloat(dataImge.count)*size))
        imageview3.image = reheader
        view.addSubview(imageview3)
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
                        if l <= 7 && i <= 7 {
                            //
                            sta = true
                        }else
                            if i >= data.count - 8 && l <= 7 {
                                //
                                sta = true
                            }else
                                if i <= 7 && l >= data.count - 8 {
                                    //
                                    sta = true
                                }else
                                    if i <= data.count - 6 && i > data.count - 6 - 5 && l <= data.count - 6 && l > data.count - 6 - 5 {
                                        //
                                        sta = true
                }
                //其他设定
                //
                
                
                let v = UIView()
                if sta {
                    //大点
                    v.frame = CGRect.init(x: CGFloat(i)*size*3, y: CGFloat(l)*size*3, width: size*3, height: size*3)
                }else{
                    //小的
                    v.frame = CGRect.init(x: CGFloat(i)*size*3+size, y: CGFloat(l)*size*3+size, width: size, height: size)
                }
                
                if data[l][i] == 0{
                    v.backgroundColor = UIColor.black
                }else{
                    v.backgroundColor = UIColor.white
                }
                imageview3.addSubview(v)
                
            }
        }
    }
    
    /// 带颜色的二维码
    ///
    /// - Parameter color: 颜色
    func qrcode(color:UIColor){
        let colorQR = UIImageView.init(frame: CGRect.init(x: 180, y: 360, width: 200, height: 200))
        view.addSubview(colorQR)
        colorQR.image = QRCodeModule.qrcode(color: color, message: "测试的内容")
    }
    
    func qrcode(type:Int){
        let colorQR = UIImageView.init(frame: CGRect.init(x: 10, y: 360, width: 200, height: 200))
        view.addSubview(colorQR)
        colorQR.image = QRCodeModule.qrcode(type: 0, message: "cessssss")
        
        let mask = QRCodeMaskView.init(frame: CGRect.init(x: 10, y: 560, width: 200, height: 200))
        mask.backgroundColor = UIColor.yellow
        view.addSubview(mask)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
