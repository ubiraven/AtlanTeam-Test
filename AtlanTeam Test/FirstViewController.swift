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
            UIView.animate(withDuration: 0.2) {
                selectedButton.isSelected = false
                self.cardThreeStack.arrangedSubviews[0].isHidden = false
                self.cardThreeStack.arrangedSubviews[2].isHidden = false
                self.cardThreeStack.arrangedSubviews[3].isHidden = false
                self.cardThreeStack.arrangedSubviews[4].isHidden = false
                (self.cardThreeStack.arrangedSubviews[5] as! UITextView).text = ""
                self.cardThreeStack.arrangedSubviews[5].isHidden = true
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                (self.cardThreeStack.arrangedSubviews[1] as! UIButton).isSelected = true
                self.cardThreeStack.arrangedSubviews[0].isHidden = true
                self.cardThreeStack.arrangedSubviews[2].isHidden = true
                self.cardThreeStack.arrangedSubviews[3].isHidden = true
                self.cardThreeStack.arrangedSubviews[4].isHidden = true
                (self.cardThreeStack.arrangedSubviews[5] as! UITextView).text = "efefefefefefefefefefefefefefefefefefefefefefefefefefefefefefefefefefefefnvnvvcxbvnxbvsjfeopfe"
                self.cardThreeStack.arrangedSubviews[5].isHidden = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cardThreeStack.arrangedSubviews[5].isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

