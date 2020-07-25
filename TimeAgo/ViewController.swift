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
        print(self.dateForComponents { $0.second = -1 }!.formatDateAsTimeAgo())
        print(self.dateForComponents { $0.month = -1 }!.formatDateAsTimeAgo())
        print(self.dateForComponents { $0.year = -1 }!.formatDateAsTimeAgo())
        print(self.dateForComponents { $0.second = +1 }!.formatDateAsTimeAgo())
        print(self.dateForComponents { $0.month = +1 }!.formatDateAsTimeAgo())
        print(self.dateForComponents { $0.year = +1 }!.formatDateAsTimeAgo())
        print(self.dateForComponents { $0.second = +2 }!.formatDateAsTimeAgo())
        print(self.dateForComponents { $0.month = +2 }!.formatDateAsTimeAgo())
        print(self.dateForComponents { $0.year = +2 }!.formatDateAsTimeAgo())
        print(self.dateForComponents { $0.second = +3 }!.formatDateAsTimeAgo())
        print(self.dateForComponents { $0.month = +3 }!.formatDateAsTimeAgo())
        print(self.dateForComponents { $0.year = +3 }!.formatDateAsTimeAgo())

        
    }

    func dateForComponents(block: (_ components: inout DateComponents) -> Void) -> Date? {
        let calander = Calendar.current
        var components = DateComponents()
        block(&components)
        return calander.date(byAdding: components, to: Date())
    }


}

