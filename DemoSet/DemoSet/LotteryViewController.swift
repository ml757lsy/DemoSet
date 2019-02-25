//
//  LotteryViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/10/17.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

class LotteryViewController: BaseViewController {
    
    var top:CGFloat = 40


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        perform(#selector(getNum), with: nil, afterDelay: 0.1)
        perform(#selector(getDoubleChromosphereNum), with: nil, afterDelay: 0.1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func getNum() -> [Int]{
        let rmax = 35
        let bmax = 12
        
        var red:[Int] = []
        while red.count < 5 {
            
            let n = Int(arc4random())%rmax + 1
            
            if red.contains(n){
                continue
            }else{
                red.append(n)
            }
        }
        
        red = sort(array: red)
        
        var blue:[Int] = []
        while blue.count < 2 {
            
            let n = Int(arc4random())%bmax + 1
            
            if blue.contains(n){
                continue
            }else{
                blue.append(n)
            }
        }
        blue = sort(array: blue)
        
        print(red + blue)
        updateView(red: red, blue: blue)
        
        return red + blue
    }
    
    @objc func getDoubleChromosphereNum() {
        let max = 33
        let m = 16
        
        var red:[Int] = []
        while red.count < 6 {
            let n = Int(arc4random())%max+1
            if !red.contains(n) {
                red.append(n)
            }
        }
        red = sort(array: red)
        
        let b = Int(arc4random())%m+1
        
        updateView(red: red, blue: [b])
    }
    
    func updateView(red:[Int], blue:[Int]) {
        
        let ballWidth:CGFloat = 40
        let spec:CGFloat = 10
        for i in 0..<red.count {
            let ball = UILabel.init(frame: CGRect.init(x: 10+(ballWidth+spec)*CGFloat(i), y: top, width: ballWidth, height: ballWidth))
            view.addSubview(ball)
            ball.backgroundColor = UIColor.red
            ball.layer.cornerRadius = ballWidth/2
            ball.clipsToBounds = true
            ball.textAlignment = .center
            ball.textColor = UIColor.white
            ball.font = UIFont.boldSystemFont(ofSize: 20)
            ball.text = "\(red[i])"
        }
        for i in 0..<blue.count {
            let ball = UILabel.init(frame: CGRect.init(x: 10+(ballWidth+spec)*CGFloat(i+red.count), y: top, width: ballWidth, height: ballWidth))
            view.addSubview(ball)
            ball.backgroundColor = UIColor.blue
            ball.layer.cornerRadius = ballWidth/2
            ball.clipsToBounds = true
            ball.textAlignment = .center
            ball.textColor = UIColor.white
            ball.font = UIFont.boldSystemFont(ofSize: 20)
            ball.text = "\(blue[i])"
        }
        
        top += 60
    }
    
    /// 数组排序
    ///
    /// - Parameter array: 数组
    /// - Returns: 数组
    func sort( array:[Int]) -> [Int] {
        var tempArray = array
        for i in 0..<tempArray.count {
            for j in i..<tempArray.count {
                if tempArray[i] > tempArray[j]{
                    tempArray.swapAt(i, j)
                }
            }
        }
        return tempArray
    }
    
}
