//
//  Arch.swift
//  Pesky App
//
//  Created by Hector Fabian Plata Santos on 14/01/21.
//

import SwiftUI

struct Arc: Shape {
    var progress: Double
    var innerWidth: Double?
    var outerWidth: Double?
    func path(in rect: CGRect ) -> Path {
        var p = Path()
        let points: ArcGeometry
        if let unwrapedInnerWidth = innerWidth{
            points = ArcGeometry(in: rect, innerWidth: unwrapedInnerWidth ,progress: progress )
        }else if let unwrapedOuterWidthWidth = outerWidth{
            points = ArcGeometry(in: rect, outerWidth: unwrapedOuterWidthWidth ,progress: progress )
        }else{
            points = ArcGeometry(in: rect, progress: progress )
        }
        
        p.addArc(center: points.capEndCenter, radius: points.capRadius, startAngle: points.capEndAngleEnd, endAngle: points.capEndAngleStart, clockwise: true)
        p.addArc(center: points.center, radius: points.outerRadius, startAngle: points.end, endAngle: points.start, clockwise: true)
        
        p.addArc(center: points.capStartCenter, radius: points.capRadius, startAngle: points.capStartAngleStart, endAngle: points.capStartAngleEnd, clockwise: true)
        p.addArc(center: points.center, radius: points.innerRadius, startAngle: points.start, endAngle: points.end, clockwise: false)
        p.closeSubpath()
        
        return p
    }
}

//Helper for the geometry calculation Stuff of an arc

private struct ArcGeometry{
    var progress : Double
    var center: CGPoint
    var innerRadius: CGFloat
    var outerRadius: CGFloat
    var end: Angle
    var start = Angle(degrees: 170)
    
    var capStartCenter : CGPoint
    var capStartAngleStart: Angle
    var capStartAngleEnd: Angle
    
    var capEndCenter: CGPoint
    var capEndAngleStart: Angle
    var capEndAngleEnd: Angle
    
    var capRadius : CGFloat
    
    init(in rect: CGRect, progress: Double ) {
        self.progress = progress
        center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) * 0.5
        innerRadius = radius * 0.8
        outerRadius = radius
        end = Angle(degrees: progress.converting(from: 0.0 ... 1.0, to: 170.0 ... 370.0))
        
        var X1 = center.x + (outerRadius * CGFloat( cos(Float(start.radians))))
        var Y1 = center.y + (outerRadius * CGFloat( sin(Float(start.radians))))
        
        var X2  = center.x + (innerRadius * CGFloat( cos(Float(start.radians))))
        var Y2  = center.y + (innerRadius * CGFloat( sin(Float(start.radians))))
        
        capStartCenter = CGPoint(x: (X1+X2)/2, y: (Y1+Y2)/2)
        
        capStartAngleEnd = Angle(radians:  atan2(Double(capStartCenter.y - Y1), Double(capStartCenter.x - X1)) )
        capStartAngleStart = Angle(radians:  atan2(Double(capStartCenter.y - Y2), Double(capStartCenter.x - X2)) )
        
        X1 = center.x + (outerRadius * CGFloat( cos(Float(end.radians))))
        Y1 = center.y + (outerRadius * CGFloat( sin(Float(end.radians))))
        
        X2  = center.x + (innerRadius * CGFloat( cos(Float(end.radians))))
        Y2  = center.y + (innerRadius * CGFloat( sin(Float(end.radians))))
        
        capEndCenter = CGPoint(x: (X1+X2)/2, y: (Y1+Y2)/2)
        capEndAngleStart = Angle(radians:  atan2(Double(capEndCenter.y - Y2), Double(capEndCenter.x - X2)) )
        capEndAngleEnd = Angle(radians:  atan2(Double(capEndCenter.y - Y1), Double(capEndCenter.x - X1)) )
        
