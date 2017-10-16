//
//  FirstViewController.swift
//  AtlanTeam Test
//
//  Created by Admin on 15.10.17.
//  Copyright © 2017 Sergey Artemyev. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var cardThreeStack: UIStackView!
    @IBAction func userSelection(_ sender: Any) {
        let selectedButton = sender as! UIButton
        if selectedButton.isSelected == true {
            selectedButton.isSelected = false
            UIView.animate(withDuration: 0.2) {
                for view in self.cardThreeStack.arrangedSubviews {
                    view.isHidden = false
                }
                (self.cardThreeStack.arrangedSubviews[5] as! UITextView).text = ""
                self.cardThreeStack.arrangedSubviews[5].isHidden = true
                self.cardThreeStack.distribution = .fillEqually
            }
        } else {
            selectedButton.isSelected = true
            UIView.animate(withDuration: 0.2) {
                for view in self.cardThreeStack.arrangedSubviews {
                    if view.tag != selectedButton.tag {
                        view.isHidden = true
                    }
                }
                (self.cardThreeStack.arrangedSubviews[5] as! UITextView).text = "grdgrdgrg"
                self.cardThreeStack.arrangedSubviews[5].isHidden = false
                self.cardThreeStack.distribution = .fill
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

