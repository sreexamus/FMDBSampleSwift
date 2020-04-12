//
//  ViewController.swift
//  FMDBSampleSwift
//
//  Created by sreekanth reddy iragam reddy on 4/11/20.
//  Copyright © 2020 com.test.fmdb.sqllite. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let analytics = AnalyticsData()
    override func viewDidLoad() {
        super.viewDidLoad()
        analytics.inset(row: EventsData(eventname: "ScreenVC", attributes: "viewDidLoad", timestamp: Date()))
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

