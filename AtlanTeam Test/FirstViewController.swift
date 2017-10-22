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

enum FieldNames: String {
    case userId, id, title, body, postId, name, email, completed, username, phone, website, address, street, suite, city, zipcode, geo, lat, lng, company, catchPhrase, bs, url
}
extension NSDictionary {
    subscript(_ field: FieldNames) -> Any? {
        return self.object(forKey: field.rawValue)
    }
    subscript(_ fields: FieldNames...) -> Any? {
        var result = self
        var i = 0
        while let object = result.object(forKey: fields[i].rawValue) as? NSDictionary {
            result = object
            i += 1
            if i >= fields.count  {
                break
            }
        }
        return result
    }
}

class FirstViewController: UIViewController, UITextFieldDelegate {
   
    enum BaseURL: String {
        case posts = "https://jsonplaceholder.typicode.com/posts"
        case comments = "https://jsonplaceholder.typicode.com/comments"
        case users = "https://jsonplaceholder.typicode.com/users"
        case photo = "https://jsonplaceholder.typicode.com/photos/3"
        case todos = "https://jsonplaceholder.typicode.com/todos"
    }
    enum Section: Int {
        case posts = 1
        case comments = 2
        case users = 3
        case photo = 4
        case todos = 5
    }
    
    
    @IBOutlet var fields: [UITextField]!
    @IBOutlet var textViews: [UITextView]!    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cardThreeStack: UIStackView!
    
    @IBOutlet var cardThreeButtons: [UIButton]!
    var data: Dictionary<Int, Array<NSDictionary>> = [0: Array()]
    let characters = CharacterSet(charactersIn: "0123456789")
    let requestOperationManager: AFHTTPRequestOperationManager = AFHTTPRequestOperationManager.init(
        baseURL: URL.init(string: "https://jsonplaceholder.typicode.com"))
    
    @IBAction func clearKeyboard(_ sender: Any) {
        for field in fields {
            if field.isFirstResponder == true {
                field.resignFirstResponder()
            }
        }
    }
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
                let tag = selectedButton.tag % 100 - 1
                let data = self.data[3]![tag]
                let text = self.composeTextFrom(data, keysOrder:
                                  FieldNames.id.rawValue,
                                  FieldNames.name.rawValue,
                                  FieldNames.username.rawValue,
                                  FieldNames.email.rawValue) + "\n" +
                                  FieldNames.address.rawValue + ":\n" +
                           self.composeTextFrom(data[FieldNames.address] as! NSDictionary, keysOrder:
                                  FieldNames.street.rawValue,
                                  FieldNames.suite.rawValue,
                                  FieldNames.city.rawValue,
                                  FieldNames.zipcode.rawValue) + "\n" +
                                  FieldNames.geo.rawValue + ":\n" +
                           self.composeTextFrom(data[FieldNames.address,FieldNames.geo] as! NSDictionary, keysOrder:
                                  FieldNames.lat.rawValue,
                                  FieldNames.lng.rawValue) + "\n" +
                           self.composeTextFrom(data, keysOrder:
                                  FieldNames.phone.rawValue,
                                  FieldNames.website.rawValue) + "\n" +
                                  FieldNames.company.rawValue + ":\n" +
                           self.composeTextFrom(data[FieldNames.company] as! NSDictionary, keysOrder:
                                  FieldNames.name.rawValue,
                                  FieldNames.catchPhrase.rawValue,
                                  FieldNames.bs.rawValue)
                //let text = String.init(describing: data)
                (self.cardThreeStack.arrangedSubviews[5] as! UITextView).text = text
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
        
