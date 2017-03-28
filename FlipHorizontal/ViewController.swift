//
//  ViewController.swift
//  FlipHorizontal
//
//  Created by huan huan on 3/28/17.
//  Copyright © 2017 huan huan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let marginTop: CGFloat = 70.0
    var marginLeading: CGFloat = 50.0
    var myView = UIView()
    var temp = 100
    var arrView: [UIView] = [UIView]()
    var temp2 = 100
    var timerFlipFromLeft: Timer!
    var timerFlipFromRight: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.animate(withDuration: 1, animations: { 
            for indexRow in 0..<4 {
                for indexColum in 0..<4 {
                    self.setMyView()
                    
                    self.myView.tag = self.temp
                    self.myView.center = CGPoint(x: self.marginLeading + self.spaceBetweenCol()*CGFloat(indexColum)/CGFloat(4 - 1), y: self.marginTop + self.spaceBetweenRow()*CGFloat(indexRow)/CGFloat(4 - 1))
                    self.temp += 1
                    self.arrView.append(self.myView)
                }
            }
        }, completion: { (true) in
            self.startTimerFlipFromLeft()
        })
    }
    
    func startTimerFlipFromLeft() {
        self.timerFlipFromLeft = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.flipFromLeft), userInfo: nil, repeats: true)
    }
    
    func flipFromLeft() {
        
        for view in self.arrView {
            
            if view.tag == self.temp2 {
                UIView.transition(with: view, duration: 0.2, options: UIViewAnimationOptions.transitionFlipFromLeft, animations: {
                    view.backgroundColor = UIColor.gray
                }, completion: nil)
            }
        }
        if self.temp2 == 115 {
            timerFlipFromLeft.invalidate()
            timerFlipFromRight = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.flipFromRight), userInfo: nil, repeats: true)
        }
        temp2 += 1
        
    }
    
    func flipFromRight() {
        for view in arrView {
            if view.tag == self.temp2 - 1 {
                UIView.transition(with: view, duration: 0.2, options: UIViewAnimationOptions.transitionFlipFromRight, animations: {
                    view.backgroundColor = UIColor.black
                }, completion: nil)
            }
        }
        if temp2 == 101 {
            timerFlipFromRight.invalidate()
            startTimerFlipFromLeft()
        }
        temp2 -= 1
    }
    
    func spaceBetweenCol() -> CGFloat {
        return view.bounds.size.width - 2*marginLeading
    }
    
    func spaceBetweenRow() -> CGFloat {
        return view.bounds.size.height - 2*marginTop
    }
    
    func setMyView() {
        myView = UIView(frame: CGRect(x: 50.0, y: 50.0, width: 50.0, height: 50.0))
        myView.backgroundColor = UIColor.black
        myView.tag = 100
        view.addSubview(myView)
    }

}

