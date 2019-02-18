//
//  APIViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2019/2/15.
//  Copyright © 2019 Far. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class APIViewController: BaseViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    let textView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let host = "http://www.byfar.cc"
        
        let imgview = UIImageView.init(frame: CGRect.init(x: 20, y: 20, width: 60, height: 60))
        let resource = ImageResource.init(downloadURL: URL.init(string: host+"/ulf/83025aafa40f4bfb619bfc63024f78f0f73618b9.jpg.gif")!)
        imgview.kf.setImage(with: resource)
        view.addSubview(imgview)
        
        let query = UIButton.init(type: .system)
        query.frame = CGRect.init(x: 20, y: 40, width: 60, height: 40)
        query.setTitle("Query", for: .normal)
        query.addTarget(self, action: #selector(loadMessage), for: .touchUpInside)
        view.addSubview(query)
        
        let upload = UIButton.init(type: .system)
        upload.frame = CGRect.init(x: 20, y: 100, width: 60, height: 40)
        upload.setTitle("UPLOAD", for: .normal)
        upload.addTarget(self, action: #selector(uploadAction), for: .touchUpInside)
        view.addSubview(upload)
        
        let regist = UIButton.init(type: .system)
        regist.frame = CGRect.init(x: 100, y: 40, width: 60, height: 40)
        regist.setTitle("Regist", for: .normal)
        regist.addTarget(self, action: #selector(registAction), for: .touchUpInside)
        view.addSubview(regist)
        
        let update = UIButton.init(type: .system)
        update.frame = CGRect.init(x: 180, y: 40, width: 60, height: 40)
        update.setTitle("Update", for: .normal)
        update.addTarget(self, action: #selector(updateAction), for: .touchUpInside)
        view.addSubview(update)
        
        let custom = UIButton.init(type: .system)
        custom.frame = CGRect.init(x: 260, y: 40, width: 60, height: 40)
        custom.setTitle("Custom", for: .normal)
        custom.addTarget(self, action: #selector(customSQL), for: .touchUpInside)
        view.addSubview(custom)
        
        textView.frame = CGRect.init(x: 20, y: 150, width: SCREENWIDTH-40, height: view.height-150)
        textView.backgroundColor = UIColor.init(white: 0, alpha: 0.1)
        view.addSubview(textView)
    }
    
    
    func loadMessage() {
        let url:URL = URL.init(string: "http://byfar.cc/api.php?action=getusers")!
        
        Alamofire.request(url).responseString { (string) in
            print(string.result.value!)
            self.textView.text += string.result.value!
        }
        
        NetworkManager.requestModel(url: url, modeltype: UserList()) { (model) in
            print(model.list.count)
            let user = model.list[0]
            print(user.name)
        }
        
        //
        let login:URL = URL.init(string: "http://byfar.cc/login.php")!
        let param:[String:Any] = ["username":"Tom","password":"pass"]
        
        Alamofire.request(login, method: .post, parameters: param, encoding: URLEncoding.default, headers: nil).responseString { (string) in
            //
            print("login:"+string.result.value!)
        }
    }
    
    func registAction() {
        let login:URL = URL.init(string: "http://byfar.cc/regist.php")!
        let param:[String:Any] = ["username":"Jhon","password":"pass","sign":"sssss"]
        
        Alamofire.request(login, method: .post, parameters: param, encoding: URLEncoding.default, headers: nil).responseString { (string) in
            //
            print("regist:"+string.result.value!)
        }
    }
    
    func updateAction() {
        let update:URL = URL.init(string: "http://byfar.cc/update.php")!
        let param:[String:Any] = ["username":"Jhon","password":"pass","type":"3"]
        
        Alamofire.request(update, method: .post, parameters: param, encoding: URLEncoding.default, headers: nil).responseString { (string) in
            //
            print("update:"+string.result.value!)
        }
    }
    
    func uploadAction() {
        
        let picker = UIImagePickerController.init()
        picker.delegate = self
        self.present(picker, animated: true) {
            //
        }
    }
    
    func upload(path:URL) {
        print("path:"+path.absoluteString)
        //upload
        let url:URL = URL.init(string: "http://byfar.cc/upload.php")!
//        NetworkManager.manager.upload(url: url, file: path) { (progress) in
//            //
//            print(progress)
//        }
        Alamofire.upload(path, to: url).uploadProgress { (progress) in
            print("progress:\(progress)")
        }
    }
    
    func customSQL() {
        let url:URL = URL.init(string: "http://byfar.cc/api.php")!
        let sql:String = "SELECT * FROM `bdm262241171_db`.`user` ORDER BY `userid` DESC  LIMIT 0,2"
        let param:[String:Any] = ["SQL":sql]
        self.textView.text += sql+"\n"
        NetworkManager.manager.post(url: url, parameters: param) { (string) in
            print("custom:"+string)
        }
        
    }

    // delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //
        print(info)
        let path:URL = info["UIImagePickerControllerImageURL"] as! URL
        upload(path: path)
        picker.dismiss(animated: true) {
            //
        }
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
