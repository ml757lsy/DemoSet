//
//  CIFilterViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2018/6/13.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

/// 各种滤镜的使用
class CIFilterViewController: BaseViewController {
    

    let backScroll = UIScrollView()
    let originalImage = UIImage.init(named: "testImage4")
    
    var size:CGFloat = 0
    var space:CGFloat = 10
    var y:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initView()
        perform(#selector(filter), with: nil, afterDelay: 3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        backScroll.frame = view.bounds
        view.addSubview(backScroll)
        
        size = (view.width-space*3)/2
        y = space
        
        let originalImageView = UIImageView.init(frame: CGRect.init(x: space, y: y, width: size, height: size))
        originalImageView.image = originalImage
        backScroll.addSubview(originalImageView)
        
        y += size+space*2
    }
    
    func filter() {
        
        
        let names = CIFilter.filterNames(inCategory: nil)
        print(names)
        for name in names {
//            let cgimage = originalImage?.cgImage
//            var ciimage = CIImage.init(cgImage: cgimage!)
//            let filter = CIFilter.init(name: name)
//            filter?.setValue(ciimage, forKey: kCIInputImageKey)
//            ciimage = (filter?.outputImage)!
//
//            //
//            let just = UIImageView.init(frame: CGRect.init(x: space, y: y, width: size, height: size))
//            backScroll.addSubview(just)
//            just.image = UIImage.init(ciImage: ciimage)
//            y += size+space*2
        }
        
        //
        let cgimage = originalImage?.cgImage
        var ciimage = CIImage.init(cgImage: cgimage!)
        let filters = ciimage.autoAdjustmentFilters()
        for fil in filters {
            //
            fil.setValue(ciimage, forKey: kCIInputImageKey)
            ciimage = fil.outputImage!
        }
        let just = UIImageView.init(frame: CGRect.init(x: space, y: y, width: size, height: size))
        backScroll.addSubview(just)
        just.image = UIImage.init(ciImage: ciimage)
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
