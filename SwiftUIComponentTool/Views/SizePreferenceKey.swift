//
//  SizePreferenceKey.swift
//  SwiftUIComponentTool
//
//  Created by hualala on 2021/8/12.
//

import SwiftUI

struct SizePreferenceKey: PreferenceKey {
    
    static var defaultValue: CGSize = .zero

    static func reduce(value:inout CGSize,nextValue:() -> CGSize) {
        value = nextValue()
    }
    
    typealias Value = CGSize
}

struct MeasureSizeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.background( GeometryReader{ proxy in
            Color.clear
                .preference(key: SizePreferenceKey.self, value: proxy.size)
            
        })
    }
}

extension View{
    func measureSize(perform action:@escaping (CGSize) -> Void) -> some View {
        self.modifier(MeasureSizeModifier())
            .onPreferenceChange(SizePreferenceKey.self,perform: action)
    }
}
