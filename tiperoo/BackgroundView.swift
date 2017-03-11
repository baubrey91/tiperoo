//
//  BackgroundView.swift
//  coreGraphicsTest
//
//  Created by Brandon on 3/1/17.
//  Copyright © 2017 Brandon. All rights reserved.
//

import UIKit

@IBDesignable
class BackgroundView: UIView {
    
    @IBInspectable var lightColor: UIColor = UIColor.orange{
        didSet{
            setNeedsDisplay()
        }
    }
    @IBInspectable var darkColor: UIColor = UIColor.yellow{
        didSet{
            setNeedsDisplay()
        }
    }
    @IBInspectable var patternSize: CGFloat = 50
    
    
    override func draw(_ rect: CGRect) {
            
        drawTriangles(rect: rect)


    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    func drawTriangles(rect: CGRect){
        
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(darkColor.cgColor)
        
        context?.fill(rect)
        
        let drawSize = CGSize(width: patternSize, height: patternSize)
        
        UIGraphicsBeginImageContextWithOptions(drawSize, true, 0.0)
        let drawingContext = UIGraphicsGetCurrentContext()
        
        darkColor.setFill()
        
        drawingContext?.fill(CGRectMake(0, 0, drawSize.width, drawSize.height))
        
        let trianglePath = UIBezierPath()
        
        trianglePath.move(to: CGPoint(x: drawSize.width/2, y: 0))
        
        trianglePath.addLine(to: CGPoint(x: 0, y: drawSize.height/2))
        
        trianglePath.addLine(to: CGPoint(x: drawSize.width, y: drawSize.height/2))
        
        trianglePath.move(to: CGPoint(x: 0, y: drawSize.height/2))
        
        trianglePath.addLine(to: CGPoint(x: drawSize.width/2, y: drawSize.height))
        
        trianglePath.addLine(to: CGPoint(x: 0, y: drawSize.height))
        
        trianglePath.move(to: CGPoint(x: drawSize.width, y: drawSize.height/2))
        
        trianglePath.addLine(to: CGPoint(x: drawSize.width/2, y: drawSize.height))
        
        trianglePath.addLine(to: CGPoint(x: drawSize.width, y: drawSize.height))
        
        lightColor.setFill()
        trianglePath.fill()
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        UIColor(patternImage: img!).setFill()
        context?.fill(rect)
    }
    
}
