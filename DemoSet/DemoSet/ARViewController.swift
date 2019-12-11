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
    
    var sceneView = ARSCNView.init()

    override func viewDidLoad() {
        super.viewDidLoad()

        //
        view.addSubview(sceneView)
        sceneView.frame = view.bounds

        sceneView.delegate = self
//        sceneView.showsFPS = true
//        sceneView.showsNodeCount = true
        
        let scene = SKScene.init(size: view.frame.size)
//        sceneView.presentScene(scene)//
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(handleTap(tap:)))
        sceneView.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        sceneView.session.run(creatConfiguration())
        if #available(iOS 11.3, *) {
            resetTrackingConfiguration()
        } else {
            // Fallback on earlier versions
        }
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
        print("TapAction")
        if let currentFrame = sceneView.session.currentFrame {
            var translation = matrix_identity_float4x4
            translation.columns.3.z = -3
            //FIXME: -1
            let transform = simd_mul(currentFrame.camera.transform, translation)
            
            let anchor = ARAnchor.init(transform: transform)
            
//            sceneView.session.add(anchor: anchor)
        }
    }
    
    public func creatConfiguration() -> ARConfiguration {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        return configuration
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
        [super .touchesBegan(touches, with: event)]
        print("touch```````")
        let p = touches.first?.location(in: sceneView)
        let hitresult = sceneView.hitTest(p!, options: nil)
        
        if hitresult.count > 0 {
            
            let hit = hitresult.first!
            let node = hit.node
            print(node.name)
            
        }
    }
    
    @available(iOS 11.3, *)
    func resetTrackingConfiguration() {
        print("------------------->")
        
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "ARResources", bundle: Bundle.main) else {
            print("error")
            return
        }
        
        let i = referenceImages.first?.name
        print(i)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        let options: ARSession.RunOptions = [.resetTracking,.removeExistingAnchors]
        sceneView.session.run(configuration, options: options)
        print("------------------->")
    }
    
    @available(iOS 11.3, *)
    func openStage(node:SCNNode, anchor:ARImageAnchor) {
        
        let plan = SCNPlane.init(width: anchor.referenceImage.physicalSize.width, height: anchor.referenceImage.physicalSize.height)
        plan.firstMaterial?.diffuse.contents = UIColor.white
        
        let stage = SCNNode.init()
        stage.name = "stage"
        stage.opacity = 0.8
        stage.geometry = plan
        stage.eulerAngles.x = -.pi/2
        node.addChildNode(stage)
        
        stage.runAction(fadeAndShowAction)
    }
    
    @available(iOS 11.3, *)
    func addText(node:SCNNode, anchor:ARImageAnchor) {
        ///
        let text = SCNText.init(string: "干啥", extrusionDepth: 1)
        text.font = UIFont.boldSystemFont(ofSize: 1)
        let m = SCNMaterial.init()
        m.diffuse.contents = UIColor.red
        text.firstMaterial = m
        text.isWrapped = true
        text.containerFrame = CGRect.init(x: 0, y: 0, width: 2, height: 2)
        
        let textnode = SCNNode.init()
        textnode.geometry = text
        
        node.addChildNode(textnode)
    }
    
    @available(iOS 11.3, *)
    func addEarth(node:SCNNode, anchor:ARImageAnchor) {
        
        let ball = SCNSphere.init()
        ball.radius = 3
        ball.firstMaterial?.diffuse.contents = UIImage.init(named: "card_s")
        
        let ballnode = SCNNode.init()
        ballnode.opacity = 1
        ballnode.geometry = ball
        
        node.addChildNode(ballnode)
    }
    
    @available(iOS 11.3, *)
    func addViedeo(node:SCNNode, anchor:ARImageAnchor) {
        let pathstr = Bundle.main.path(forResource: "", ofType: "mp4")
        let playitem = AVPlayerItem.init(url: URL.init(fileURLWithPath: ""))//
        let player = AVPlayer.init(playerItem: playitem)
        
        let plan = SCNPlane.init(width: anchor.referenceImage.physicalSize.width, height: anchor.referenceImage.physicalSize.height)
        plan.firstMaterial?.diffuse.contents = player
        
        let videonode = SCNNode()
        videonode.geometry = plan
        videonode.eulerAngles.x = -.pi/2
        node.addChildNode(videonode)
        
        let gifpath = Bundle.main.path(forResource: "4da0e35c49aa37b70fd54a5b92447df0d9c259661a9865-t8562E_fw658", ofType: "gif")
        let imgs = UIImage().gifToImages(gifPath: gifpath!)
    }
    
    lazy var fadeAndShowAction:SCNAction = {
        let seq = SCNAction.sequence([SCNAction.fadeOut(duration: 0.3),
                                      SCNAction.wait(duration: 0.5),
                                      SCNAction.fadeIn(duration: 0.3),
                                      SCNAction.wait(duration: 0.5),
                                      SCNAction.fadeOut(duration: 0.3),
                                      SCNAction.wait(duration: 0.5),
                                      SCNAction.fadeIn(duration: 0.3),
                                      SCNAction.wait(duration: 0.5)
            ])
        return SCNAction.repeat(seq, count: 3)
    }()
    
