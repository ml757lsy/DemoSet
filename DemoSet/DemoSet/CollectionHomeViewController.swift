//
//  CollectionHomeViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2018/7/13.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

class CollectionHomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initTest()
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        let toBox = UIButton.init(type: .system)
        toBox.setTitle("Box", for: .normal)
        toBox.addTarget(self, action: #selector(toBoxVC), for: .touchUpInside)
        
        let right = UIBarButtonItem.init(customView: toBox)
        navigationItem.rightBarButtonItem = right
        
    }
    
    @objc func toBoxVC() {
        let boxvc = CollectionBoxViewController()
        navigationController?.pushViewController(boxvc, animated: true)
    }
    
    func initTest() {
        //
        let model = CollectionModel()
        model.name = "Test"
        model.card = CollectionModel.card(withName: "backGround")
        //bwQ5-c1w8XoZ6jT3cSb0-g9.gif
        model.card = CollectionModel.card(withName: "bwQ5-c1w8XoZ6jT3cSb0-g9")
        
        //
        let card = CollectionCard.init(frame: CGRect.init(x: 40, y: 40, width: 100, height: 178))
        card.frame = CGRect.init(x: 0, y: 0, width: 100, height: 178)
        view.addSubview(card)
        
        card.model = model
        
        //new
        //3B63A8C86AF3E15972D664A98D1610AB
        //bwQ5-g4puXiZ4zT1kS8a-8q
        //t01348fb6a07ef8447b
        
        let gi = UIImageView.init(frame: CGRect.init(x: 40, y: 250, width: 200, height: 166))
        view.addSubview(gi)
        var path = "a"
        path = Bundle.main.path(forResource: "3B63A8C86AF3E15972D664A98D1610AB", ofType: "gif") ?? ""
        gi.loadgif(url: URL.init(fileURLWithPath: path))
        
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
