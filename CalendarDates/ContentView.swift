//
//  ContentView.swift
//  CalendarDates
//
//  Created by Sraavan Chevireddy on 8/13/22.
//

import SwiftUI

struct ContentView: View {
    
    // Send your list of dates to disable here.
    @State var date = [Date(), Date(timeIntervalSince1970: 1661279400)]
    var body: some View {
        GeometryReader{ _ in
            CustomDatePicker(disabledDates: date)
                .frame(width: 250, height: 250)
                .padding()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

