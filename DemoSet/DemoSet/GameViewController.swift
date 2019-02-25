//
//  GameViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2019/2/1.
//  Copyright © 2019 Far. All rights reserved.
//

import UIKit

/// 小游戏
class GameViewController: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    var gameList:[String] = []
    var collection = UICollectionView.init(frame: CGRect.init(), collectionViewLayout: UICollectionViewLayout.init())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initListView()
        
    }
    
    func initListView() {
        
        //list
        gameList.append("Minesweeper")
        
        
        //layout
        for _ in gameList {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize.init(width: 200, height: 100)
            
            collection = UICollectionView.init(frame: view.bounds, collectionViewLayout: layout)
            collection.delegate = self
            collection.dataSource = self
            collection.backgroundColor = UIColor.clear
            view.addSubview(collection)
            collection.snp.makeConstraints { (make) in
                make.left.top.bottom.right.equalTo(0)
            }
            
            collection.register(HomeCollectionCell.self, forCellWithReuseIdentifier: "Homecell")
        }
        
    }
    
    func gameSelected(index:Int) {
        var aimController:UIViewController = UIViewController()
        
        switch index {
        case 0:
            //
            aimController = MinesweeperViewController()
            break
        case 1:
            break
        case 2:
            break
        default:
            //
            break
        }
        
        self.navigationController?.pushViewController(aimController, animated: true)
    }
    
    //MARK: - delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:HomeCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Homecell", for: indexPath) as! HomeCollectionCell
        cell.backgroundColor = UIColor.randomColor()
        cell.label.I18NLocalized(key: gameList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 200, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        gameSelected(index: indexPath.row)
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
