//
//  MultipeerConnectivityViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2019/2/12.
//  Copyright © 2019 Far. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class MultipeerConnectivityViewController: BaseViewController,MCBrowserViewControllerDelegate {
    
    let open = UISwitch.init()
    let find = UIButton.init()
    let send = UIButton.init()
    let manager = MultipeerConnectivityManager.manager
    let text = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        open.frame = CGRect.init(x: 100, y: 40, width: 60, height: 40)
        open.addTarget(self, action: #selector(openSwitchAction), for: .valueChanged)
        view.addSubview(open)
        
        find.frame = CGRect.init(x: 100, y: 100, width: 60, height: 40)
        find.setTitle("Find", for: .normal)
        find.setTitleColor(UIColor.blue, for: .normal)
        find.addTarget(self, action: #selector(findOtherAction), for: .touchUpInside)
        view.addSubview(find)
        
        send.frame = CGRect.init(x: 100, y: 160, width: 60, height: 40)
        send.setTitle("Send", for: .normal)
        send.setTitleColor(UIColor.blue, for: .normal)
        send.addTarget(self, action: #selector(sendMsgAction), for: .touchUpInside)
        view.addSubview(send)
        
        text.frame = CGRect.init(x: 20, y: 200, width: SCREENWIDTH-40, height: SCREENHEIGHT-200-20-(navigationController?.navigationBar.height)!)
        text.backgroundColor = UIColor.init(white: 0, alpha: 0.1)
        view.addSubview(text)
        
        manager.setupPeerName(name: UIDevice.current.name)
        weak var weakself = self
        manager.receiveMessage = {
            str in
            //
            weakself?.addMsgAction(str: str)
        }
        manager.addSystemMsg = {
            msg in
            weakself?.addMsgAction(str: msg)
        }
    }
    
    func openSwitchAction() {
        manager.advertiseSelf(isAdvertise: open.isOn)
    }
    
    func findOtherAction() {
        manager.setupBrowser()
    }
    
    func addMsgAction(str:String) {
        text.text = text.text + str + "\n"
    }
    
    func sendMsgAction() {
        let data = "message".data(using: .utf8)
        
        do {
            try manager.session?.send(data!, toPeers: manager.peers, with: .reliable)
        } catch {
            //
        }
    }
    
    func reactiove(msg:String) {
        //
    }
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        //
        browserViewController.dismiss(animated: true) {
            //
        }
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        //
        browserViewController.dismiss(animated: true) {
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
