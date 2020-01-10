//
//  MultipeerConnectivityManager.swift
//  DemoSet
//
//  Created by 李世远 on 2019/2/12.
//  Copyright © 2019 Far. All rights reserved.
//

import UIKit
import MultipeerConnectivity

enum ConnectRequestType {
    case request
    case accept
    case refuse
    case passworderror
    case memberfull
    case other
}

class MultipeerConnectivityManager: NSObject,MCSessionDelegate,MCNearbyServiceBrowserDelegate,MCNearbyServiceAdvertiserDelegate {
    
    static let manager = MultipeerConnectivityManager()
    
    var peerid:MCPeerID?
    var session:MCSession?
    var browser:MCNearbyServiceBrowser?
    var advertise:MCNearbyServiceAdvertiser?
    
    private var passWord = ""
    private var token = ""
    
    var peers:[MCPeerID] = []//已经连接的设备
    
    var receiveMessage:BaseBlockString = {_ in }
    
    /// 消息
    var addSystemMsg:BaseBlockString = {_ in}
    
    func setupPeerName(name:String) {
        peerid = MCPeerID.init(displayName: name)
        
        session = MCSession.init(peer: peerid!)
        session!.delegate = self
    }
    
    /// 发送广播找人
    func setupBrowser() {
        browser = MCNearbyServiceBrowser.init(peer: peerid!, serviceType: "chat-files")
        browser?.delegate = self
        browser?.startBrowsingForPeers()
    }
    
    /// 自己可被发现
    ///
    /// - Parameter isAdvertise: 是否展示自己
    func advertiseSelf(isAdvertise:Bool) {
        if isAdvertise {
            advertise = MCNearbyServiceAdvertiser.init(peer: peerid!, discoveryInfo: ["name":"thisisname"], serviceType: "chat-files")
            advertise?.delegate = self
            advertise!.startAdvertisingPeer()
        }else{
            advertise!.stopAdvertisingPeer()
        }
    }
    //MARK: - function
    func sendMessage(msg:String) {
        let data = msg.data(using: .utf8)
        do {
            try session?.send(data!, toPeers: peers, with: .reliable)
        } catch {
            //
        }
        
    }
    
    func connectTo(peerid:MCPeerID) {
        browser?.invitePeer(peerid, to: session!, withContext: nil, timeout: 10)
    }
    
    /// 创建主机
    func creatHost(name:String,password:String) {
        let info = ["name":name]
        passWord = password
        advertise = MCNearbyServiceAdvertiser.init(peer: peerid!, discoveryInfo: info, serviceType: "chat-files")
        advertise?.delegate = self
        advertise!.startAdvertisingPeer()
    }
    
    func closeHost() {
        advertise?.stopAdvertisingPeer()
    }
    
    func requestHost(peerid:MCPeerID) {
        token = "asdas"
        let context = ["state":ConnectRequestType.request,"password":"1234","token":token] as [String : Any]
        
        let data = try?JSONSerialization.data(withJSONObject: context, options: [])
        
        browser?.invitePeer(peerid, to: session!, withContext: data, timeout: 10)
    }
    
    //MARK: - delegate
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        //
        print("change")
        switch state {
        case .connected:
            print("connected")
            peers.append(peerID)
            sendMessage(msg: "connected!!!")
            addSystemMsg("\(peerID.displayName) connected!")
            break
        case .connecting:
            print("connnecting")
            break
        case .notConnected:
            print("notConnected")
            addSystemMsg("\(peerID.displayName) notConnected!")
            peers.removeAll { (p) -> Bool in
                p == peerID
            }
            break
        default:
            //no
            break
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        //
        let str = String.init(data: data, encoding: .utf8)
        print("receive date:\(str!)")
        receiveMessage(str!)
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        //
        print("receive Stream:\(streamName)")
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        //
        print("reveive Resource:\(resourceName) Progress:\(progress)")
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        //
        print("receive Resource:\(resourceName) url:\(localURL?.absoluteString ?? "a")")
    }
    
    //browser delegate
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        //
        let msg = "found peerid\(peerID.displayName) info:\(info?.description)"
        print(msg)
        addSystemMsg(msg)
        connectTo(peerid: peerID)
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        //
        let msg = "lost peerid\(peerID.displayName)"
        print(msg)
        addSystemMsg(msg)
    }
    
    //advertiser delegate
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        //
        let msg = "receive invitation"
        print(msg)
        
        if context != nil {
            let json = try?JSONSerialization.jsonObject(with: context!, options: .mutableContainers)
            
            let dic = json as! [String:Any]
            
            print(dic)
            
            let state = dic["state"]
            
            print(state)
        }
        
        addSystemMsg(msg)
        //做一些处理判断是否接受邀请
        invitationHandler(false,session!)
    }

}
