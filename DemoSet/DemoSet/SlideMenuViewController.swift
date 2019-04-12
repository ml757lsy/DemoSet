//
//  SlideMenuViewController.swift
//  DemoSet
//
//  Created by 李世远 on 2018/6/28.
//  Copyright © 2018年 Far. All rights reserved.
//

import UIKit

public struct SlideMenuOptions {
    static let leftViewWidth:CGFloat = 270
    static let opacityViewBackgroundColor = UIColor.init(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.2)
    public static var pointOfNoReturnWidth: CGFloat = 44.0
    public static var panGesturesEnabled: Bool = true
    public static var tapGesturesEnabled: Bool = true
}

class SlideMenuViewController: BaseViewController {
    
    public enum SlideAction {
        case open
        case close
    }
    
    public enum TrackAction {
        case leftTapOpen
        case leftTapClose
        case leftFlickOpen
        case leftFlickClose
        case rightTapOpen
        case rightTapClose
        case rightFlickOpen
        case rightFlickClose
    }
    
    struct PanInfo {
        var action: SlideAction
        var shouldBounce: Bool
        var velocity: CGFloat
    }
    
    struct PanState {
        static var frameAtStartOfPan: CGRect = CGRect.zero
        static var startPointOfPan: CGPoint = CGPoint.zero
        static var wasOpenAtStartOfPan: Bool = false
        static var wasHiddenAtStartOfPan: Bool = false
        static var lastState : UIGestureRecognizer.State = .ended
    }
    
    var leftViewController:UIViewController = UIViewController()
    var mainViewController:UIViewController = UIViewController()
    var leftView:UIView = UIView()
    var mainView:UIView = UIView()
    var opacityView:UIView = UIView()
    
    
    /// 创建
    ///
    /// - Parameters:
    ///   - leftViewController: menu
    ///   - mainViewController: main
    public convenience init(leftController:UIViewController, mainController:UIViewController) {
        self.init()
        mainViewController = mainController
        leftViewController = leftController
        initView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        setUpViewController(mainView, targetViewController: mainViewController)
        setUpViewController(leftView, targetViewController: leftViewController)
    }
    
    fileprivate func setUpViewController(_ targetView: UIView, targetViewController: UIViewController?) {
        if let viewController = targetViewController {
            viewController.view.frame = targetView.bounds
            
            if (!children.contains(viewController)) {
                addChild(viewController)
                targetView.addSubview(viewController.view)
                viewController.didMove(toParent: self)
            }
        }
    }
    
    fileprivate func removeViewController(_ viewController: UIViewController?) {
        if let _viewController = viewController {
            _viewController.view.layer.removeAllAnimations()
            _viewController.willMove(toParent: nil)
            _viewController.view.removeFromSuperview()
            _viewController.removeFromParent()
        }
    }
    
    func initView() {
        mainView = UIView(frame: view.bounds)
        mainView.backgroundColor = UIColor.clear
        mainView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.insertSubview(mainView, at: 0)
        
//        let sq = UISwipeGestureRecognizer.init(target: self, action: #selector(mainSwipAction(swip:)))
//        view.addGestureRecognizer(sq)
//
//        let cq = UISwipeGestureRecognizer.init(target: self, action: #selector(leftSwipAction(swip:)))
//        view.addGestureRecognizer(cq)
        
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(panAction(pan:)))
        view.addGestureRecognizer(pan)
        
        var opacityframe: CGRect = view.bounds
        let opacityOffset: CGFloat = 0
        opacityframe.origin.y = opacityframe.origin.y + opacityOffset
        opacityframe.size.height = opacityframe.size.height - opacityOffset
        opacityView = UIView(frame: opacityframe)
        opacityView.backgroundColor = SlideMenuOptions.opacityViewBackgroundColor
        opacityView.autoresizingMask = [UIView.AutoresizingMask.flexibleHeight, UIView.AutoresizingMask.flexibleWidth]
        opacityView.layer.opacity = 0.0
        view.insertSubview(opacityView, at: 1)
        
