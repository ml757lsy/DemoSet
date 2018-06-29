//
//  ARViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2018/6/29.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit
import ARKit
import SpriteKit

class ARViewController: BaseViewController {
    
    var sceneView = ARSKView.init()

    override func viewDidLoad() {
        super.viewDidLoad()

        //
        view.addSubview(sceneView)
        sceneView.frame = view.bounds

        sceneView.delegate = self
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true
        
        let scene = SKScene.init(size: view.frame.size)
        sceneView.presentScene(scene)//
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(handleTap(tap:)))
        sceneView.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sceneView.session.run(creatConfiguration())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sceneView.session.pause()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc
    func handleTap(tap:UITapGestureRecognizer) {
        if let currentFrame = sceneView.session.currentFrame {
            var translation = matrix_identity_float4x4
            translation.columns.3.z = -3
            //FIXME: -1
            let transform = simd_mul(currentFrame.camera.transform, translation)
            
            let anchor = ARAnchor.init(transform: transform)
            
            sceneView.session.add(anchor: anchor)
        }
    }
    
    public func creatConfiguration() -> ARConfiguration {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        return configuration
    }
    
}

extension ARViewController: ARSKViewDelegate {
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        //
        let node = SKShapeNode.init(rectOf: CGSize.init(width: 100, height: 100))
        node.position = CGPoint.init(x: sceneView.bounds.size.width/2, y: sceneView.bounds.size.height/2)
        node.fillColor = UIColor.red
        
        sceneView.node(for: anchor)?.addChild(node)
        return node
    }
    
    func view(_ view: ARSKView, didAdd node: SKNode, for anchor: ARAnchor) {
        print("add")
    }
    
    func view(_ view: ARSKView, didRemove node: SKNode, for anchor: ARAnchor) {
        print("did move")
    }
    
    func view(_ view: ARSKView, didUpdate node: SKNode, for anchor: ARAnchor) {
        print("did update")
    }
    
    func view(_ view: ARSKView, willUpdate node: SKNode, for anchor: ARAnchor) {
        print("will update")
    }
}

extension ARViewController: ARSessionObserver {
    func session(_ session: ARSession, didFailWithError error: Error) {
        print("didFailWithError")
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        print("cameraDidChangeTrackingState")
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        print("wasInterrupted")
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        print("interruptionEnded")
        sceneView.session.run(creatConfiguration(), options: .resetTracking)
    }
}
