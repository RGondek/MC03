//
//  ViewController02.swift
//  MC03
//
//  Created by Rubens Gondek on 5/22/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import UIKit

class ViewController02: UIViewController {
    @IBOutlet var pageView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func btnEasy(sender: UIButton) {
        println("EASY!!")
        self.presentViewController(GameViewController(), animated: true, completion: nil)
    }
    @IBAction func btnMedium(sender: UIButton) {
        lblText.text = ("MEDIUM!!")
    }
    @IBAction func btnHard(sender: UIButton) {
        lblText.text = ("HARD!!")
    }
    
    @IBAction func book1Click(sender: UIButton) {
        let btn = sender as UIButton
        lblTitle.text = (btn.titleForState(UIControlState.Normal))
        UIView.animateWithDuration(0.7, animations: { () -> Void in
            self.pageView.alpha = 1
            self.pageView.transform = CGAffineTransformMakeTranslation(0, 175)
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
