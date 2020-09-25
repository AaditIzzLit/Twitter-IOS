//
//  TweetViewController.swift
//  Twitter
//
//  Created by Tanay Agrawal on 9/25/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var tweetTextView: UITextView!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var charCount: UILabel!
    var id : String!
    var details = [String:Any]()
    var arr = [String : Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tweetTextView.delegate = self
        tweetTextView.layer.cornerRadius = 20
        tweetTextView.layer.borderWidth = 2
        tweetTextView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
//        TwitterAPICaller.client?.getUserDetails(success: { (detail : [String : Any]) in
//            print (detail)
//            self.details = detail
//            print (self.details)
//        }, failure: { (Error) in
//            print(Error)
//        })
//        print(details)
//        id = (details["screen_name"] as! String)
//        TwitterAPICaller.client?.getImage(tweetId : id, success: { (img : [String : Any]) in
//            self.arr = img
//        }, failure: { (Error) in
//            print(Error)
//        })
//        if let imgURL = arr["profile_image_url_https"] as? String {
//            let imageUrl = URL(string: imgURL)
//            let data = try? Data(contentsOf : imageUrl!)
//
//            if let imageData = data {
//                profileImage.image = UIImage(data: imageData)
//            }
//        }
//        if let imgURL = arr["profile_image_url_https"] as? String {
//            let imageUrl = URL(string: imgURL)
//            profileImage.af_setImage(withURL: imageUrl!)
//        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet(_ sender: Any) {
        if (!tweetTextView.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (Error) in
                let alert = UIAlertController(title: "Error while posting tweet", message: "Please try again", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                    self.dismiss(animated: true, completion: nil)
                }))
            })
        } else {
                let alert = UIAlertController(title: "Tweet cannot be empty", message: "Please try again", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        tweetTextView.text = ""
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let characterLimit = 140
        let newText = NSString(string: tweetTextView.text!).replacingCharacters(in: range, with: text)
        charCount.text = "\(newText.count)"
        return newText.count < characterLimit
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
