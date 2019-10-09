//
//  TalkRobot.swift
//  DemoSet
//
//  Created by lishiyuan on 2019/8/27.
//  Copyright © 2019 Far. All rights reserved.
//

import UIKit

class T: NSObject {
}

class TalkRobot: NSObject {
    
    static let defaultRobot = TalkRobot()
    
    
    /// 对话模型 -关键字id-回答id
    struct Dialogue {
        var keys:[Int]
        var answers:[Int]
    }
    
    override init() {
        super.init()
        loadConfig()
    }
    
    let path = Bundle.main.path(forResource: "dic", ofType: "txt")
    var keywords = Array<String>.init()
    var dialogues = Array<Dialogue>.init()
    var answers = Array<String>.init()
    
    private func loadConfig() {
        loadDic()
    }
    
    private func loadDic() {
        if path?.count ?? 0 > 0 {
            //transform
            let url = URL.init(fileURLWithPath: path!)
            do{
//                let str = try String.init(contentsOfFile: path!)
//                print(str)
                let data = try Data.init(contentsOf: url)
                let d:Dictionary<String,Any> = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! Dictionary<String, Any>
                let dics:[Dictionary<String,Any>] = d["dic"] as! [Dictionary<String,Any>]
                
                for dia in dics {
                    let keys = dia["keys"] as![String]
                    let anss = dia["answer"] as! [String]
                    
                    var dialogue = Dialogue.init(keys: [], answers: [])
                    
                    for key in keys {
                        if keywords.contains(key) {
                            let keyid:Int = keywords.index(of: key) ?? 0
                            dialogue.keys.append(keyid)
                        }else {
                            keywords.append(key)
                            dialogue.keys.append(keywords.count-1)
                        }
                    }
                    //
                    for ans in anss {
                        answers.append(ans)
                        dialogue.answers.append(answers.count-1)
                    }
                    
                    dialogues.append(dialogue)
                }
                
            }catch {
                print("no string")
            }
            
        }else {
            print("load dic error~")
        }
    }
    
    func addKeyWordToDic(keys:String,answer:String) {
        
    }
    
    /// 提取关键字id
    ///
    /// - Parameter something: todosomething
    /// - Returns: keyid
    func extractKeywordsWith(something:String) -> Array<Int>{
        var keys = Array<Int>.init()
        var i = 0
        for key in keywords {
            if something.contains(key) {
                keys.append(i)
            }
            i+=1
        }
        return keys
    }
    
    /// 筛选带id的dialogue
    ///
    /// - Parameter key: key
    /// - Returns: dialogue
    func dialogueWith(key:Int) -> [Int] {
        var dias = Array<Int>.init()
        var i = 0
        for dialogue in dialogues {
            if dialogue.keys.contains(key) {
                dias.append(i)
            }
            i+=1
        }
        return dias
    }
    
    
    /// 翻译回答
    ///
    /// - Parameter answer: 设定的answer
    /// - Returns: 变量转换后的answer
    func translation(answer:String) -> String {
        //\r[0] role
        //\w[1] wait
        //\s[1] show
        //$[username]
        //$[selfname]
        //$[value] ···
        
        
        return answer
    }
    
    func answer(something:String) -> String {
        let keys = extractKeywordsWith(something: something)
        var dias = Array<Int>.init()
        for key in keys {
            let dialogue = dialogueWith(key: key)
            dias.append(contentsOf: dialogue)
        }
        //找到dias中最多的元素
        dias.sort()
        var counts:[Int:Int] = [:]
        for s in dias {
            counts[s] = (counts[s] ?? 0) + 1
        }
        var result = counts.sorted { (a, b) -> Bool in
            //
            if a.value > b.value {
                return true
            }else if a.value == b.value {
                return a.key > b.key;
            }else {
                return false
            }
        }
        //取出最大的
        if result.count > 0 {
            let max = result[0].value
            result.removeAll { (a) -> Bool in
                return a.value < max
            }
        }
        //多个的话找出占比最高的
        //再同样就找出最短的
        var minkey = 100
        for r in result {
            let d = dialogues[r.key]
            minkey = minkey < d.keys.count ? minkey : d.keys.count
        }
        result.removeAll { (a) -> Bool in
            return dialogues[a.key].keys.count > minkey
        }
        
        //随便取一个吧
        let dial = dialogues[result[Int(arc4random())%result.count].key]
        let ansid = dial.answers[Int(arc4random())%dial.answers.count]
        return translation(answer: answers[ansid])
    }
    
    

}
