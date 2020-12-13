//
//  ViewController.swift
//  LovelyDay
//
//  Created by Tielman Janse van Vuuren on 2020/12/13.
//

import UIKit


class ViewController: UIViewController {

    var refreshControl: UIRefreshControl?
    var scrollView: UIScrollView?

    override func viewDidLoad() {
        super.viewDidLoad()


        self.scrollView = UIScrollView(frame: UIScreen.main.bounds)
        self.refreshControl = UIRefreshControl()
        self.scrollView?.refreshControl = self.refreshControl
        self.scrollView?.backgroundColor = UIColor.green
        self.scrollView.flatMap{ self.view.addSubview($0)}
        // Do any additional setup after loading the view.

    }


}

