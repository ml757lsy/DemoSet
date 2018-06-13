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
//        qrcode(color: UIColor.purple)
//        qrcode(type: 0)
    }
    
    func initView () {
        backScroll = UIScrollView.init(frame: view.bounds)
        backScroll.contentSize = CGSize.init(width: SCREENWIDTH, height: SCREENHEIGHT*2)
        backScroll.backgroundColor = UIColor.lightGray
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
        
        
        //2.data
        data = QRCodeModule.data(with: qrcodimage)
        
        //3.image
        let image = UIImage.init(named: "testImage3")
        let reheader = image?.resize(with: .none, rate: CGFloat(data.count)*3/(image?.size.width)!)
        
        //original
        let orgImg = UIImageView.init(frame: CGRect.init(x: space, y: (qrsize + space), width: qrsize, height: qrsize))
        orgImg.image = reheader
        backScroll.addSubview(orgImg)
        //binaryzation
        let binImg = UIImageView.init(frame: CGRect.init(x: qrsize + space * 2, y: (qrsize + space), width: qrsize, height: qrsize))
        binImg.image = reheader?.binaryzation()
        backScroll.addSubview(binImg)
        
        //join
        let imgcode = UIImageView.init(frame: CGRect.init(x: space, y: (qrsize + space)*2, width: qrsize, height: qrsize))
        backScroll.addSubview(imgcode)
        imgcode.image = QRCodeModule.qrcode(message: "123123123aaaaaa", backImg: image!)
        
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
