//
//  BluetoothConnectionViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/10/10.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit
import GameKit
import MultipeerConnectivity
import CoreBluetooth

class BluetoothConnectionViewController: BaseViewController,MCBrowserViewControllerDelegate,CBCentralManagerDelegate,MCSessionDelegate {

    private let search = UIButton()
    private let input = UITextField()
    private let send = UIButton()
    
    private var manager = CBCentralManager()
    private var session:MCSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        
        initBase()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func initBase() {
        manager = CBCentralManager.init(delegate: self, queue: nil)
        
        let sessionid = MCPeerID.init(displayName: "Far")
        session = MCSession.init(peer: sessionid)
        session?.delegate = self
    }
    
    func initView() {
        view.addSubview(search)
        search.frame = CGRect.init(x: 10, y: 10, width: 80, height: 40)
        search.setTitle("Search", for: .normal)
        search.setTitleColor(UIColor.blue, for: .normal)
        search.addTarget(self, action: #selector(seek), for: .touchUpInside)
        
        //
        view.addSubview(input)
        input.frame =  CGRect.init(x: 10, y: 60, width: view.frame.size.width-20-100, height: 40)
        input.borderStyle = .roundedRect
        
        //
        view.addSubview(send)
        send.frame = CGRect.init(x: view.frame.size.width-100-10, y: 60, width: 100, height: 40)
        send.setTitle("Send", for: .normal)
        send.setTitleColor(UIColor.blue, for: .normal)
        send.addTarget(self, action: #selector(sendClick), for: .touchUpInside)
    }
    
    func seek() {
        let mc = MCBrowserViewController.init(serviceType: "JoinGame", session: session!)
        mc.delegate = self
        mc.maximumNumberOfPeers = 4
        mc.minimumNumberOfPeers = 1
        self.present(mc, animated: true) {
            //
        }
    }
    
    func sendClick() {
        
    }
    
    //设备状态
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        var message = ""
        switch (central.state) {
        case    .unknown :
            message = "CBCentralManagerStateUnknown"
            break
        case    .resetting :
            message = "初始化中，请稍后……"
            break
            
        case    .unsupported :
            message = "设备不支持状态，过会请重试……"
            break
            
        case    .unauthorized :
            message = "设备未授权状态，过会请重试……"
            break
            
        case    .poweredOff :
            message = "尚未打开蓝牙，请在设置中打开……"
            break
            
        case    .poweredOn :
            message = "蓝牙已经成功开启，稍后……"
            break
            
        default:
            break
        }
        print(message)
    }
    //
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        //
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        //
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        //
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        //
    }
    
    func session(_ session: MCSession, didReceiveCertificate certificate: [Any]?, fromPeer peerID: MCPeerID, certificateHandler: @escaping (Bool) -> Void) {
        //
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        //
    }
    
    //browser delegate
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        //
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        //
        browserViewController.dismiss(animated: true) {
            //
        }
    }
    //发送信号
    func browserViewController(_ browserViewController: MCBrowserViewController, shouldPresentNearbyPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) -> Bool {
        print(MCPeerID.self)
        print(info)
        return true
    }
    

}