        let usersURL = BaseURL.users.rawValue
        requestOperationManager.get(usersURL, parameters: nil, success: { (operation, responseObject) in
            //print(responseObject)
            self.updateDataForSection(.users, withElement: responseObject as! Array<NSDictionary>)
        }) { (operation, error) in
            
        }
        let toDosURL = BaseURL.todos.rawValue + "/" + String(arc4random_uniform(200) + 1)
        requestOperationManager.get(toDosURL, parameters: nil, success: { (operation, responseObject) in
            //print(responseObject)
            self.updateDataForSection(.todos, withElement: Array.init(arrayLiteral: responseObject as! NSDictionary))
        }) { (operation, error) in
            
        }
        let photoURL = BaseURL.photo.rawValue
        requestOperationManager.get(photoURL, parameters: nil, success: { (operation, responseObject) in
            self.updateDataForSection(.photo, withElement: Array.init(arrayLiteral: responseObject as! NSDictionary))
        }) { (opration, error) in
            
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateDataForSection(_ section: Section, withElement: Array<NSDictionary>) {
        data.updateValue(withElement, forKey: section.rawValue)
        switch section.rawValue {
        case 1,2,5:
            let data = self.data[section.rawValue]![0]
            let textViewTag = section.rawValue * 100 + 3
            switch textViewTag {
            case 103:
                for textView in textViews {
                    if textView.tag == textViewTag {
                        textView.text = composeTextFrom(data, keysOrder: FieldNames.userId.rawValue,FieldNames.id.rawValue,FieldNames.title.rawValue,FieldNames.body.rawValue)
                    }}
            case 203:
                for textView in textViews {
                    if textView.tag == textViewTag {
                        textView.text = composeTextFrom(data, keysOrder: FieldNames.postId.rawValue,FieldNames.id.rawValue,FieldNames.name.rawValue,FieldNames.email.rawValue,FieldNames.body.rawValue)
                    }}
            case 503:
                for textView in textViews {
                    if textView.tag == textViewTag {
                        textView.text = composeTextFrom(data, keysOrder: FieldNames.userId.rawValue,FieldNames.id.rawValue,FieldNames.title.rawValue,FieldNames.completed.rawValue)
                    }}
            default:
                break
            }
        case 3:
            let data = self.data[3]!
            for button in cardThreeButtons {
                switch button.tag {
                case 301:
                    button.setTitle(data[0][FieldNames.username] as? String, for: UIControlState.normal)
                case 302:
                    button.setTitle(data[1][FieldNames.username] as? String, for: UIControlState.normal)
                case 303:
                    button.setTitle(data[2][FieldNames.username] as? String, for: UIControlState.normal)
                case 304:
                    button.setTitle(data[3][FieldNames.username] as? String, for: UIControlState.normal)
                case 305:
                    button.setTitle(data[4][FieldNames.username] as? String, for: UIControlState.normal)
                default:
                    break
                }
            }
        case 4:
            let photoURL = data[4]![0][FieldNames.url] as! String
            let _photoURL = photoURL.replacingOccurrences(of: "http", with: "https")
            let url = URL.init(string: _photoURL)
            imageView.sd_setImageWithPreviousCachedImage(with: url, placeholderImage: nil, options: SDWebImageOptions.lowPriority, progress: { (receivedSize: Int, expectedSize: Int) in
            }, completed: { (image: UIImage?, error: Error?, cacheType: SDImageCacheType, imageURL: URL?) in
            })
        default:
            break
        }
    }
    func composeTextFrom(_ dictionary: NSDictionary, keysOrder: String...) -> String {
        func convertIntoText(_ value: Any) -> String {
            var text = ""
            if let value = value as? Bool {
                if value == true {
                    text = "true"
                } else {
                    text = "false"
                }
            } else if let value = value as? String {
                text = value
            } else if let value = value as? Int {
                text = String(describing: value)
            }
            return text
        }
        var text: String = ""
        for key in keysOrder {
            if let value = dictionary.object(forKey: key) {
                text.append(key + ": " + convertIntoText(value) + "\n")
            }
        }
        let _text = String(text.dropLast())
        return _text
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text != nil {
            var number = Int(textField.text!)
            if number == 0 {
                textField.text = "1"
                number = 1
            }
            switch textField.tag {
            case 101:
                if number! > 100 {
                    textField.text = "100"
                    number = 100
                }
                let postsURL = BaseURL.posts.rawValue + "/" + textField.text!
                requestOperationManager.get(postsURL, parameters: nil, success: { (operation, responseObject) in
                    //print(responseObject)
                    self.updateDataForSection(.posts, withElement: Array.init(arrayLiteral: responseObject as! NSDictionary))
                }, failure: { (operation, error) in
                    
                })
            case 201:
                if number! > 500 {
                    textField.text = "500"
                    number = 500
                }
                let commentsURL = BaseURL.comments.rawValue + "/" + textField.text!
                requestOperationManager.get(commentsURL, parameters: nil, success: { (operation, responseObject) in
                    //print(responseObject)
                    self.updateDataForSection(.comments, withElement: Array.init(arrayLiteral: responseObject as! NSDictionary))
                }, failure: { (operation, error) in
                    
                })
            default:
                break
            }
            return true
        } else {
            return false
        }
    }
}

