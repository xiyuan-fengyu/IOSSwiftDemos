//
//  KMean.swift
//  IOSSwiftDemos
//
//  Created by 邓伯操 on 16/6/16.
//  Copyright © 2016年 xiyuan. All rights reserved.
//

import Foundation

class KMean<T> {
    
    private var data: [T]
    
    let k: Int
    
    private var dataCluster: [(T, [T])]
    
    private var distance: (T, T) -> Double
    
    private var avg: [T] -> T
    
    private var nearestDis: Double
    
    init(data: [T], k: Int, nearestDis: Double, distance: (T, T) -> Double, avg: [T] -> T) {
        self.data = data
        self.k = k
        self.nearestDis = nearestDis
        self.distance = distance
        self.avg = avg
        
        self.dataCluster = []
    }
    
    func interation(max: Int) -> KMean<T> {
        for _ in 0..<self.k {
            let temp: (T, [T]) = (data[data.count.arc4random], [])
            dataCluster.append(temp)
        }
        
        for _ in 0..<max {
            if(compute()) {
                break
            }
        }
        
        return self
    }
    
    subscript(index: Int) ->  T {
        return dataCluster[index].0
    }
    
    private func compute() -> Bool {
        for i in self.data.indices {
            let t = self.data[i]
            let nearestIndex = nearest(t)
            dataCluster[nearestIndex].1.append(t)
        }
        
        var flag = true
        for i in 0..<self.k {
            let avgT = avg(dataCluster[i].1)
            let dis = distance(avgT, dataCluster[i].0)
            dataCluster[i].0 = avgT
            if(dis > nearestDis) {
                flag = false
            }
        }
        
        if flag {
            dataCluster.sortInPlace {$0.0.1.count > $0.1.1.count}
        }
        else {
            for i in 0..<self.k {
                dataCluster[i].1 = []
            }
        }
        
        return flag
    }
    
    private func nearest(t: T) -> Int {
        var arr: [(Int, Double)] = []
        for i in 0..<self.k {
            let dis = distance(t, self.data[i])
            arr.append((i, dis))
        }
        arr.sortInPlace {$0.0.1 < $0.1.1}
        return arr[0].0
    }
    
}



//KMean算法测试
//var arrDD: [(Double, Double)] = [
//    (0, 0),
//    (0, 1),
//    (1, 0),
//    (1, 1),
//    (10, 10),
//    (10, 11),
//    (11, 11)
//]
//let kMean = KMean<(Double, Double)>(
//    data: arrDD,
//    k: 2,
//    nearestDis: 2,
//    distance: {
//        (item0: (Double, Double), item1: (Double, Double)) -> Double in
//        let dis0 = pow(item0.0 - item1.0, 2.0) + pow(item0.1 - item1.1, 2.0)
//        return pow(dis0, 0.5)
//    },
//    avg: {
//        (tArr: [(Double, Double)]) -> (Double, Double) in
//        var total = (0.0, 0.0)
//        for i in tArr.indices {
//            let item = tArr[i]
//            total.0 += item.0
//            total.1 += item.1
//        }
//        let count = Double(tArr.count)
//        return (total.0 / count, total.1 / count)
//    }
//)
//print(kMean.interation(5)[0])








