//
//  ContentView.swift
//  SwiftUIComponentTool
//
//  Created by hualala on 2021/8/10.
//

import SwiftUI

struct ContentView: View {
    @State var currentPage: Int
    var body: some View {
        VStack(spacing:0) {
            //菜单栏
            XZTabbarPageView(items: ["热门","同城","汽车","热榜","种草","搞笑","视频"])
                .frame(height:55)
                .background(Color(red: 234/255.0, green: 234/255.0, blue: 234/255.0))
            
            ScrollView {
                LazyVStack(spacing:0){//只支持 iOS14.0 以上
                    //轮播图
                    SwiperView(items: [Image("banner").resizable(),
                                       Image("banner1").resizable(),
                                       Image("banner2").resizable()],
                               currentPage: $currentPage)
                        .aspectRatio(7/3,contentMode: .fit)
                        .cornerRadius(12.0)
                        .padding(EdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 15))
                }
                
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(currentPage: 0)
    }
}
