//
//  MultipeerConnectivityManager.swift
//  DemoSet
//
//  Created by 李世远 on 2019/2/12.
//  Copyright © 2019 Far. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class MultipeerConnectivityManager: NSObject,MCSessionDelegate {
    
    static let manager = MultipeerConnectivityManager()
    
    var peerid:MCPeerID?
    var session:MCSession?
    var browser:MCBrowserViewController?
    var advertise:MCAdvertiserAssistant?
    
    var peers:[MCPeerID] = []//已经连接的设备
    
    func setupPeerName(name:String) {
        peerid = MCPeerID.init(displayName: name)
        
        session = MCSession.init(peer: peerid!)
        session!.delegate = self
    }
    
    func setupBrowser() {
        browser = MCBrowserViewController.init(serviceType: "chat-files", session: session!)
    }
    
    func advertiseSelf(isAdvertise:Bool) {
        if isAdvertise {
            //
            advertise = MCAdvertiserAssistant.init(serviceType: "chat-files", discoveryInfo: nil, session: session!)
            advertise!.start()
        }else{
            advertise!.stop()
        }
    }
    
    
    //MARK: - delegate
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        //
        print("change")
        
        if state == .connected {
            print("add")
            peers.append(peerID)
        }
        
        if state == .notConnected {
            print("remove")
            peers.removeAll { (p) -> Bool in
                p == peerID
            }
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        //
        print("receive date:\(data)")
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
    

}
