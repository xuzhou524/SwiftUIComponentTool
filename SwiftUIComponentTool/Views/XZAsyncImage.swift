//
//  XZAsyncImage.swift
//  SwiftUIComponentTool
//
//  Created by hualala on 2021/8/12.
//

import Combine
import SwiftUI

struct XZAsyncImage<PlaceHolder:View>: View {
    
    private let placeHolder:PlaceHolder
    @StateObject private var loader:XZImageLoader
    
    init(_ url:String, @ViewBuilder placeHolder: ()-> PlaceHolder) {
        self.placeHolder = placeHolder()
        _loader = StateObject(wrappedValue: XZImageLoader(url: url))
    }
    
    var body: some View {
        Group {
            if loader.image != nil {
                Image(uiImage: loader.image!)
                    .resizable()
                    .scaledToFit()
            }else{
                placeHolder
            }
        }
        .onAppear(perform: loader.load)
    }
}

//网络图片加载器
class XZImageLoader:ObservableObject {
    @Published var image:UIImage?
    
    private let url:String
    private var cancelable:AnyCancellable?
    
    init(url:String) {
        self.url = url
    }
    
    func load() {
        guard let url = URL(string: url) else {
            return
        }
        
        cancelable = URLSession.shared.dataTaskPublisher(for: url)
            .map{ UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in
                self?.image = $0
            })
    }
    
    deinit {
        cancelable?.cancel()
    }
}
