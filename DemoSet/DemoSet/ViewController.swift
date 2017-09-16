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

    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = .init(rawValue: 0)
        initMainView()
    }
    
    func initMainView() {
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
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

