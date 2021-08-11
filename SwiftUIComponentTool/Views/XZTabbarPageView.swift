//
//  XZTabbarPageView.swift
//  SwiftUIComponentTool
//
//  Created by hualala on 2021/8/10.
//

import SwiftUI

struct XZTabbarPageItem:Identifiable {
    var id = UUID()
    var title:String
    var index:Int
}

struct XZTabbarPageView: View {
    
    var items:[String]
    
    private var tabItems:[XZTabbarPageItem] {
        var index = -1
        return items.map { strItem -> XZTabbarPageItem in
            index += 1
            return XZTabbarPageItem(title: strItem, index: index)
        }
    }
    
    var isScrollable:Bool = true
    
    var body: some View {
        GeometryReader { reader in
            if isScrollable {
                ScrollView(.horizontal,showsIndicators:false) {
                    ScrollViewReader{ proxy in
                        XZTabbarPageSubview(items: tabItems,proxy: proxy,width: reader.size.width,height: 55)
                    }
                }
            }else{
                XZTabbarPageSubview(items: tabItems,width: reader.size.width,height: 55)
            }
        }
    }
}

struct XZTabbarPageSubview: View {
    
    var items:[XZTabbarPageItem] = []
    
    var proxy:ScrollViewProxy?
    //未选中的标题字体大小
    var titleFont:CGFloat = 16.0
    //选中的标题字体大小
    var selelctTitleFont:CGFloat = 16.0
    //未选中的标题颜色
    var titleColor:Color = Color(red: 102/255.0, green: 102/255.0, blue: 102/255.0)
    //选中的标题颜色
    var selectTitleColor = Color.orange
    
    var width:CGFloat
    var height:CGFloat
    
    //item宽
    private var itemWidth:CGFloat {
        if items.count > 7 {
            return width / 7
        }else{
            return width / CGFloat(items.count)
        }
    }
    //指示器高度
    private let indeicaterHeight:CGFloat = 3
    //当前选中的page
    @State private var selectedIndex = 0
    
    var body: some View {
        VStack(alignment:.leading,spacing:0) {
            HStack(spacing:0) {
                ForEach(items) { item in
                    Text(item.title)
                        .frame(width:itemWidth)
                        .font(.system(size: titleFont))
                        .foregroundColor(selectedIndex == item.index ? selectTitleColor : titleColor)
                        .onTapGesture {
                            selectedIndex = item.index
                            
                            //计算剩余客滚动宽度
                            let surplusW = (CGFloat(items.count) - CGFloat(selectedIndex)) * itemWidth
                            let halfOfWidth = width / 2
                            
                            withAnimation{
                                if halfOfWidth >= surplusW {
                                    proxy?.scrollTo(item.index + 1)
                                }else{
                                    proxy?.scrollTo(item.index,anchor: .center)
                                }
                            }
                        }
                        .id(item.index)
                }
            }
            .frame(height:height - indeicaterHeight)
            
            Divider()
                .frame(width: itemWidth, height: indeicaterHeight)
                .background(selectTitleColor)
                .offset(x:CGFloat(selectedIndex) * itemWidth)
                .animation(.easeInOut(duration: 0.2))
                .padding(.top,0)
        }
        .frame(height:height)
    }
}

struct XZTabbarPageView_Previews: PreviewProvider {
    static var previews: some View {
        XZTabbarPageView(items: ["111"])
    }
}
