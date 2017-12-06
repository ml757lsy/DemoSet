//
//  ViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/6/9.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var list:[String] = []
    
    private let backImage = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = .init(rawValue: 0)
        initMainView()
        other()
    }
    
    func initMainView() {
        backImage.frame = CGRect.init(x: -100, y: -100, width: view.width+200, height: view.height+200)
        view.addSubview(backImage)
        backImage.image = UIImage.init(named: "backGround")
        backImage.contentMode = UIViewContentMode.scaleAspectFill
        
        let speed:CGFloat = 1
        GyroManager.manager.updateInterval = 0.1
        GyroManager.manager.startDeviceMotion { (x, y, z) in
            //
            DispatchQueue.main.async {
                var lx:CGFloat = self.backImage.x + speed*y
                if self.backImage.x < -200{
                    lx = -200
                }
                if self.backImage.x > 0{
                    lx = 0
                }
                
                var ly:CGFloat = self.backImage.y + speed*x
                if self.backImage.y < -200{
                    ly = -200
                }
                if self.backImage.y > 0{
                    ly = 0
                }
                
                UIView.animate(withDuration: 0.1, animations: {
                    self.backImage.frame = CGRect.init(x: lx, y: ly, width: self.backImage.width, height: self.backImage.height)
                })
            }
        }
        
        //
        list.append("Cell")
        list.append("Sort")
        list.append("Numberboard")
        list.append("Animation")
        list.append("FGO")
        list.append("IconChange")
        list.append("ImageCrawler")
        list.append("PointLine")
        list.append("QRCode")
        list.append("Face")
        list.append("Wave")
        list.append("MessageFilter")
        list.append("NFC")
        list.append("Bluetooth")
        list.append("MaskView")
        list.append("Lottery")
        list.append("Math")
        list.append("Banner")
        list.append("AppStore")
        
        let column:Int = 3
        let spec:CGFloat = 20
        let btnWidth:CGFloat = (view.width-CGFloat(column+1)*spec)/CGFloat(column)
        let btnHeight:CGFloat = 40
        
        for i in 0..<list.count {
            let title = list[i]
            
            let button = UIButton()
            button.frame = CGRect.init(x: spec+(btnWidth+spec)*CGFloat(i%column), y: 20+(btnHeight+spec)*CGFloat(i/column), width: btnWidth, height: btnHeight)
            button.setTitle(title, for: .normal)
            button.tag = i
            button.setTitleColor(UIColor.orange, for: .normal)
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.orange.cgColor
            button.layer.cornerRadius = 4
            button.addTarget(self, action: #selector(buttonClick(button:)), for: .touchUpInside)
            view.addSubview(button)
        }
    }
    
    func buttonClick(button:UIButton){
        switch button.tag {
        case 0:
            //
            let cell = CellularAutomatonViewController()
            navigationController?.pushViewController(cell, animated: true)
            break
        case 1:
            //
            let sort = SortViewController()
            navigationController?.pushViewController(sort, animated: true)
            break
        case 2:
            //
            let num = NumberboardViewController()
            navigationController?.pushViewController(num, animated: true)
            break
        case 3:
            //
            let ani = AnimationViewController()
            navigationController?.pushViewController(ani, animated: true)
            break
        case 4:
            //
            let fgo = FGOViewController()
            navigationController?.pushViewController(fgo, animated: true)
            break
        case 5:
            let changeiocn = IconChangeViewController()
            navigationController?.pushViewController(changeiocn, animated: true)
            break
        case 6:
            let crawler = ImageCrawlerViewController()
            navigationController?.pushViewController(crawler, animated: true)
            break
        case 7:
            let pline = PointLineViewController()
            navigationController?.pushViewController(pline, animated: true)
            break
        case 8:
            let qrcode = QRCodeViewController()
            navigationController?.pushViewController(qrcode, animated: true)
            break
        case 9:
            let face = FaceRecognitionViewController()
            navigationController?.pushViewController(face, animated: true)
            break
        case 10:
            let wave = WaveViewController()
            navigationController?.pushViewController(wave, animated: true)
            break
        case 11:
            let filter = MessageFliterViewController()
            navigationController?.pushViewController(filter, animated: true)
            break
        case 12:
            if #available(iOS 11.0, *) {
                let nfc = NFCViewController()
                navigationController?.pushViewController(nfc, animated: true)
            } else {
                // Fallback on earlier versions
            }
        case 13:
            let blu = BluetoothConnectionViewController()
            navigationController?.pushViewController(blu, animated: true)
            break
        case 14:
            let mask = MaskViewController()
            navigationController?.pushViewController(mask, animated: true)
            break
        case 15:
            let lottery = LotteryViewController()
            navigationController?.pushViewController(lottery, animated: true)
        case 16:
            let math = MathViewController()
            navigationController?.pushViewController(math, animated: true)
            break
        case 17:
            let banner = BannerViewController()
            navigationController?.pushViewController(banner, animated: true)
            break
        case 18:
            let appstore = AppStoreViewController()
            navigationController?.pushViewController(appstore, animated: true)
            break
            
        default:
            break
        }
    }
    
    func other() {
        let name = UIDevice.current.modelName
        print(name)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

