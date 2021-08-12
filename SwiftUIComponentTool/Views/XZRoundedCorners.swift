//
//  XZRoundedCorners.swift
//  SwiftUIComponentTool
//
//  Created by hualala on 2021/8/12.
//

import SwiftUI

//任意设置圆角
struct XZRoundedCorners<Content: ShapeStyle>: View {
    
    private let defaultRadius: CGFloat = 10.0
    
    private var topLeft:CGFloat = 0.0
    private var topRight:CGFloat = 0.0
    private var bottomLeft:CGFloat = 0.0
    private var bottomRight:CGFloat = 0.0
    
    private var background: Content
    
    init() {
        self.topLeft = defaultRadius
        self.topRight = defaultRadius
        self.bottomLeft = defaultRadius
        self.bottomRight = defaultRadius
        
        self.background = Color.black as! Content
    }
    
    init(top: CGFloat = 0.0,bottom: CGFloat = 0.0, background: Content = Color.black as! Content) {
        
        self.topLeft = top
        self.topRight = top
        self.bottomLeft = bottom
        self.bottomRight = bottom
        
        self.background = background
        
    }
    
    init(topLeft: CGFloat = 0.0,topRight: CGFloat = 0.0,bottomLeft: CGFloat = 0.0,bottomRight: CGFloat = 0.0, background: Content = Color.black as! Content) {
        
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomLeft = bottomLeft
        self.bottomRight = bottomRight
        
        self.background = background
        
    }
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height
                
                path.addArc(center: CGPoint(x: width - topRight, y: topRight), radius: topRight, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                
                path.addArc(center: CGPoint(x: width - bottomRight, y: height - bottomRight), radius: bottomRight, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                
                path.addArc(center: CGPoint(x: bottomLeft, y: height - bottomLeft), radius: bottomLeft, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                
                path.addArc(center: CGPoint(x: topLeft, y: topLeft), radius: topLeft, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
            }
            .fill(background)
        }
    }
}

struct XZRoundedCorners_Previews: PreviewProvider {
    static var previews: some View {
        XZRoundedCorners(topLeft: 20, bottomRight: 20, background: Color.red)
            .frame(width: 200, height: 100)
    }
}
