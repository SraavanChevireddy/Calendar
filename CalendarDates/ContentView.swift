//
//  ContentView.swift
//  CalendarDates
//
//  Created by Sraavan Chevireddy on 8/13/22.
//

import SwiftUI
import iPhoneNumberField

struct ContentView: View {
    @State var phone = ""
    
    @State var selectedTimeZone = "Eastern Standard Time"
    @State var showCalendarPicker = false
    @State var isScheduled = false
    
    @State var selectDate = Date()
    @State var showPopOverView = false
    @State var showBlurView = false
    
    @State var timeZones = [
        "Eastern Standard Time",
        "Central Standard Time",
        "Mountain Standard Time",
        "Pacific Standard Time "
    ]
    
    var body: some View {
        
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
                
                Section{
                    HStack(alignment: .center) {
                        if isScheduled{
                            Text(selectDate, style: .date)
                        }else{
                            Text("Choose a Date")
                        }
                        Spacer()
                        Image(systemName: "calendar")
                            .resizable()
                            .frame(width: 20, height: 20)
                        
                    }.onTapGesture {
                        showCalendarPicker.toggle()
                    }
                } header:{
                    Text("Choose Date *")
                }
                
                
            }.halfSheet(showSheet: $showCalendarPicker, halfSheet: {
                CustomCalendarView(selectedDate: $selectDate, isDateSelected: $isScheduled, hidePop: $showPopOverView)
            }, onEnd: {
                print("Nothing at the moment!")
            })
                .overlay(content: {
                    if showPopOverView{
                        PopOverView{
                            CustomCalendarView(selectedDate: $selectDate, isDateSelected: $isScheduled, hidePop: $showPopOverView)
                                .frame(height: 400)
                        }
                    }else if showBlurView{
                        PopOverView{
                            CustomCalendarView(selectedDate: $selectDate, isDateSelected: $isScheduled, hidePop: $showBlurView)
                                .frame(height: 400)
                        }.background(.thickMaterial)
                    }
                    else{
                        EmptyView()
                    }
                })
            .navigationTitle("Schedule a Call")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("PopOver"){
                        showPopOverView.toggle()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("BlurView"){
                        showBlurView.toggle()
                    }
                }
            }
        }.navigationBarTitleDisplayMode(.inline)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

