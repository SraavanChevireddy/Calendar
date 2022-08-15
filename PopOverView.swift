//
//  BottomSheetView.swift
//  MESForGlobal
//
//  Created by Apple on 16/12/21.
//
// Refernce link
//https://www.youtube.com/watch?v=rQKT7tn4uag


import SwiftUI

struct PopOverView<T:View>  : View{
    var content: T
    init(@ViewBuilder content: ()->T)
    {
        self.content = content()
    }
    var body: some View{
        ZStack(alignment: .center, content: {
            Color.gray.opacity(0.8) // If required Background Color
            content
        }).edgesIgnoringSafeArea(.all)
    }
}


