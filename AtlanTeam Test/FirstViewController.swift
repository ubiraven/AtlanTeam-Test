//
//  FirstViewController.swift
//  AtlanTeam Test
//
//  Created by Admin on 15.10.17.
//  Copyright © 2017 Sergey Artemyev. All rights reserved.
//

import UIKit
import SDWebImage
import AFNetworking
//https://jsonplaceholder.typicode.com

class FirstViewController: UIViewController, UITextFieldDelegate {
   
    
    @IBOutlet var fields: [UITextField]!
    @IBOutlet var textViews: [UITextView]!    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cardThreeStack: UIStackView!
    
    //var data: Dictionary<Int, Array<NSDictionary>>
    let characters = CharacterSet(charactersIn: "0123456789")
    let requestOperationManager: AFHTTPRequestOperationManager = AFHTTPRequestOperationManager.init(
        baseURL: URL.init(string: "https://jsonplaceholder.typicode.com"))
    
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
        
        
        for field in fields {
            field.delegate = self
        }
        let imageURL = URL.init(string: "https://placehold.it/600/24f355")
        imageView.sd_setImageWithPreviousCachedImage(with: imageURL, placeholderImage: nil, options: SDWebImageOptions.lowPriority, progress: { (receivedSize: Int, expectedSize: Int) in
        }, completed: { (image: UIImage?, error: Error?, cacheType: SDImageCacheType, imageURL: URL?) in
        })
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "" {
            return true
        }
        if string.rangeOfCharacter(from: characters) != nil {
            if textField.text!.count >= 3 {
                return false
            } else {
                return true
            }
        } else {
            return false
        }
    }

}

