//
//  ReaderViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2018/5/17.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

class ReaderViewController: BaseViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    var list:[UIImage] = []
    
    var collection = UICollectionView.init(frame: CGRect.init(), collectionViewLayout: UICollectionViewLayout.init())
    var fileList:[String] = []
    var filePath:[String] = []//走过的路径
    
    var space:CGFloat = 10
    var num:CGFloat = 3
    var size:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
        var path = NSHomeDirectory()
        path.append("/Documents")
        loadFiles(path: path)
        filePath.append(path)
        Print(path)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        
        size = (SCREENWIDTH - (num+2) * space)/num
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: size, height: size)
        
        collection = UICollectionView.init(frame: view.bounds, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.clear
        view.addSubview(collection)
        collection.snp.makeConstraints { (make) in
            make.left.top.bottom.right.equalTo(0)
        }
        
        collection.register(ReaderFileCell.self, forCellWithReuseIdentifier: "ReaderFileCell")
        
        //
        let back = UIButton.init(type: .system)
        back.setTitle("返回", for: .normal)
        back.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
        back.addTarget(self, action: #selector(backToLast), for: .touchUpInside)
        
        let right = UIBarButtonItem.init(customView: back)
        navigationItem.rightBarButtonItem = right
        
        return
        let banner = BaseBannerView.init(frame: CGRect.init(x: 10, y: 10, width: view.frame.size.width-20, height: 200))
        banner.images = ["banner1","banner2","banner3","banner4","banner5","banner6",]
        view.addSubview(banner)
    }
    
    /// 加载目录列表
    ///
    /// - Parameter path: 列表
    func loadFiles(path:String) {
        do {
            let files = try FileManager.default.contentsOfDirectory(atPath: path)
            fileList.removeAll()
            for file in files {
                fileList.append(path + "/" + file)
            }
            fileList.sort()
            collection.reloadData()
        } catch let error {
            print(error)
        }
    }
    
    /// 返回上一层
    func backToLast() {
        if filePath.count > 1 {
            //
            let pa = filePath[filePath.count-2]
            filePath.removeLast()
            loadFiles(path: pa)
        }
    }
    
    /// 项目点击
    ///
    /// - Parameter index: index
    func cellClick(index:Int) {
        //do
        let p = fileList[index]
        if !p.containsSigns(sign: ".") {
            filePath.append(p)
            loadFiles(path: p)
        }else{
            //去展示
            //过滤
            let suf = p.components(separatedBy: ".").last?.lowercased()
            var files:[String] = []
            for pp in fileList {
                if pp.hasSuffix(suf!) {
                    files.append(pp)
                }
            }
            if suf == ".mp4" {
                //
                let play = PlayerViewController()
                play.playList = files
                play.current = files.index(of: p)!
                navigationController?.pushViewController(play, animated: true)
            }else{
                let content = ReaderContentViewController()
                content.files = files
                content.current = files.index(of: p)!
                navigationController?.pushViewController(content, animated: true)
            }
        }
    }
    
    //MARK: - delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fileList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ReaderFileCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReaderFileCell", for: indexPath) as! ReaderFileCell
        cell.string = fileList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: size, height: size*0.9)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(space, space, space, space)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return space
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return space
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellClick(index: indexPath.row)
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
