//
//  CustomCalendarView.swift
//  CalendarDates
//
//  Created by Sraavan Chevireddy on 8/15/22.
//

import SwiftUI

struct CustomCalendarView: View {
    
    // Send your list of dates apart from Saturday and Sunday.
    @State var date = [Date(), Date(timeIntervalSince1970: 1661279400)]
    @Binding var selectedDate : Date
    @Binding var isDateSelected: Bool
    
    var body: some View {
        VStack(alignment: .center){
            CalendarWeekbarView()
                .frame(height: 20)
            CustomDatePicker(disabledDates: date, $selectedDate, isSelected: $isDateSelected)
                .frame(height: 200)
        }.frame(width: 200)
    }
}

