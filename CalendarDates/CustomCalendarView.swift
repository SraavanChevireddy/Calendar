//
//  CustomCalendarView.swift
//  CalendarDates
//
//  Created by Sraavan Chevireddy on 8/15/22.
//
// Date to 1970 conveter
//https://www.epochconverter.com

import SwiftUI

struct CustomCalendarView: View {
    
    // Send your list of dates apart from Saturday and Sunday.
    @State var date = [
        Date(),
        Date(timeIntervalSince1970: 1661882258)
    ]
    @Binding var selectedDate : Date
    @Binding var isDateSelected: Bool
    @Binding var hidePop : Bool // Just for demo purpose //// TODO: Remove later
    
    @Environment(\.presentationMode) var dismiss
    
    var body: some View {
        GeometryReader{ proxy in
            VStack(alignment: .center){
                HStack{
                    Button {
                        dismiss.wrappedValue.dismiss()
                        hidePop.toggle()
                    } label: {
                        Label("Close", systemImage: "xmark.circle.fill")
                    }
                    Spacer()
                }.padding()
                
                Group{
                    CalendarWeekbarView()
                        .frame(height: 20)
                    CustomDatePicker(disabledDates: date, $selectedDate, isSelected: $isDateSelected)
                        .frame(height: proxy.size.height*0.6)
                }.frame(width: proxy.size.width*0.8)
            }.padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
        }
        
            .onChange(of: isDateSelected) { newValue in
                if newValue{
                    dismiss.wrappedValue.dismiss()
                    hidePop.toggle()
                }
            }
    }
}

