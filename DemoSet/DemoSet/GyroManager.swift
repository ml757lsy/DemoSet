//
//  GyroManager.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/10/18.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit
import CoreMotion

typealias GyroResultBlock = (_ x:CGFloat,_ y:CGFloat,_ z:CGFloat) -> Void

class GyroManager: NSObject {

    static let manager = GyroManager()
    
    var updateInterval = 0.1
    
    private let motion = CMMotionManager()
    private let queue = OperationQueue.init()
    
    private override init() {
        super.init()
    }
    
    //MARK - function
    
    
    /// 开始陀螺仪检测
    ///
    /// - Parameter result: 结果
    func startGyro(result:@escaping GyroResultBlock) {
        if motion.isGyroAvailable {
            motion.gyroUpdateInterval = updateInterval
            motion.startGyroUpdates(to: queue) { (data, error) in
                if (error != nil){
                    print("Gyro Error")
                    self.motion.stopGyroUpdates()
                }else{
                    let x:CGFloat = CGFloat((data?.rotationRate.x)!)
                    let y:CGFloat = CGFloat((data?.rotationRate.y)!)
                    let z:CGFloat = CGFloat((data?.rotationRate.z)!)
                    
                    result(x,y,z)
                }
            }
        }else{
            print("设备不可用")
        }
    }
    
    func stopGyro() {
        motion.stopGyroUpdates()
    }
    
    /// 开始加速计检测
    ///
    /// - Parameter result: 结果
    func startAccelerometer(result:@escaping GyroResultBlock) {
        if motion.isAccelerometerAvailable {
            motion.gyroUpdateInterval = updateInterval
            motion.startAccelerometerUpdates(to: queue) { (data, error) in
                if error != nil {
                    print("Accelerometer Error")
                    self.motion.stopAccelerometerUpdates()
                }else{
                    let x:CGFloat = CGFloat((data?.acceleration.x)!)
                    let y:CGFloat = CGFloat((data?.acceleration.y)!)
                    let z:CGFloat = CGFloat((data?.acceleration.z)!)
                    
                    result(x,y,z)
                }
            }
        }else{
            print("设备不可用")
        }
        
    }
    
    func stopAccelerometer() {
        motion.stopAccelerometerUpdates()
    }
    
    
    /// 开始运动检测
    ///
    /// - Parameter result: 结果
    func startDeviceMotion(result:@escaping GyroResultBlock) {
        if motion.isDeviceMotionAvailable {
            motion.gyroUpdateInterval = updateInterval
            motion.startDeviceMotionUpdates(to: queue, withHandler: { (data, error) in
                if error != nil{
                    print("DeviceMotion Error")
                    self.motion.stopDeviceMotionUpdates()
                }else{
                    let x:CGFloat = CGFloat((data?.rotationRate.x)!)
                    let y:CGFloat = CGFloat((data?.rotationRate.y)!)
                    let z:CGFloat = CGFloat((data?.rotationRate.z)!)
                    
                    result(x,y,z)
                }
            })
        }else{
            print("设备不可用")
        }
    }
    
    func stopDeviceMotion() {
        motion.stopDeviceMotionUpdates()
    }
    
    func stop() {
        stopGyro()
        stopAccelerometer()
        stopDeviceMotion()
    }
    
}
