//
//  ViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/6/9.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    private var list:[String] = []
    
    private let backImage = UIImageView()
    
    var collection = UICollectionView.init(frame: CGRect.init(), collectionViewLayout: UICollectionViewLayout.init())

    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = .init(rawValue: 0)
        initMainView()
        other()
    }
    
    func initMainView() {
        backImage.frame = CGRect.init(x: -100, y: -100, width: view.width+200, height: view.height+200)
        view.addSubview(backImage)
        backImage.image = UIImage.init(named: "backGround")
        backImage.contentMode = UIViewContentMode.scaleAspectFill
        
        let speed:CGFloat = 1
        GyroManager.manager.updateInterval = 0.1
        GyroManager.manager.startDeviceMotion { (x, y, z) in
            //
            DispatchQueue.main.async {
                var lx:CGFloat = self.backImage.x + speed*y
                if self.backImage.x < -200{
                    lx = -200
                }
                if self.backImage.x > 0{
                    lx = 0
                }
                
                var ly:CGFloat = self.backImage.y + speed*x
                if self.backImage.y < -200{
                    ly = -200
                }
                if self.backImage.y > 0{
                    ly = 0
                }
                
                UIView.animate(withDuration: 0.1, animations: {
                    self.backImage.frame = CGRect.init(x: lx, y: ly, width: self.backImage.width, height: self.backImage.height)
                })
            }
        }
        
        //
        list.append("Cell")
        list.append("Sort")
        list.append("Numberboard")
        list.append("Animation")
        list.append("FGO")
        list.append("IconChange")
        list.append("ImageCrawler")
        list.append("PointLine")
        list.append("QRCode")
        list.append("Face")
        list.append("Wave")
        list.append("MessageFilter")
        list.append("NFC")
        list.append("Bluetooth")
        list.append("MaskView")
        list.append("Lottery")
        list.append("Math")
        list.append("Banner")
        list.append("AppStore")
        list.append("Runtime")
        list.append("Casino")
        list.append("Subway")
        list.append("ToDoEveryday")
        list.append("Web")
        list.append("Reader")
        list.append("Evolution")
        list.append("Password Produce")
        list.append("I18N")
        list.append("CIFilter")
        list.append("Landscape")
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: 100, height: 100)
        
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
    
    func cellClick(index:Int){
        
        var aimController:UIViewController = UIViewController()
        switch index {
        case 0:
            //
            aimController = CellularAutomatonViewController()
            break
        case 1:
            //
            aimController = SortViewController()
            break
        case 2:
            //
            aimController = NumberboardViewController()
            break
        case 3:
            //
            aimController = AnimationViewController()
            break
        case 4:
            //
            aimController = FGOViewController()
            break
        case 5:
            aimController = IconChangeViewController()
            break
        case 6:
            aimController = ImageCrawlerViewController()
            break
        case 7:
            aimController = PointLineViewController()
            break
        case 8:
            aimController = QRCodeViewController()
            break
        case 9:
            aimController = FaceRecognitionViewController()
            break
        case 10:
            aimController = WaveViewController()
            break
        case 11:
            aimController = MessageFliterViewController()
            break
        case 12:
            if #available(iOS 11.0, *) {
                aimController = NFCViewController()
            } else {
                // Fallback on earlier versions
                return
            }
        case 13:
            aimController = BluetoothConnectionViewController()
            break
        case 14:
            aimController = MaskViewController()
            break
        case 15:
            aimController = LotteryViewController()
        case 16:
            aimController = MathViewController()
            break
        case 17:
            aimController = BannerViewController()
            break
        case 18:
            aimController = AppStoreViewController()
            break
        case 19:
            aimController = RuntimeViewController()
            break
        case 20:
            aimController = CasinoViewController()
            break
        case 21:
            aimController = SubwayViewController()
            break
        case 22:
            aimController = ToDoViewController()
            break
        case 23:
            aimController = WebViewController()
            break
        case 24:
            aimController = ReaderViewController()
            break
        case 25:
            aimController = EvolutionViewController()
            break
        case 26:
            aimController = PasswordProduceViewController()
            break
        case 27:
            aimController = I18NViewController()
            break
        case 28:
            aimController = CIFilterViewController()
            break
        case 29:
            aimController = LandscapeViewController()
            break
            
        default:
            break
        }
        aimController.hidesBottomBarWhenPushed = true
        if aimController.isKind(of: LandscapeViewController.self){
            aimController.hidesBottomBarWhenPushed = false
        }
        navigationController?.pushViewController(aimController, animated: true)
    }
    
    func other() {
        let name = UIDevice.current.modelName
        print(name)
        
        let b = UIDevice.current.batteryLevel
        print(b)
        let s = UIDevice.current.batteryState
        print(s.rawValue)
         
        let selector = NSSelectorFromString("selectorTest")
        perform(selector, with: nil, afterDelay: 0.1)
        
        let languages = UserDefaults.standard.value(forKey: "AppleLanguages")
        print(languages);
        
        
        let calander = NSCalendar.init(identifier: .chinese);
        let m = calander?.component(.month, from: Date())
        let d = calander?.component(.day, from: Date())
        
        print(m,d)
        
    }
    
    func selectorTest() {
        print("Selector Test")
    }
    
    //MARK: - delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:HomeCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Homecell", for: indexPath) as! HomeCollectionCell
        cell.backgroundColor = UIColor.randomColor()
        cell.label.I18NLocalized(key: list[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 100, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellClick(index: indexPath.row)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
//MARK: - cell

class HomeCollectionCell: UICollectionViewCell {
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

