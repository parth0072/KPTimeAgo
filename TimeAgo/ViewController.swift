//
//  ViewController.swift
//  TimeAgo
//
//  Created by Parth on 20/07/20.
//  Copyright © 2020 Parth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Date().formatDateAsTimeAgo())
        print(self.dateForComponents { $0.second = +1 }!.formatDateAsTimeAgo())
        print(self.dateForComponents { $0.month = +1 }!.formatDateAsTimeAgo())
        print(self.dateForComponents { $0.year = +1 }!.formatDateAsTimeAgo())
        print(self.dateForComponents { $0.second = +2 }!.formatDateAsTimeAgo())
        print(self.dateForComponents { $0.month = +2 }!.formatDateAsTimeAgo())
        print(self.dateForComponents { $0.year = +2 }!.formatDateAsTimeAgo())
        print(self.dateForComponents { $0.second = +3 }!.formatDateAsTimeAgo())
        print(self.dateForComponents { $0.month = +3 }!.formatDateAsTimeAgo())
        print(self.dateForComponents { $0.year = +3 }!.formatDateAsTimeAgo())
        
        ///Custom Format
        print("######### Custom Format #########")
        timeAgoWithCustomFormat()
    }
    
    //////######### Custom Format #########
    ///August 9, 2026

    func timeAgoWithCustomFormat() {
        let timeAgo = KPTimeAgo.init(date: self.dateForComponents { $0.year = +6 }!, yesterdayFormat: nil, lastWeekFormat: nil, lastMonthFormat: nil, otherFormat: "LLLL d, yyyy")
        print(timeAgo.formatDateAsTimeAgo())
    }

    func dateForComponents(block: (_ components: inout DateComponents) -> Void) -> Date? {
        let calander = Calendar.current
        var components = DateComponents()
        block(&components)
        return calander.date(byAdding: components, to: Date())
    }


}

