//
//  BarGraphView.swift
//  LoginTest
//
//  Created by Chris Kalas on 25/07/2014.
//  Copyright (c) 2014 Chris Kalas. All rights reserved.
//

import Foundation
import UIKit

// A simple implementation of a custom bar graph view

class BarGraphView: UIView {
    
    var frameWidth = CGFloat(0.0)
    var frameHeight = CGFloat(0.0)
    var values = [CGFloat]()
    var maxY = CGFloat(0.0)
    
    init(frame: CGRect, data: [CGFloat], maxYVal: Int) {
        super.init(frame: frame)
        frameWidth = frame.width
        frameHeight = frame.height
        values = data
        maxY = CGFloat(maxYVal)
    }
    override func drawRect(rect: CGRect) {
        
        // Setting up size variables
        let xaxis = 0.6*frameWidth
        let yaxis = 0.5*frameHeight
        let xstart = 0.2*frameWidth
        let ystart = 0.2*frameHeight
        let gridOffSetY = CGFloat(0.1)
        let xseparation = CGFloat(xaxis*0.05)
        
        
        let numValues = CGFloat(values.count)
        
        let context = UIGraphicsGetCurrentContext()
        let bgColor = UIColor(red:255.0, green: 255.0, blue: 255.0, alpha: 1.0).CGColor
        CGContextSetFillColorWithColor(context, bgColor);
        CGContextFillRect(context, bounds);
        
        CGContextSetFillColorWithColor(context, UIColor.greenColor().CGColor)
        let barWidth:CGFloat = ((xaxis-(numValues+1)*xseparation)/numValues)
        var count:CGFloat = 0
        for number in values {
            let x = xstart + xseparation + (count * (barWidth + xseparation))
            //let barRect = CGRectMake(x, (height-number*height), barWidth, height)
            // scale the height to a max of height - some value, and a value of x/7
            let barRect = CGRect(x: x, y:ystart+yaxis, width: barWidth, height: -(number/maxY)*yaxis)
            CGContextAddRect(context, barRect)
            count++
        }
        CGContextFillPath(context)
        
        
        // Grid
        var bezier = UIBezierPath()
        // Draw y-axis
        bezier.moveToPoint(CGPointMake(xstart,ystart))
        bezier.addLineToPoint(CGPointMake(xstart,ystart+yaxis+5))
        //Draw x-axis
        bezier.moveToPoint(CGPointMake(xstart-5,ystart+yaxis))
        bezier.addLineToPoint(CGPointMake(xstart+xaxis,ystart+yaxis))
        // Draw value markings on y-axis
        let divisor = CGFloat((yaxis-gridOffSetY)/maxY) // max y-value, with offset
        for i in 0..<maxY {
            bezier.moveToPoint(CGPointMake(xstart-CGFloat(2.5),ystart+gridOffSetY+CGFloat(i)*divisor))
            bezier.addLineToPoint(CGPointMake(xstart,ystart+gridOffSetY+CGFloat(i)*divisor))
        }
        UIColor.blackColor().setStroke()
        bezier.stroke()
    }
    
}