        if leftViewController != nil {
            var leftFrame: CGRect = view.bounds
            leftFrame.size.width = SlideMenuOptions.leftViewWidth
            leftFrame.origin.x = -SlideMenuOptions.leftViewWidth
            let leftOffset: CGFloat = 0
            leftFrame.origin.y = leftFrame.origin.y + leftOffset
            leftFrame.size.height = leftFrame.size.height - leftOffset
            leftView = UIView(frame: leftFrame)
            leftView.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
            view.insertSubview(leftView, at: 2)
            addLeftGestures()
        }
    }
    
    open func addLeftGestures() {
        
        if leftViewController != nil {
//            if SlideMenuOptions.panGesturesEnabled {
//                if leftPanGesture == nil {
//                    leftPanGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handleLeftPanGesture(_:)))
//                    leftPanGesture!.delegate = self
//                    view.addGestureRecognizer(leftPanGesture!)
//                }
//            }
//
//            if SlideMenuOptions.tapGesturesEnabled {
//                if leftTapGesture == nil {
//                    leftTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.toggleLeft))
//                    leftTapGesture!.delegate = self
//                    view.addGestureRecognizer(leftTapGesture!)
//                }
//            }
        }
    }
    fileprivate func panResultInfoForVelocity(_ velocity: CGPoint) -> PanInfo {
        
        let thresholdVelocity: CGFloat = 1000.0
        let pointOfNoReturn: CGFloat = CGFloat(floor(SlideMenuOptions.leftViewWidth)) + SlideMenuOptions.pointOfNoReturnWidth
        let leftOrigin: CGFloat = leftView.frame.origin.x
        
        var panInfo: PanInfo = PanInfo(action: .close, shouldBounce: false, velocity: 0.0)
        
        panInfo.action = leftOrigin <= pointOfNoReturn ? .close : .open
        
        if velocity.x >= thresholdVelocity {
            panInfo.action = .open
            panInfo.velocity = velocity.x
        } else if velocity.x <= (-1.0 * thresholdVelocity) {
            panInfo.action = .close
            panInfo.velocity = velocity.x
        }
        
        return panInfo
    }
    
    open func isTagetViewController() -> Bool {
        // Function to determine the target ViewController
        // Please to override it if necessary
        return true
    }
    
    open func track(_ trackAction: TrackAction) {
        // function is for tracking
        // Please to override it if necessary
    }
    
    @objc func mainSwipAction(swip:UISwipeGestureRecognizer) {
        if swip.direction == .right {
            openLeft()
        }
    }
    
    @objc func leftSwipAction(swip:UISwipeGestureRecognizer) {
        if swip.direction == .left {
            closeLeft()
        }
    }
    
    @objc func panAction(pan:UIPanGestureRecognizer) {
        print(pan.state)
        switch pan.state {
        case .began:
            if PanState.lastState != .ended &&  PanState.lastState != .cancelled &&  PanState.lastState != .failed {
                return
            }
            
//            if isLeftHidden() {
//                self.delegate?.leftWillOpen?()
//            } else {
//                self.delegate?.leftWillClose?()
//            }
            
            PanState.frameAtStartOfPan = leftView.frame
            PanState.startPointOfPan = pan.location(in: view)
            PanState.wasOpenAtStartOfPan = isLeftOpen()
            PanState.wasHiddenAtStartOfPan = isLeftHidden()
            
            leftViewController.beginAppearanceTransition(PanState.wasHiddenAtStartOfPan, animated: true)
//            addShadowToView(leftContainerView)
//            setOpenWindowLevel()
        case .changed:
            if PanState.lastState != .began && PanState.lastState != .changed {
                return
            }
            
            let translation: CGPoint = pan.translation(in: pan.view!)
//            leftView.frame = applyLeftTranslation(translation, toFrame: PanState.frameAtStartOfPan)
//            applyLeftOpacity()
//            applyLeftContentViewScale()
        case .ended, .cancelled:
            if PanState.lastState != .changed {
//                setCloseWindowLevel()
                return
            }
            
            let velocity:CGPoint = pan.velocity(in: pan.view)
            let panInfo: PanInfo = panResultInfoForVelocity(velocity)
            
            if panInfo.action == .open {
                if !PanState.wasHiddenAtStartOfPan {
                    leftViewController.beginAppearanceTransition(true, animated: true)
                }
//                openLeftWithVelocity(panInfo.velocity)
                
                track(.leftFlickOpen)
            } else {
                if PanState.wasHiddenAtStartOfPan {
                    leftViewController.beginAppearanceTransition(false, animated: true)
                }
//                closeLeftWithVelocity(panInfo.velocity)
//                setCloseWindowLevel()
                
                track(.leftFlickClose)
                
            }
        case .failed, .possible:
            break
        }
        
        PanState.lastState = pan.state
    }
    
    func openLeft() {
        leftViewController.beginAppearanceTransition(true, animated: true)
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
            //
            self.leftView.x = 0
            self.mainView.x = SlideMenuOptions.leftViewWidth
        }) { (complate) in
            //
        }
    }
    
    func closeLeft() {
        leftViewController.beginAppearanceTransition(true, animated: true)
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
            //
            self.leftView.x = -SlideMenuOptions.leftViewWidth
            self.mainView.x = 0
        }) { (complate) in
            //
        }
    }
    
    open func isLeftOpen() -> Bool {
        return leftView.frame.origin.x == 0.0
    }
    
    open func isLeftHidden() -> Bool {
        return leftView.frame.origin.x <= -SlideMenuOptions.leftViewWidth
    }

}

extension UIViewController {
    
    /// 获取控制器
    ///
    /// - Returns: 控制器
    func slideMenuController() -> SlideMenuViewController? {
        var viewcontroller:UIViewController? = self
        while viewcontroller != nil {
            if viewcontroller is SlideMenuViewController{
                return viewcontroller as? SlideMenuViewController
            }
            viewcontroller = viewcontroller?.parent
        }
        
        return nil
    }
}
