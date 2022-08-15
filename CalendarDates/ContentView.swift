//
//  ContentView.swift
//  CalendarDates
//
//  Created by Sraavan Chevireddy on 8/13/22.
//

import SwiftUI
import iPhoneNumberField

struct ContentView: View {
    
    // Send your list of dates to disable here.
    @State var date = [Date(), Date(timeIntervalSince1970: 1661279400)]
    @State var phone = ""
    @State var selectedTimeZone = "Eastern Standard Time"
    
    @State var timeZones = [
        "Eastern Standard Time",
        "Central Standard Time",
        "Mountain Standard Time",
        "Pacific Standard Time "
    ]
    
    var body: some View {
//        GeometryReader{ _ in
//            CustomDatePicker(disabledDates: date)
//                .frame(width: 250, height: 250)
//                .padding()
//        }
        
        NavigationView{
            Form{
                Section {
                    iPhoneNumberField("Phone", text: $phone)
                        .flagHidden(false)
                        .maximumDigits(10)
                } header: {
                    Text("Phone")
                }

                Section{
                    Picker("Select", selection: $selectedTimeZone) {
                        ForEach(timeZones, id: \.self){
                            Text($0)
                        }
                    }
                } header: {
                    Text("Time Zone*")
                }
            }
            .navigationTitle("Schedule a Call")
        }.navigationBarTitleDisplayMode(.inline)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

