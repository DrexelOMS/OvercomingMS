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
    var startDate: Date!
    
    override func customSetup() {
        datePicker.ibCalendarDelegate = self
        datePicker.ibCalendarDataSource = self
        
        datePicker.register(UINib(nibName: "DateCell", bundle: nil), forCellWithReuseIdentifier: "DateCell")
        datePicker.register(UINib(nibName: "DateHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DateHeader")
        
        datePicker.scrollingMode = .stopAtEachCalendarFrame
        datePicker.showsHorizontalScrollIndicator = false
        datePicker.scrollDirection = .horizontal
        
        datePicker.scrollToDate(Date(), animateScroll: false)

        
    }
    
    //MARK: Cell Styling
    
    func configureCell(view: JTAppleCell?, cellState: CellState) {
        guard let cell = view as? DateCell  else { return }
        cell.numberLabel.text = cellState.text
        handleCellTextColor(cell: cell, cellState: cellState)
    }
    
    func handleCellTextColor(cell: DateCell, cellState: CellState) {
        cell.completeImageView.image = UIImage(named: "incomplete-day")
        if  OMSDateAccessor().lessThanComparison(left: cellState.date, right: startDate) ||
            OMSDateAccessor().greaterThanComparison(left: cellState.date, right: OMSDateAccessor().todaysFullDate) {
            cell.numberLabel.textColor = UIColor.gray
            cell.isUserInteractionEnabled = false
            return
        }
        
        if TrackingModulesDBS(editingDate: OMSDateAccessor.getFormatedDate(date: cellState.date)).getTrackingDay().IsDayComplete {
            cell.completeImageView.image = UIImage(named: "complete-day")
        }
        
        cell.numberLabel.textColor = UIColor.black
        cell.isUserInteractionEnabled = true
    }
    
    //MARK: Calendar Delegates
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let date = UserDefaults.standard.object(forKey: "FirstOpenDate") as! Date
        startDate = date

        return ConfigurationParameters(startDate: startDate, endDate: OMSDateAccessor().todaysFullDate, hasStrictBoundaries: true)
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
        return MonthSize(defaultSize: 50)
    }
    
    //MARK: Header setup
    
    func calendar(_ calendar: JTAppleCalendarView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTAppleCollectionReusableView {
        
        let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "DateHeader", for: indexPath) as! DateHeader
        header.monthLabel.text = OMSDateAccessor.getMonthDate(date: OMSDateAccessor.getFormatedDate(date: range.start))
        return header
    }
    
    //MARK: Selected Date
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        globalCurrentFullDate = date
        
        parentVC.dismiss()
    }
    
    @IBAction func backToTodayPressed(_ sender: Any) {
        globalCurrentFullDate = OMSDateAccessor().todaysFullDate
        
        parentVC.dismiss()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        DispatchQueue.main.async {
            self.datePicker.flashScrollIndicators()
        }
    }
    
}
