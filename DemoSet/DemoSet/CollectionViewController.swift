
//
//  CollectionViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2018/7/5.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

class CollectionViewController: BaseViewController {
    
    var list:[Int] = []
    var collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        for i in 0..<10 {
            list.append(i)
        }
        
        //
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: 100, height: 100)

        collectionView = UICollectionView.init(frame: view.bounds, collectionViewLayout: layout)
        collectionView.register(HomeCollectionCell.self, forCellWithReuseIdentifier: "homecell")
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CollectionViewController:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
        delete(index: indexPath)
    }
    
    func delete(index:IndexPath) {
        list.remove(at: index.row)
        let cell = collectionView.cellForItem(at: index)
        let rect = collectionView.convert((cell?.frame)!, to: view)
        collectionView.deleteItems(at: [index])
        
        
        let v = UIView.init(frame: rect)
        v.backgroundColor = UIColor.red
        view.addSubview(v)
        
        let effect = CAEmitterLayer.init()
        effect.lifetime = 1
        effect.birthRate = 20
        effect.emitterSize = CGSize.init(width: 10, height: 10)
    }
    
}

extension CollectionViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homecell", for: indexPath) as! HomeCollectionCell
        cell.label.text = "\(list[indexPath.row])"
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 100, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    }

    
}
