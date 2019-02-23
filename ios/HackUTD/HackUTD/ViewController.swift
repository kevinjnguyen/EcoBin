//
//  ViewController.swift
//  HackUTD
//
//  Created by Kevin J Nguyen on 2/23/19.
//  Copyright © 2019 Kevin J Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let recycle_rep = RecycleRepository.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        do {
            try recycle_rep.sendTestEcho()
        } catch {
            print("error")
        }
    }

    @IBAction func didPressRecycle(_ sender: Any) {
        do {
            try recycle_rep.shouldRecycle()
        } catch {
            print("error")
        }
    }
    
    @IBAction func didPressLandfill(_ sender: Any) {
        do {
            try recycle_rep.shouldLandfill()
        } catch {
            print("error")
        }
    }
    @IBAction func didPressCompost(_ sender: Any) {
        do {
            try recycle_rep.shouldCompost()
        } catch {
            print("error")
        }
    }
    @IBAction func didPressReject(_ sender: Any) {
        do {
            try recycle_rep.shouldReject()
        } catch {
            print("error")
        }
    }
}

