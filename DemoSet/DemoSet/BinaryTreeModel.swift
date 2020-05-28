//
//  BinaryTreeNode.swift
//  DemoSet
//
//  Created by lishiyuan on 2017/12/11.
//  Copyright © 2017年 Far. All rights reserved.
//

import UIKit

// 二叉树节点
class BinaryTreeNode: NSObject {

    var value:Int = 0
    
    var left:BinaryTreeNode?
    var right:BinaryTreeNode?
    var balance:Int = 0//平衡性
    
    // 位置，显示定位用的
    var rect:CGRect = CGRect.zero
    
    //
    
    class func creatSortTree(with values:[Int]) -> BinaryTreeNode {
        var root:BinaryTreeNode?
        for value in values {
            root = BinaryTreeNode.addNewNode(with: root, and: value)
        }
        
        return root!
    }
    
    func creatAVLTree(with values:[Int]) -> BinaryTreeNode {
        var root:BinaryTreeNode?
        for value in values {
            root = BinaryTreeNode.addAVLNewNode(root: root, vale: value)
        }
        return root!
    }
    
    class func foundNode(root:BinaryTreeNode?, value:Int) -> BinaryTreeNode? {
        
        if root == nil {
            return nil
        }else
        if value < (root?.value)! {
            return foundNode(root: root?.left, value: value)
        }else
        if value > (root?.value)! {
            return foundNode(root: root?.right, value: value)
        }else{
            //  ==
            return root
        }
    }
    
    class func foundFather(root:BinaryTreeNode?, node:BinaryTreeNode) -> BinaryTreeNode? {
        if root == nil {
            return nil
        }else
            if root?.left == node || root?.right == node {
                return root
            }else{
                let l = foundFather(root: root?.left, node: node)
                if l != nil {
                    return l
                }
                let r = foundFather(root: root?.right, node: node)
                if r != nil {
                    return r
                }
        }
        return nil
    }
    
    class func addNewNode(with root:BinaryTreeNode?, and value:Int) -> BinaryTreeNode {
        if foundNode(root: root, value: value) != nil {
            return root!
        }
        if root == nil  {
            let node = BinaryTreeNode()
            node.value = value
            return node
        }else{
            //
            if value <= (root?.value)! {
                root?.left = BinaryTreeNode.addNewNode(with: root?.left, and: value)
            }else
            if value > (root?.value)! {
                root?.right = BinaryTreeNode.addNewNode(with: root?.right, and: value)
            }
            return root!
        }
    }
    
    class func deleteNode(with root:BinaryTreeNode, and value:Int) -> BinaryTreeNode {
        
        let node = foundNode(root: root, value: value)
        if node?.left != nil && node?.right == nil {
            //only left
            let fa = foundFather(root: root, node: node!)
            fa?.left = node?.left
            node?.left = nil
        }
        
        return root
    }
    
    //MARK: - UI
    
