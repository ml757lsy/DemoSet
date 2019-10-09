//
//  LeetcodeViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2019/8/28.
//  Copyright © 2019 Far. All rights reserved.
//

import UIKit

class LeetcodeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let a4 = findMedianSortedArrays([1,2], [3,4])
        print(a4)
    }
    
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        let c = nums1.count + nums2.count
        var n1 = 0
        var n2 = 0
        var nums = Array<Int>.init()
        
        while n1+n2<(c+2)/2 {
            if n1 >= nums1.count {
                nums.append(nums2[n2])
                n2+=1
            }else if n2 >= nums2.count {
                nums.append(nums1[n1])
                n1+=1
            }else if nums1[n1] < nums2[n2] {
                nums.append(nums1[n1])
                n1 += 1
            }else{
                nums.append(nums2[n2])
                n2 += 1
            }
        }
        if c%2==1 {
            return Double(nums[nums.count-1])
        }else{
            return (Double(nums[nums.count-1])+Double(nums[nums.count-2]))/2
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
