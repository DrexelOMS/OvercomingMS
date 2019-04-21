//
//  DatePickerSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/21/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import JTAppleCalendar

class DatePickerSVC : SlidingAbstractSVC, JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    
    override var nibName: String {
        get {
            return "DatePickerSVC"
        }
    }
    
    @IBOutlet weak var datePicker: JTAppleCalendarView!
    let tracking = TrackingModulesDBS()
    
    override func customSetup() {
        datePicker.ibCalendarDelegate = self
        datePicker.ibCalendarDataSource = self
        
        datePicker.register(UINib(nibName: "DateCell", bundle: nil), forCellWithReuseIdentifier: "DateCell")
        datePicker.register(UINib(nibName: "DateHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DateHeader")
        
        //datePicker.scrollingMode = .stopAtEachCalendarFrame
        datePicker.showsHorizontalScrollIndicator = false
        
        datePicker.scrollToDate(Date(), animateScroll: false)
        
    }
    
    //MARK: Cell Styling
    
    func configureCell(view: JTAppleCell?, cellState: CellState) {
        guard let cell = view as? DateCell  else { return }
        cell.numberLabel.text = cellState.text
        handleCellTextColor(cell: cell, cellState: cellState)
    }
    
    func handleCellTextColor(cell: DateCell, cellState: CellState) {
        cell.completeLabel.text = ""
        if cellState.dateBelongsTo != .thisMonth ||
            OMSDateAccessor().greaterThanComparison(left: cellState.date, right: OMSDateAccessor().todaysFullDate) {
            cell.numberLabel.textColor = UIColor.gray
            cell.isUserInteractionEnabled = false
            return
        }
        
        if tracking.getTrackingDay(date: OMSDateAccessor.getFormatedDate(date: cellState.date)).IsDayComplete {
            cell.completeLabel.text = "*"
        }
        
        cell.numberLabel.textColor = UIColor.black
        cell.isUserInteractionEnabled = true
    }
    
    //MARK: Calendar Delegates
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        let startDate = formatter.date(from: "2019 01 01")!
        let endDate = Date()
        return ConfigurationParameters(startDate: startDate, endDate: endDate, hasStrictBoundaries: true)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "DateCell", for: indexPath) as! DateCell
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell, cellState: cellState)
    }
    
    func calendarSizeForMonths(_ calendar: JTAppleCalendarView?) -> MonthSize? {
        return MonthSize(defaultSize: 30)
    }
    
    //MARK: Header setup
    
    func calendar(_ calendar: JTAppleCalendarView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTAppleCollectionReusableView {
        
        let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "DateHeader", for: indexPath) as! DateHeader
        header.monthLabel.text = OMSDateAccessor.getStyledDate(date: OMSDateAccessor.getFormatedDate(date: range.start))
        return header
    }
    
    //MARK: Selected Date
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        globalCurrentFullDate = date
        
        parentVC.dismiss()
    }
    
}
