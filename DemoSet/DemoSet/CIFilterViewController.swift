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
        
        let categories = ["kCICategoryDistortionEffect",
                          "kCICategoryGeometryAdjustment",
                          "kCICategoryCompositeOperation",
                          "kCICategoryHalftoneEffect",
                          "kCICategoryColorAdjustment",
                          "kCICategoryColorEffect",
                          "kCICategoryTransition",
                          "kCICategoryTileEffect",
                          "kCICategoryGenerator",
                          "kCICategoryReduction",
                          "kCICategoryGradient",
                          "kCICategoryStylize",
                          "kCICategorySharpen",
                          "kCICategoryBlur",
                          "kCICategoryVideo",
                          "kCICategoryStillImage",
                          "kCICategoryInterlaced",
                          "kCICategoryNonSquarePixels",
                          "kCICategoryHighDynamicRange",
                          "kCICategoryBuiltIn",
                          "kCICategoryFilterGenerator",
        ];
        let filterNames = CIFilter.filterNames(inCategories: categories)
        for name in filterNames {
            print(name)
//            let att = CIFilter.init(name: name)?.attributes
//            print(att)
        }
    }
    
    @objc func filter() {
        let names = CIFilter.filterNames(inCategory: nil)
        print(names)
        
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
        y += size + space
        
        //
        loadFace()
    }
    
    
    // MARK: - 人脸识别
    func loadFace() {
        let image = UIImage.init(named: "testImage5")
        let ciimage = CIImage.init(cgImage: (image?.cgImage)!)
        
        if ciimage == nil {
            return 
        }
        
        //
        let w = (image?.size.width)!/2
        let h = (image?.size.height)!/2
        let imageview = UIImageView.init(frame: CGRect.init(x: space, y: y, width: w, height: h))
        imageview.image = image
        y += h+space
        backScroll.addSubview(imageview)
        backScroll.contentSize = CGSize.init(width: backScroll.width, height: y*1.5)
        
        
        let context = CIContext.init(options: nil)
        let param:[String:Any] = [CIDetectorAccuracy:CIDetectorAccuracyHigh,
                                  CIDetectorSmile:true]
        
        let faceDec = CIDetector.init(ofType: CIDetectorTypeFace, context: context, options: param)
        
        let features = faceDec?.features(in: ciimage)
        for feature in features! {
            print(feature.type)
            if feature.type == CIFeatureTypeFace {
                print(feature.bounds)
                let facefeature = feature as! CIFaceFeature
                print(facefeature.leftEyePosition)
                print(facefeature.rightEyePosition)
                print(facefeature.mouthPosition)
                print(facefeature.hasSmile)
                
                //y轴是从下往上来的
                //sign
                let box = UIView.init(frame: CGRect.init(x: feature.bounds.origin.x/4, y: imageview.height - feature.bounds.origin.y/4, width: feature.bounds.size.width/4, height: -feature.bounds.size.height/4))
                box.layer.borderWidth = 1
                box.layer.borderColor = UIColor.red.cgColor
                box.backgroundColor = UIColor.clear
                imageview.addSubview(box)
                
                if facefeature.hasMouthPosition {
                    let mouth = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 8, height: 8))
                    mouth.backgroundColor = UIColor.init(red: 1, green: 0, blue: 0, alpha: 0.8)
                    mouth.center = CGPoint.init(x: facefeature.mouthPosition.x/4, y:imageview.height - facefeature.mouthPosition.y/4)
                    imageview.addSubview(mouth)
                }
                
                if  facefeature.hasLeftEyePosition {
                    let left = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 5, height: 5))
                    left.layer.backgroundColor = UIColor.init(red: 0, green: 1, blue: 0, alpha: 0.8).cgColor
                    left.center = CGPoint.init(x: facefeature.leftEyePosition.x/4, y: imageview.height-facefeature.leftEyePosition.y/4)
                    imageview.addSubview(left)
                }
                
                if facefeature.hasRightEyePosition {
                    let right = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 5, height: 5))
                    right.layer.backgroundColor = UIColor.init(red: 0, green: 1, blue: 0, alpha: 0.8).cgColor
                    right.center = CGPoint.init(x: facefeature.rightEyePosition.x/4, y: imageview.height-facefeature.rightEyePosition.y/4)
                    imageview.addSubview(right)
                }
                
                if facefeature.hasSmile {
                    print("smile")
                }
                if facefeature.hasFaceAngle {
                    print(facefeature.faceAngle)
                    box.transform = CATransform3DGetAffineTransform(CATransform3DMakeRotation(CGFloat(facefeature.faceAngle/90), 0, 0, 1))
                }
                //自己计算角度
                let y = facefeature.rightEyePosition.y - facefeature.leftEyePosition.y
                let x = facefeature.rightEyePosition.x - facefeature.leftEyePosition.x
                let c = sqrt(y*y+x*x)
                var a = asin(y/c)
                print(a)
                if(y < 0) {
                    a = a * -1;
                }
                box.transform = CATransform3DGetAffineTransform(CATransform3DMakeRotation(-a, 0, 0, 1))
            }
            print("--------")
        }
    }
    
    // MARK:- 矩形识别
    func loadBox() {
        let context = CIContext.init(options: nil)
        let dector = CIDetector.init(ofType: CIDetectorTypeRectangle, context: context, options: nil)
    }
    
    func imageMask() {
        
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
