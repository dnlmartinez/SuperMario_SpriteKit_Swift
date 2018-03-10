//
//  AppDelegate.swift
//  SuperJoel
//
//  Created by daniel martinez gonzalez on 27/3/17.
//  Copyright © 2017 daniel martinez gonzalez. All rights reserved.
//

import UIKit
import Foundation
import SpriteKit

func CGPointMultiplyScalar(a: CGPoint, b: CGFloat) -> CGPoint{
    return CGPoint(x: a.x * b ,y: a.y * b)
}

func CGPointAdd(a: CGPoint, b: CGPoint) -> CGPoint{
    return CGPoint(x: a.x + b.x ,y: a.y + b.y)
}

func CGPointSubtract(a: CGPoint, b: CGPoint) -> CGPoint{
    return CGPoint(x: a.x - b.x ,y: a.y - b.y)
}

func Clamp(value: CGFloat, min: CGFloat, max: CGFloat) -> CGFloat{
    return value < min ? min : value > max ? max : value
}

func returnMax(a: CGFloat, b: CGFloat) -> CGFloat{
    return a > b ? a : b
}

func returnMin(a: CGFloat, b: CGFloat) -> CGFloat{
    return a < b ? a : b
}


class Utils{
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()){
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds){
            completion()
        }
    }
    
    
}
