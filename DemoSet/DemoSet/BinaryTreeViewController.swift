//
//  BinaryTreeViewController.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/12/11.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

// 二叉树相关
class BinaryTreeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 20, y: 20, width: 60, height: 40)
        button.setTitle("Creat", for: .normal)
        button.addTarget(self, action: #selector(creatTree), for: .touchUpInside)
        button.setTitleColor(UIColor.orange, for: .normal)
        view.addSubview(button)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func creatTree() {
        var values:[Int] = []
        
        for i in 1..<20 {
            values.append(i)
        }
        for _ in 0..<10 {
            let index1 = Int(arc4random())%values.count
            var index2 = Int(arc4random())%values.count
            if index1 == index2 {
                index2 = (index1+1)%values.count
            }
            swap(&values[index1], &values[index2])
        }
        
        print(values)
        
        let tree = BinaryTreeNode.creatSortTree(with: values)
        
        tree.updateView(view: view)
        
        //
        var preL:[Int] = []
        BinaryTreeNode.preOrderTraverseTree(node: tree) { (node) in
            preL.append(node.value)
        }
        print("先序遍历"+"\(preL)")
        
        //
        var inL:[Int] = []
        BinaryTreeNode.inOrderTraverseTree(node: tree) { (node) in
            inL.append(node.value)
        }
        print("中序遍历-排序"+"\(inL)")
        
        //
        var postL:[Int] = []
        BinaryTreeNode.postOrderTraverseTree(node: tree) { (node) in
            postL.append(node.value)
        }
        print("后序遍历"+"\(postL)")
        
        //
        var levelL:[Int] = []
        BinaryTreeNode.levelTraverseTree(node: tree) { (node) in
            levelL.append(node.value)
        }
        print("层级遍历"+"\(levelL)")
        
        //
        let depth = BinaryTreeNode.depthOfTree(node: tree)
        print("二叉树高度:"+"\(depth)")
        
        //
        let width = BinaryTreeNode.widthOfTree(node: tree)
        print("二叉树宽度:"+"\(width)")
        
        //
        let num = BinaryTreeNode.nodeNumberOfTree(node: tree)
        print("节点总数:"+"\(num)")
        
        //
        let distance = BinaryTreeNode.maxDistanceOfTree(node: tree)
        print("二叉树最大距离:"+"\(distance)")
        
        //
        let to = BinaryTreeNode.init()
        to.value = 12
        let path = BinaryTreeNode.pathOfTree(node: tree, to: to)
        print("节点:\(to.value)到根路径"+"\(path)")
        
        //
        let one = BinaryTreeNode()
        one.value = 8
        let other = BinaryTreeNode()
        other.value = 17
        let parent = BinaryTreeNode.commonNodeOfTree(root: tree, one: one, another: other)
        print("节点:\(one.value)与节点:\(other.value)的最近公共父节点是:\(parent)")
        
        //
        let nodepath = BinaryTreeNode.pathOfTree(root: tree, from: one, to: other)
        print("节点:\(one.value)到节点:\(other.value)的路径是:\(nodepath)")
        
        //
        let isComplate = BinaryTreeNode.isComplateBinaryTree(node: tree)
        var isc = ""
        if !isComplate {
            isc = "不"
        }
        print(isc+"是完全二叉树")
    }
    

}
