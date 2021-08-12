//
//  ContentView.swift
//  SwiftUIComponentTool
//
//  Created by hualala on 2021/8/10.
//

import SwiftUI

struct ContentView: View {
    @State var currentPage: Int
    
    @State var overViewSize:CGSize = .zero
    
    var body: some View {
//        //渐变色 colors：渐变颜色  startPoint：开始位置 endPoint：结束位置
//        LinearGradient(gradient: Gradient(colors: [Color(red: 20/255.0, green: 158/255.0, blue: 231/255.0),Color(red: 255/255.0, green: 255/255.0, blue: 255/255.0)]), startPoint: .top, endPoint: .bottom)
        
        VStack(spacing:0) {
            //菜单栏
            XZTabbarPageView(items: ["热门","同城","汽车","热榜","种草","搞笑","视频"])
                .frame(height:55)
                .background(Color(red: 234/255.0, green: 234/255.0, blue: 234/255.0))
                .measureSize { size in //返回当前view的宽高
                    overViewSize = size
                }

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

            ArticleListView(articles: [Article(id: "0", title: "我们都是测试用的是定西不雅再不在不爱吧不加班加班不急不急不急", mediaName: "来源：不知道", publishTime: "2020-03-03", content: "我们都是测试用的是定西不雅再"),Article(id: "1", title: "我们都是测试用的是定西不雅再不在不爱吧不加班加班不急不急不急", mediaName: "来源：不知道222", publishTime: "2020-04-03", content: "我们都是测试用的是定西不雅再不在不爱吧不加班加班不急不急不急")])

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(currentPage: 0)
            .ignoresSafeArea()
    }
}