    func updateView(view:UIView) {
        if self.rect == CGRect.zero {
            self.rect = CGRect.init(x: view.width/2, y: 10, width: view.width, height: 0)
        }
        
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 20))
        label.text = "\(self.value)"
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.center = self.rect.origin
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.backgroundColor = UIColor.randomColor()
        
        let deep = BinaryTreeNode.depthOfTree(node: self)
        
        //
        let h:CGFloat = (view.frame.size.height-self.rect.origin.y)/CGFloat(deep+1)
        
        if self.left != nil {
            self.left?.rect = CGRect.init(x: self.rect.origin.x - self.rect.size.width/4, y: self.rect.origin.y + h, width: self.rect.size.width/2, height: 0)
            addLeftLine(view: view)
            self.left?.updateView(view: view)
        }
        if self.right != nil {
            self.right?.rect = CGRect.init(x: self.rect.origin.x + self.rect.size.width/4, y: self.rect.origin.y + h, width: self.rect.size.width/2, height: 0)
            addRightLine(view: view)
            self.right?.updateView(view: view)
        }
        
        view.addSubview(label)
    }
    
    func addLeftLine(view:UIView) {
        let l = UIBezierPath.init()
        l.lineWidth = 4
        l.move(to: CGPoint.init(x: self.rect.origin.x, y: self.rect.origin.y))
        l.addLine(to: CGPoint.init(x: self.rect.origin.x+1, y: self.rect.origin.y))
        l.addLine(to: CGPoint.init(x: (self.left?.rect.origin.x)!+1, y: (self.left?.rect.origin.y)!))
        l.addLine(to: CGPoint.init(x: (self.left?.rect.origin.x)!, y: (self.left?.rect.origin.y)!))
        
        let shap = CAShapeLayer.init()
        shap.path = l.cgPath
        shap.lineWidth = 4
        shap.fillColor = UIColor.red.cgColor
        view.layer.addSublayer(shap)
    }
    
    func addRightLine(view:UIView) {
        let l = UIBezierPath.init()
        l.lineWidth = 4
        l.move(to: CGPoint.init(x: self.rect.origin.x, y: self.rect.origin.y))
        l.addLine(to: CGPoint.init(x: self.rect.origin.x+1, y: self.rect.origin.y))
        l.addLine(to: CGPoint.init(x: (self.right?.rect.origin.x)!+1, y: (self.right?.rect.origin.y)!))
        l.addLine(to: CGPoint.init(x: (self.right?.rect.origin.x)!, y: (self.right?.rect.origin.y)!))
        
        let shap = CAShapeLayer.init()
        shap.path = l.cgPath
        shap.lineWidth = 4
        shap.fillColor = UIColor.blue.cgColor
        view.layer.addSublayer(shap)
    }
    
    func showInView(view:UIView) {
        
    }
    
    /// 更新位置
    func updateRect() {
        let d = self.depth()
        let l = self.leftCount()
        self.rect.size = CGSize.init(width: 20, height: 20)
        self.rect.origin.x = CGFloat(l)*20
        if self.left != nil {
            self.left?.rect.origin.y = CGFloat(d) * (20+40)
            self.left?.updateRect()
        }
        if self.right != nil {
            self.right?.rect.origin.y = CGFloat(d) * (20+40)
            self.right?.updateRect()
        }
    }

    //MARK: - info
    /// 先序遍历 根-左-右
    ///
    /// - Parameters:
    ///   - node: 树
    ///   - handler: 处理闭包
    class func preOrderTraverseTree(node:BinaryTreeNode?, handler:(_ node:BinaryTreeNode)->Void){
        if node != nil {
            handler(node!)
            preOrderTraverseTree(node: node?.left, handler: handler)
            preOrderTraverseTree(node: node?.right, handler: handler)
            
        }
    }
    

    /// 中序遍历  左-根-右
    ///
    /// - Parameters:
    ///   - node: 树
    ///   - handler: 处理闭包
    class func inOrderTraverseTree(node:BinaryTreeNode?, handler:(_ node:BinaryTreeNode)->Void) {
        if node != nil {
            inOrderTraverseTree(node: node?.left, handler: handler)
            handler(node!)
            inOrderTraverseTree(node: node?.right, handler: handler)
        }
    }
    
    /// 左侧数
    func leftCount() -> Int {
        var count = 0
        BinaryTreeNode.inOrderTraverseTree(node: self) { (n) in
            count += 1
        }
        return count
    }
    
    /// 后序遍历 左-右-根
    ///
    /// - Parameters:
    ///   - node: 树
    ///   - handler: 处理闭包
    class func postOrderTraverseTree(node:BinaryTreeNode?, handler:(_ node:BinaryTreeNode)->Void) {
        if node != nil {
            postOrderTraverseTree(node: node?.left, handler: handler)
            postOrderTraverseTree(node: node?.right, handler: handler)
            handler(node!)
        }
    }
    
    /// 层级遍历树
    ///
    /// - Parameters:
    ///   - node: 树
    ///   - handler: 处理闭包
    class func levelTraverseTree(node:BinaryTreeNode?, handler:(_ node:BinaryTreeNode)->Void) {
        if node == nil {
            return
        }
        
        var queueArray:[BinaryTreeNode] = []
        queueArray.append(node!)
        
        while queueArray.count > 0 {
            //
            let node = queueArray.first
            handler(node!)
            
            queueArray.remove(at: 0)//出栈
            
            if node?.left != nil {
                queueArray.append((node?.left)!)//压栈
            }
            if node?.right != nil {
                queueArray.append((node?.right)!)//压栈
            }
        }
    }
    
    /// 二叉树的高度
    ///
    /// - Parameter node: 树
    /// - Returns: 高度
    class func depthOfTree(node:BinaryTreeNode?) -> Int {
        if node == nil {
            return 0
        }
        if node?.left == nil && node?.right == nil {
            return 1
        }
        
        let depthl = depthOfTree(node: node?.left)
        
        let depthr = depthOfTree(node: node?.right)
        
        return max(depthl, depthr) + 1
    }
    
    /// 深度
    func depth() -> Int {
        return BinaryTreeNode.depthOfTree(node: self)
    }
    
    /// 二叉树的宽度
    ///
    /// - Parameter node: 树
    /// - Returns: 最大宽度
    class func widthOfTree(node:BinaryTreeNode?) -> Int {
        if node == nil {
            return 0
        }
        var queueArray:[BinaryTreeNode] = []
        queueArray.append(node!)
        
        var maxWidth:Int = 1//至少是1
        var curWidth:Int = 0
        
        while queueArray.count > 0 {
            curWidth = queueArray.count
            
            let node = queueArray.first
            queueArray.remove(at: 0)
            
            if node?.left != nil {
                queueArray.append((node?.left)!)
            }
            
            if node?.right != nil {
                queueArray.append((node?.right)!)
            }
            
            maxWidth = max(maxWidth, curWidth)
        }
        
        return maxWidth
    }
    
    /// 宽度
    func width() -> Int {
        return BinaryTreeNode.widthOfTree(node: self)
    }
    
    /// 二叉树的节点总数
    ///
    /// - Parameter node: 树
    /// - Returns: 节点总数
    class func nodeNumberOfTree(node:BinaryTreeNode?) -> Int {
        if node == nil {
            return 0
        }
        
        return nodeNumberOfTree(node:node?.left) + nodeNumberOfTree(node:node?.right) + 1
    }
    
    /// 二叉树的最大距离
    ///
    /// - Parameter node: 树
    /// - Returns: 最大距离
    class func maxDistanceOfTree(node:BinaryTreeNode?) -> Int {
        if node == nil {
            return 0
        }
        let property = propertyOfTree(node: node)
        if property == nil {
            return 0
        }
        
        return property!.distance
    }
    
    /// 计算最大距离的递归函数
    ///
    /// - Parameter node: 节点
    /// - Returns: 树深度和距离参数
    class func propertyOfTree(node:BinaryTreeNode?) -> BinaryTreeNodeProperty? {
        if node == nil {
            return nil
        }
        
        var left = propertyOfTree(node: node?.left)
        var right = propertyOfTree(node: node?.right)
        if left == nil {
            left = BinaryTreeNodeProperty()
        }
        if right == nil {
            right = BinaryTreeNodeProperty()
        }
        
        let property = BinaryTreeNodeProperty()
        property.depth = max((left?.depth)!, (right?.depth)!) + 1
        property.distance = max(max((left?.distance)!, (right?.distance)!), (left?.depth)! + (right?.depth)!)
        
        return property
    }
    
    
    /// 到子节点的路径
    ///
    /// - Parameters:
    ///   - node: 树
    ///   - subnode: 子节点
    /// - Returns: 路径
    class func pathOfTree(node:BinaryTreeNode?, to subnode:BinaryTreeNode) -> [Int] {
        if node == nil {
            return []
        }
        
        if subnode.value == node?.value  {
            return [subnode.value]
        }else
        if subnode.value < (node?.value)! {
            return pathOfTree(node:node?.left, to:subnode) + [node!.value]
        }
        else {
            return pathOfTree(node:node?.right, to:subnode) + [node!.value]
        }
    }
    
    /// 两个子节点的最近公共父节点
    ///
    /// - Parameters:
    ///   - root: 树
    ///   - one: 一个节点
    ///   - another: 另一个节点
    /// - Returns: 最近父节点
    class func commonNodeOfTree(root:BinaryTreeNode, one:BinaryTreeNode, another:BinaryTreeNode) -> Int {
        let onepath = pathOfTree(node: root, to: one)
        let anotherpath = pathOfTree(node: root, to: another)
        
        for node in onepath {
            for other in anotherpath {
                if node == other {
                    return node
                }
            }
        }
        
        return 0
    }
    
    
    /// 节点到节点的距离
    ///
    /// - Parameters:
    ///   - root: 树
    ///   - from: 一个节点
    ///   - to: 目标节点
    /// - Returns: 路径
    class func pathOfTree(root:BinaryTreeNode, from:BinaryTreeNode, to:BinaryTreeNode) -> [Int] {
        let parent = commonNodeOfTree(root: root, one: from, another: to)
        
        let path1 = pathOfTree(node: root, to: from)
        let path2 = pathOfTree(node: root, to: to)
        
        var path:[Int] = []
        var p1:Bool = false
        for i in 0..<path1.count {
            let p = path1[i]
            if p == parent {
                p1 = true
            }
            if !p1 {
                path.append(p)
            }
        }
        var p2:Bool = false
        for i in 0..<path2.count {
            let p = path2[path2.count-1-i]
            if p == parent {
                p2 = true
            }
            if p2 {
                path.append(p)
            }
        }
        
        return path
    }
    
    /// 翻转二叉树
    ///
    /// - Parameter node: 树
    /// - Returns: 翻转二叉树
    class func invertBinaryTree(node:BinaryTreeNode?) -> BinaryTreeNode? {
        
        if node == nil {
            return nil
        }
        
        if node?.left == nil && node?.right == nil {
            return node
        }
        
        _ = invertBinaryTree(node: node?.left)
        _ = invertBinaryTree(node: node?.right)
        
        let temp = node?.right
        node?.right = node?.left
        node?.left = temp
        
        return node
    }
    
    /// 是否是完全二叉树
    ///
    /// - Parameter node: 树
    /// - Returns: 是否是
    class func isComplateBinaryTree(node:BinaryTreeNode?) -> Bool {
        if node == nil {
            return false
        }
        
        if node?.left == nil && node?.right == nil {
            return true
        }
        
        if node?.left == nil && node?.right != nil {
            return false
        }
        
        var queueArray:[BinaryTreeNode] = []
        queueArray.append(node!)
        
        var isComplate:Bool = false
        while queueArray.count > 0 {
            let sub = queueArray[0]
            queueArray.remove(at: 0)
            
            if sub.left == nil && sub.right != nil {
                return false
            }
            
            if isComplate && (sub.right != nil || sub.left != nil) {
                return false
            }
            
            if sub.right == nil {
                //右侧为空，那么
                isComplate = true
            }
            
            if sub.left != nil {
                queueArray.append(sub.left!)
            }
            if sub.right != nil {
                queueArray.append(sub.right!)
            }
        }
        return isComplate
    }
    
    //MARK: - AVL
    /// 生成平衡二叉树
    ///
    /// - Parameter node: 树
    /// - Returns: AVL
    class func AVLtransFormTree(node:BinaryTreeNode) -> BinaryTreeNode {
        
        var queueArray:[BinaryTreeNode] = []
        queueArray.append(node)
        
        var temp:BinaryTreeNode = BinaryTreeNode()
        
        while queueArray.count > 0 {
            let sub = queueArray[0]
            queueArray.remove(at: 0)
            
            let ld = BinaryTreeNode.depthOfTree(node: sub.left)
            let rd = BinaryTreeNode.depthOfTree(node: sub.right)
            print("Root:",sub.value)
            print(" Left:",ld,"--Right:",rd)
            if abs(ld-rd) <= 1 {
                //ok
                print(sub.value," Balance!")
                if temp.value == 0 {
                    temp = sub
                }
                if sub.left != nil {
                    queueArray.append(sub.left!)
                }
                if sub.right != nil {
                    queueArray.append(sub.right!)
                }
            }else{
                if ld > rd {        //1.left
                    let lld = BinaryTreeNode.depthOfTree(node: sub.left?.left)
                    let lrd = BinaryTreeNode.depthOfTree(node: sub.left?.right)
                    
                    if lld > lrd {  //1.1 left left  toright
                        print("LL",sub.value)
                        let rrt = rightRoteTree(node: sub)
                        queueArray.append(rrt)
                    }else{          //1.2 left right toleft roright
                        print("LR",sub.value)
                        let lrt = leftRoteTree(node: sub.left!)
                        sub.left = lrt
                        queueArray.append(sub)
                    }
                }else{              //2.right
                    let rld = BinaryTreeNode.depthOfTree(node: sub.right?.left)
                    let rrd =  BinaryTreeNode.depthOfTree(node: sub.right?.right)
                    
                    if rrd > rld {  //2.1 right right toleft
                        print("RR",sub.value)
                        let lrt = leftRoteTree(node: sub)
                        queueArray.append(lrt)
                    }else{          //2.2 right left toright toleft
                        print("RL",sub.value)
                        let rrt = rightRoteTree(node: sub.right!)
                        sub.right = rrt
                        queueArray.append(sub)
                    }
                }
            }
        }
        
        return temp
    }
    
    class func addAVLNewNode(root:BinaryTreeNode?, vale:Int) -> BinaryTreeNode {
        if (BinaryTreeNode.foundNode(root: root, value: vale) != nil) {
            return root!
        }
        
        
        return root!
    }
    
    /// 左旋
    ///
    /// - Parameter node: 树
    /// - Returns: 树
    class func leftRoteTree(node:BinaryTreeNode) -> BinaryTreeNode {
        //根右子树为新根
        //右子树的左子树为根的右子树
        
        let r = node.right
        let rl = node.right?.left
        r?.left = node
        node.right = rl
        
        return r!
    }
    
    /// 右旋
    ///
    /// - Parameter node: 树
    /// - Returns: 树
    class func rightRoteTree(node:BinaryTreeNode) -> BinaryTreeNode {
        //根左子树为新根
        //左子树的右子树为根的左子树
        
        let l = node.left
        let lr = node.left?.right
        l?.right = node
        node.left = lr
        
        return l!
    }
}

//MARK: - Node

class BinaryTreeNodeProperty: NSObject {
    var depth:Int = 0
    var distance:Int = 0
    
}