//    func heightlightImage(_ img:ARReferenceImage) -> ARConfiguration {
//        let plan = SCNPlane.init(width: img.physicalSize.width, height: img.physicalSize.height)
//        let plannode = SCNNode.init(geometry: plan)
//        plannode.opacity = 0.2
//        plannode.eulerAngles.x = -.pi/2
//
//        let conf = ARConfiguration.in
//        conf.
//
//    }
    
}

extension ARViewController: ARSKViewDelegate {
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        //
        let node = SKShapeNode.init(rectOf: CGSize.init(width: 10, height: 10))
        node.position = CGPoint.init(x: sceneView.bounds.size.width/2, y: sceneView.bounds.size.height/2)
        node.fillColor = UIColor.red
        
//        sceneView.node(for: anchor)?.addChild(node)
        return node
    }
    
    func view(_ view: ARSKView, didAdd node: SKNode, for anchor: ARAnchor) {
        print("add")
        print("---------------")
        
    }
    
    func view(_ view: ARSKView, didRemove node: SKNode, for anchor: ARAnchor) {
        print("did move")
    }
    
    func view(_ view: ARSKView, didUpdate node: SKNode, for anchor: ARAnchor) {
//        print("did update")
    }
    
    func view(_ view: ARSKView, willUpdate node: SKNode, for anchor: ARAnchor) {
//        print("will update")
    }
}

extension ARViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        print("scn add")
        if anchor.isKind(of: ARPlaneAnchor.self) {
            let planchor = anchor as! ARPlaneAnchor
            
            let plan = SCNPlane.init(width: CGFloat(planchor.extent.x), height: CGFloat(planchor.extent.z))
            plan.firstMaterial?.diffuse.contents = UIColor.green
            plan.firstMaterial?.transparency = 0.5
            
            let scnode = SCNNode.init(geometry: plan)
            scnode.position = SCNVector3.init(planchor.center.x, 0, planchor.center.z)
            scnode.transform = SCNMatrix4MakeRotation(Float(-M_PI_2), 1, 0, 0)
            node.addChildNode(scnode)
        }
        if #available(iOS 11.3, *) {
            guard let imageArchor = anchor as? ARImageAnchor,let imageName = imageArchor.referenceImage.name else { return }
            
//            let tempnode = SCNNode.init()
//            let box = SCNBox.init(width: imageArchor.referenceImage.physicalSize.width, height: imageArchor.referenceImage.physicalSize.height, length: 1, chamferRadius: 0)
//            box.firstMaterial?.diffuse.contents = UIImage.init(named: "Avatar")
//            tempnode.opacity = 0.8
//            tempnode.geometry = box
//            node.addChildNode(tempnode)
            //
//            openStage(node: node, anchor: imageArchor)
//            addText(node: node, anchor: imageArchor)
            //
            
            if imageName == "fish" {
                openStage(node: node, anchor: imageArchor)
            }
            if imageName == "earth" {
                addEarth(node: node, anchor: imageArchor)
                addText(node: node, anchor: imageArchor)
            }
            
        } else {
            // Fallback on earlier versions
        }
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
