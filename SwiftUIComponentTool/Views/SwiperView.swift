//
//  SwiperView.swift
//  SwiftUIComponentTool
//
//  Created by hualala on 2021/8/11.
//

import SwiftUI

struct SwiperView<SwiperItem:View>:View {
    
    var items:[SwiperItem]
    @Binding var currentPage: Int
    
    private let time = Timer.publish(every: 3, on: .current, in: .common).autoconnect()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Swiper(items: items, currentPage: $currentPage)
                .onReceive(time) { _ in
                    currentPage += 1
                    if currentPage >= items.count{
                        currentPage = 0
                    }
                }
            
            SwiperControl(numOfPage: items.count, currentPage: $currentPage)
        }
    }
}
