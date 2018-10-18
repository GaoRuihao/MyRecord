//
//  CalendarViewController.swift
//  MyRecord
//
//  Created by hao on 2018/10/18.
//  Copyright © 2018年 gaorhao. All rights reserved.
//

import UIKit

class CalendarViewController: BaseViewController {

    weak var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: view.width, height: 500))
        calendar.dataSource = self
        calendar.delegate = self
        view.addSubview(calendar)
        self.calendar = calendar
    }
}

extension CalendarViewController: FSCalendarDataSource, FSCalendarDelegate {
    
}
