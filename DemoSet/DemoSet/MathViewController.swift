//
//  MathViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/10/19.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

/// 数学相关的好多玩意
class MathViewController: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    private let FibonacciLabel = UILabel()
    private var questions:[String] = []
    private var collection:UICollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //view
    func initView() {
        //view
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: 150, height: 70)
        collection = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: view.width, height: view.height-200), collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(MathCollectionCell.self, forCellWithReuseIdentifier: "mcell")
        view.addSubview(collection)
        
        //data
        questions.append("Fibonacci")
        questions.append("Palindrome")
        questions.append("BinaryTree")
        questions.append("PI")
        questions.append("3门问题")
        questions.append("BIGNUM")
        questions.append("数学公式")
    }
    
    //MARK: - delelgate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:MathCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "mcell", for: indexPath) as! MathCollectionCell
        cell.label.text = questions[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 150, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            Fibinacci()
            break
        case 1:
            PalindromeNumClick()
            break
        case 2:
            binaryTreeClick()
            break
        case 3:
            mpi()
            break
        case 4:
            threedoor()
            break
        case 5:
            break
        case 6:
            break
        default:
            break
        }
    }
    
    //MARK: - func
    
    /// 大数相关
    func bignum() {
        let n1 = "2222223"
        let n2 = "159"
        
        let n3 = n1 * n2;
        let n4 = n1.minus(rhs: n3)
        let n5 = n1.add(rhs: n4)
        let n6 = "9999".divid(rhs: "33").add(rhs: n5)
        
        print(n6)
    }
    
    //MARK: - fibinacci
    /// 计算斐波那契数
    @objc func Fibinacci() {
        let index = 40
        
        let s = Date()
        let n = getFibonacciNum(at: index)
        let end = Date()
        let d = end.timeIntervalSince1970-s.timeIntervalSince1970
        
        let ns = Date()
        let nn = getFibonacciNum(at: index-2, with: 1, and: 1)
        let ne = Date()
        let nd = ne.timeIntervalSince1970-ns.timeIntervalSince1970

        alert(message: "计算第\(index)位斐波那契数\n结果\(n)--\(nn)\n递归用时:\(d)\n尾递归用时:\(nd)")
        /*
         fn = (1/sqr(5))*(pow(((1+sqr(5))/2),n)+pow(((1-sqr(5))/2),n))
         //通项公式
         */
    }
    
    //尾递归
    func getFibonacciNum(at index:Int, with a:Int, and b:Int) -> Int {
        var newindex = index
        if index > 0 {
            newindex -= 1
            
            return getFibonacciNum(at:newindex, with:b, and: a+b)
        }else{
            return a+b
        }
    }
    
    /// 水仙花数
    ///
    /// - Parameter index: 第几个
    /// - Returns: 数值
    func getFibonacciNum(at index:Int) ->Int {
        
        if index < 2 {
            return 1
        }
        return getFibonacciNum(at:index-1) + getFibonacciNum(at:index-2)
    }
    
    
    //MARK: - palindromenumber
    @objc func PalindromeNumClick() {
        let alert = UIAlertController.init(title: "", message: "输入初始数字", preferredStyle: .alert)
        
        alert.addTextField { (textfiled) in
        }
        
        let commit = UIAlertAction.init(title: "ji", style: .default) { (action) in
            if (alert.textFields?.count)! > 0 {
                let text = alert.textFields![0]
                self.palindrimeNumComit(num: text.text!,time: 1)
            }
            
            alert.dismiss(animated: true, completion: {
                //
            })
        }
        
        alert.addAction(commit)
        
        present(alert, animated: true) {
            //
        }
    }
    
    func palindrimeNumComit(num:String, time:Int){
        
        let seriation = num as NSString
        var count:String = ""
        
        var add:Int = 0
        for i in 0..<seriation.length {
            let c1:Int = Int(seriation.character(at: i)) - 48
            let c2:Int = Int(seriation.character(at: seriation.length-1-i)) - 48
            
            var c = c1 + c2 + add
            if c >= 10 {
                c -= 10
                add = 1
            }else{
                add = 0
            }
            count = "\(c)"+count
        }
        
        if add == 1{
            count = "1"+count
            add = 0
        }
        
        if checkPalindrime(num: count) {
            alert(message: "回文数字为"+count+"\n\(time)次计算")
        }else{
            alert(message: count+" not Palindrime")
            palindrimeNumComit(num: count,time: time+1)
        }
        
        
    }
    
    /// 回文数
    ///
    /// - Parameter num: 数字串
    /// - Returns: 是否
    func checkPalindrime(num:String) -> Bool {
        let numstring = num as NSString
        let count = numstring.length
        for i in 0..<count {
            let c1 = numstring.character(at: i)
            let c2 = numstring.character(at: count-1-i)
            if c1 != c2 {
                return false
            }
        }
        
        return true
    }
    //MARK: - primenumber
    /// 检测是不是质数
    ///
    /// - Parameter num: 数字
    /// - Returns: 是否
    func checkPrimenumber(num:Int64) -> Bool {
        let primelist:[Int64] = [2,3,5,7,13,61,24251]
        for n in primelist {
            if num == n {
                return true
            }
            if !check(nn: num, pp: n, dd: num-1) {
                return false
            }
        }
        
        return true
    }
    
    /// 费马小定理判定
    ///
    /// - Parameters:
    ///   - nn: 数字
    ///   - pp: 质数
    ///   - dd: 值
    /// - Returns: 结果
    func check(nn:Int64,pp:Int64,dd:Int64) -> Bool {
        var n = nn;
        var p = pp;
        var d = dd;
        if n == 2 {
            return true
        }
        if n == p {
            return false
        }
        
        if ((n&1)<=0) {
            return true
        }
        while (d&1) <= 0 {
            d = d >> 1
        }
        var t = pow_mod(a: p, b: d, r: n)
        while (d != (n-1))&&(t != n-1)&&(t != 1) {
            t = t*t%n
            d = d<<1
        }
        return t == n-1 || (d&1) == 1
    }
    
    func pow_mod(a:Int64,b:Int64,r:Int64) -> Int64 {
        var ans:Int64 = 1
        var buff = a
        var b = b
        while b > 0 {
            if b&1 > 0 {
                ans = (ans * buff)%r
                buff = (buff * buff)%r
                b = b>>1
            }
        }
        return ans
    }
    
    //MARK: - 概率
    func probability(p:CGFloat) {
        let c = 100//拆分次数 每百次出现
        //第100次必定出现
    }
    
    
    //MARK: - 二叉树
    @objc func binaryTreeClick() {
        let bin = BinaryTreeViewController()
        navigationController?.pushViewController(bin, animated: true)
    }
    
    // 计算pi
    func mpi() {
        /*
         4/1-4/3+4/5```
         */
        var n:Double = 1
        var b:Bool = true
        var p:Double = 0
        while Int64(n) < INT64_MAX {
            //
            
            if b {
                p += 4/n
            }else{
                p -= 4/n
            }
            b = !b
            n += 2
            
            print(p)
            sleep(1)
        }
    }
    
    func threedoor() {
        let aim = arc4random()%3;//设定
        let choose = arc4random()%3;//选择
        let close = ((arc4random()%2+1)+choose)%3;
        //中
    }
    
    func toLaTextVC() {
        let latex = LaTeXViewController.init()
        navigationController?.pushViewController(latex, animated: true)
    }
    
    /// 提示吧
    /// - Parameter message: msg
    func alert(message:String) {
        let alert = UIAlertController.init(title: "提示", message: message, preferredStyle: .alert)
        let ok = UIAlertAction.init(title: "OK", style: .default) { (ac) in
        }
        alert.addAction(ok)
        present(alert, animated: true) {
        }
    }

}

class MathCollectionCell: UICollectionViewCell {
//
    let label:UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func customInit() {
        addSubview(label)
        label.textColor = UIColor.orange
        label.textAlignment = .center
        label.numberOfLines = 0
        label.snp.makeConstraints { (make) in
            make.left.top.equalTo(5)
            make.right.equalTo(-5)
            make.bottom.equalTo(-5)
        }
        //其他需要国际化的地方
        enableI18N()
    }

    override func refreshI18N(noti: NSNotification) {
        //
    }

    deinit {
        disableI18N()
    }
    
}