        capRadius = (outerRadius - innerRadius) * 0.5
    }
    
    init(in rect: CGRect, innerWidth: Double ,progress: Double){
        self.progress = progress
        center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) * 0.5
        innerRadius = radius * CGFloat( innerWidth )
        outerRadius = radius
        end = Angle(degrees: progress.converting(from: 0.0 ... 1.0, to: 170.0 ... 370.0))
        
        var X1 = center.x + (outerRadius * CGFloat( cos(Float(start.radians))))
        var Y1 = center.y + (outerRadius * CGFloat( sin(Float(start.radians))))
        
        var X2  = center.x + (innerRadius * CGFloat( cos(Float(start.radians))))
        var Y2  = center.y + (innerRadius * CGFloat( sin(Float(start.radians))))
        
        capStartCenter = CGPoint(x: (X1+X2)/2, y: (Y1+Y2)/2)
        
        capStartAngleEnd = Angle(radians:  atan2(Double(capStartCenter.y - Y1), Double(capStartCenter.x - X1)) )
        capStartAngleStart = Angle(radians:  atan2(Double(capStartCenter.y - Y2), Double(capStartCenter.x - X2)) )
        
        X1 = center.x + (outerRadius * CGFloat( cos(Float(end.radians))))
        Y1 = center.y + (outerRadius * CGFloat( sin(Float(end.radians))))
        
        X2  = center.x + (innerRadius * CGFloat( cos(Float(end.radians))))
        Y2  = center.y + (innerRadius * CGFloat( sin(Float(end.radians))))
        
        capEndCenter = CGPoint(x: (X1+X2)/2, y: (Y1+Y2)/2)
        capEndAngleStart = Angle(radians:  atan2(Double(capEndCenter.y - Y2), Double(capEndCenter.x - X2)) )
        capEndAngleEnd = Angle(radians:  atan2(Double(capEndCenter.y - Y1), Double(capEndCenter.x - X1)) )
        
        capRadius = (outerRadius - innerRadius) * 0.5
    }
    
    init(in rect: CGRect, outerWidth: Double ,progress: Double){
        self.progress = progress
        center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) * 0.5
        innerRadius = radius * 0.8
        outerRadius = radius * CGFloat(outerWidth)
        end = Angle(degrees: progress.converting(from: 0.0 ... 1.0, to: 170.0 ... 370.0))
        
        var X1 = center.x + (outerRadius * CGFloat( cos(Float(start.radians))))
        var Y1 = center.y + (outerRadius * CGFloat( sin(Float(start.radians))))
        
        var X2  = center.x + (innerRadius * CGFloat( cos(Float(start.radians))))
        var Y2  = center.y + (innerRadius * CGFloat( sin(Float(start.radians))))
        
        capStartCenter = CGPoint(x: (X1+X2)/2, y: (Y1+Y2)/2)
        
        capStartAngleEnd = Angle(radians:  atan2(Double(capStartCenter.y - Y1), Double(capStartCenter.x - X1)) )
        capStartAngleStart = Angle(radians:  atan2(Double(capStartCenter.y - Y2), Double(capStartCenter.x - X2)) )
        
        X1 = center.x + (outerRadius * CGFloat( cos(Float(end.radians))))
        Y1 = center.y + (outerRadius * CGFloat( sin(Float(end.radians))))
        
        X2  = center.x + (innerRadius * CGFloat( cos(Float(end.radians))))
        Y2  = center.y + (innerRadius * CGFloat( sin(Float(end.radians))))
        
        capEndCenter = CGPoint(x: (X1+X2)/2, y: (Y1+Y2)/2)
        capEndAngleStart = Angle(radians:  atan2(Double(capEndCenter.y - Y2), Double(capEndCenter.x - X2)) )
        capEndAngleEnd = Angle(radians:  atan2(Double(capEndCenter.y - Y1), Double(capEndCenter.x - X1)) )
        
        capRadius = (outerRadius - innerRadius) * 0.5
    }
}




extension FloatingPoint {
    func converting(from input: ClosedRange<Self>, to output: ClosedRange<Self>) -> Self {
        let x = (output.upperBound - output.lowerBound) * (self - input.lowerBound)
        let y = (input.upperBound - input.lowerBound)
        return x / y + output.lowerBound
    }
}


