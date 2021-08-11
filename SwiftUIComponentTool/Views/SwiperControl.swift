//
//  SwiperControl.swift
//  SwiftUIComponentTool
//
//  Created by hualala on 2021/8/11.
//

import SwiftUI

struct SwiperControl: UIViewRepresentable {
    
    var numOfPage:Int
    @Binding var currentPage:Int
    
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = numOfPage
        control.addTarget(context.coordinator, action: #selector(context.coordinator.onChanged(sender:)), for: .valueChanged)
        return control
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
    
    func makeCoordinator() -> Coodinator {
        Coodinator(self)
    }
    
    typealias UIViewType = UIPageControl
    
    class Coodinator: NSObject {
        var parent:SwiperControl
        init(_ parent:SwiperControl) {
            self.parent = parent
        }
        
        @objc func onChanged(sender:UIPageControl){
            parent.currentPage = sender.currentPage
        }
        
    }
}
