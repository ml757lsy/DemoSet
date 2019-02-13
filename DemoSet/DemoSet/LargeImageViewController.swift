//
//  LargeImageViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2019/1/7.
//  Copyright © 2019 Far. All rights reserved.
//

import UIKit

class LargeImageViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        perform(#selector(initLarge), with: nil, afterDelay: 0.1)
    }
    
   @objc func initLarge() {
        let image = UIImage.init(named: "largeImage")
    
        let large = TiledImageView.initWith(frame: view.bounds, image: image!)
        view.addSubview(large)
    
//    let imageview = UIImageView.init(frame: view.bounds);
//    imageview.image = image;
//    view.addSubview(imageview)
    
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
