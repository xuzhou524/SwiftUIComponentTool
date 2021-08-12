//
//  ArticleListView.swift
//  SwiftUIComponentTool
//
//  Created by hualala on 2021/8/12.
//

import Foundation
import SwiftUI

struct Article:Decodable,Identifiable {
    var id:String
    var title:String
    var mediaName:String
    var publishTime:String
    var content:String
}

struct ArticleListView: View {
    var articles:[Article]
    var body: some View {
        ForEach(articles) { article in
            Text(article.title)
        }
    }
}
