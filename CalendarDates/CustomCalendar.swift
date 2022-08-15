//
//  CustomCalendar.swift
//  CalendarDates
//
//  Created by Sraavan Chevireddy on 8/13/22.
//

import SwiftUI
import YMCalendar

struct CustomDatePicker: UIViewRepresentable{
    
    var dateToDisable : Array<Date>
    
    @Binding var selectedDate : Date
    @Binding var isSelected : Bool
    @Environment(\.presentationMode) var canDismiss
    
    public init(disabledDates: Array<Date>,_ chooseDate: Binding<Date>,isSelected: Binding<Bool>){
        self.dateToDisable = disabledDates
        self._selectedDate = chooseDate
        self._isSelected = isSelected
    }
    
    private var calendar = Calendar.current
    
    class Coordinator: NSObject, YMCalendarDelegate,YMCalendarDataSource,YMCalendarAppearance{
   
        
        func calendarView(_ view: YMCalendarView, didSelectDayCellAtDate date: Date) {
            let weekend = parent.calendar.component(.weekday, from: date)
            let isDisableDate = parent.dateToDisable.filter({
                (NSCalendar.current.compare($0, to: date, toGranularity: .day) == .orderedSame)
            })
            
            if !isDisableDate.isEmpty || weekend == 1 || weekend == 7{
                print("You cannot select this date")
            }else{
                print("You selected the correct date")
                parent.isSelected = true
                parent.selectedDate = date
                parent.canDismiss.wrappedValue.dismiss()
            }
        }
        
        func calendarViewAppearance(_ view: YMCalendarView, dayLabelTextColorAtDate date: Date) -> UIColor {
            let weekend = parent.calendar.component(.weekday, from: date)
            
            
            let isDisableDate = parent.dateToDisable.filter({
                (NSCalendar.current.compare($0, to: date, toGranularity: .day) == .orderedSame)
            })
            
            if weekend == 1 || weekend == 7{
                return UIColor(Color.red)
            }else if !isDisableDate.isEmpty{
                return UIColor(Color.secondary)
            }
            else{
                return UIColor(Color.primary) // Dark Mode white, light mode black
            }
        }
        
        func calendarViewAppearance(_ view: YMCalendarView, dayLabelFontAtDate date: Date) -> UIFont {
            UIFont(name: "Arial Rounded MT Bold", size: 18)!
        }
        
        func calendarView(_ view: YMCalendarView, numberOfEventsAtDate date: Date) -> Int {
            0
        }
        
        func calendarView(_ view: YMCalendarView, dateRangeForEventAtIndex index: Int, date: Date) -> DateRange? {
            return DateRange(start: date, end: parent.calendar.endOfDayForDate(date))
        }
        
        func calendarView(_ view: YMCalendarView, eventViewForEventAtIndex index: Int, date: Date) -> YMEventView {
            return YMEventView(frame: CGRect.zero)
        }
        
        
        
        var parent: CustomDatePicker
        
        init(_ parent: CustomDatePicker) {
            self.parent = parent
        }
    }
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    
    func makeUIView(context: Context) -> YMCalendarView {
        let calendarView = YMCalendarView()
        
        calendarView.calendar = Calendar.current
        calendarView.scrollDirection = .vertical
        calendarView.isPagingEnabled = true
        calendarView.dayLabelHeight = 30
        
        calendarView.appearance = context.coordinator
        calendarView.delegate   = context.coordinator
        calendarView.dataSource = context.coordinator
        
        calendarView.reloadEvents()

        return calendarView
    }
    
    func updateUIView(_ uiView: YMCalendarView, context: Context) {
        
    }
    
    typealias UIViewType = YMCalendarView
    
    
}


struct CalendarWeekbarView: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<CalendarWeekbarView>) -> some YMCalendarWeekBarView {
        
        let calendarWeekBarView = YMCalendarWeekBarView()
        calendarWeekBarView.calendar = Calendar.current
        calendarWeekBarView.gradientColors = [UIColor.clear, UIColor.clear]
        
        return calendarWeekBarView
    }
    
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<CalendarWeekbarView>) {
    }
    
}
