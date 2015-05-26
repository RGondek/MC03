//
//  ViewController02.swift
//  MC03
//
//  Created by Rubens Gondek on 5/22/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import UIKit

class ViewController02: UIViewController {
    @IBOutlet var pageView1: UIView!
    
    @IBOutlet weak var pageView2: UIView!
    
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
        lblText.text = ("EASY!!")
        switch (sender.tag){
        case 0:
            let gameView = self.storyboard?.instantiateViewControllerWithIdentifier("gameView") as! GameViewController
            self.presentViewController(gameView, animated: true, completion: nil)
        case 1:
            println("Game 2")
        default:
            println("Another Game")
        }
    }
    @IBAction func btnMedium(sender: UIButton) {
        lblText.text = ("MEDIUM!!")
        switch (sender.tag){
        case 0:
            let gameView = self.storyboard?.instantiateViewControllerWithIdentifier("gameView") as! GameViewController
            self.presentViewController(gameView, animated: true, completion: nil)
        case 1:
            println("Game 2")
        default:
            println("Another Game")
        }
    }
    @IBAction func btnHard(sender: UIButton) {
        lblText.text = ("HARD!!")
        switch (sender.tag){
        case 0:
            let gameView = self.storyboard?.instantiateViewControllerWithIdentifier("gameView") as! GameViewController
            self.presentViewController(gameView, animated: true, completion: nil)
        case 1:
            println("Game 2")
        default:
            println("Another Game")
        }
    }
    
    @IBAction func book1Click(sender: UIButton) {
        let btn = sender as UIButton
        if self.pageView1.alpha == 0 {
            lblTitle.text = (btn.titleForState(UIControlState.Normal))
            UIView.animateWithDuration(0.7, animations: { () -> Void in
                self.pageView1.alpha = 1
                self.pageView1.transform = CGAffineTransformMakeTranslation(0, 175)
            })
        }
        else {
            lblTitle.text = (btn.titleForState(UIControlState.Normal))
            UIView.animateWithDuration(0.7, animations: { () -> Void in
                self.pageView1.alpha = 0
                self.pageView1.transform = CGAffineTransformMakeTranslation(0, 0)
            })
        }
    }
    
    @IBAction func book2Click(sender: UIButton) {
        let btn = sender as UIButton
        if self.pageView2.alpha == 0 {
            lblTitle.text = (btn.titleForState(UIControlState.Normal))
            UIView.animateWithDuration(0.7, animations: { () -> Void in
                self.pageView2.alpha = 1
                self.pageView2.transform = CGAffineTransformMakeTranslation(0, 175)
            })
        }
        else {
            lblTitle.text = (btn.titleForState(UIControlState.Normal))
            UIView.animateWithDuration(0.7, animations: { () -> Void in
                self.pageView2.alpha = 0
                self.pageView2.transform = CGAffineTransformMakeTranslation(0, 0)
            })
        }
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
