//
//  ASCIIImageViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2019/2/22.
//  Copyright © 2019 Far. All rights reserved.
//

import UIKit

/// 图片字符
class ASCIIImageViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let img = UIImage.init(named: "banner1")
        let size = CGSize.init(width: (img?.size.width ?? 100)/2, height: (img?.size.height ?? 100)/2)
        let labelFont = UIFont(name: "Menlo", size: 7)!
        
        
        ASCIIImage.defaultTool.font = labelFont
        let asciiArt = ASCIIImage.defaultTool.str(img!, size: size)
        
        let label = UILabel()
        label.font = labelFont
        label.textColor = .black
        label.lineBreakMode = NSLineBreakMode.byClipping
        label.numberOfLines = 0
        label.text = asciiArt
        label.sizeToFit()
        
        let scroll = UIScrollView.init(frame: view.bounds)
        scroll.contentSize = label.bounds.size
        scroll.addSubview(label)
        view.addSubview(scroll)
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
