//: Playground - noun: a place where people can play

import GameplayKit
import UIKit

class Totem {
    
    var type: Int! //0火 1水
    var nearbyTotems = [Totem]()
    
    init(type: Int){
        self.type = type
    }
}

class FiveByFiveAllFireGame {
    
    var totems = [Totem]()
    var waterCount = 0
    var tapRecord = [Int]()
    var maxCount = 0
    var startTime = CFAbsoluteTimeGetCurrent()
    
    init(){

        //先创建所有图腾
        for _ in 0..<5{
            for _ in 0..<5{
                let totem = Totem(type: 0)
                totems.append(totem)
            }
        }
        
        //再指定位置关系
        for (i, totem) in totems.enumerate() {
            let y = i / 5
            let x = i % 5
            
            //上
            if y - 1 >= 0 {
                totem.nearbyTotems.append(totems[i-5])
            }
            //下
            if y + 1 < 5 {
                totem.nearbyTotems.append(totems[i+5])
            }
            //左
            if x - 1 >= 0 {
                totem.nearbyTotems.append(totems[i-1])
            }
            //右
            if x + 1 < 5 {
                totem.nearbyTotems.append(totems[i+1])
            }
            
        }

    }
    
    
    func start(){
        while waterCount != 25 {
            randomTap()
        }
        print("游戏胜利✌️, 共点击\(tapRecord.count)次")
    }
    
    func tap(at index: Int){
        
        let tapppedTotem = totems[index]
        //tapRecord.append(index)
        
        //点击图腾会让它本身以及四周的图腾变成相反的属性
        turn(tapppedTotem)
        tapppedTotem.nearbyTotems.forEach { turn($0) }
    }
    
    func turn(totem: Totem){
        if totem.type == 1 {
           totem.type = 0
            waterCount -= 1
        } else {
            totem.type = 1
            waterCount += 1
            if waterCount > maxCount {
                maxCount = waterCount
                print("新纪录:\(maxCount), 用时：\(Int(CFAbsoluteTimeGetCurrent() - startTime))秒")
            }
        }
    }
    
    func randomTap(){
        tap(at: randomIndex())
    }
    
    func randomIndex() -> Int {
        return abs(GKRandomSource.sharedRandom().nextInt() % 25)
    }
}

//创建游戏
let game = FiveByFiveAllFireGame()

game.start()




