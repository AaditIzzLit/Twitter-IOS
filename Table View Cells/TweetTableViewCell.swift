//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Tanay Agrawal on 9/18/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var userContent: UILabel!
    @IBOutlet var tweetContent: UILabel!
    @IBOutlet var retweetButton: UIButton!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var retweet_count: UILabel!
    @IBOutlet var likes_count: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        retweet_count.sizeToFit()
        likes_count.sizeToFit()
    }
    var retweetCount = 0
    var likesCount = 0
    var favorited: Bool = false
    var tweetId : Int = -1
    var retweeted: Bool = false
    func setCount (_ count : Int) -> String{
        var num = count
        var str : String = ""
        if(count > 1000000) {
            num = (count / 1000000)
            str = "\(num)M"
        } else if(count > 1000) {
            num = (count / 1000)
            str = "\(num)K"
        } else {
            str = "\(num)"
        }
        return str
    }
    @IBAction func retweet(_ sender: Any) {
        if(retweeted == false) {
            retweetCount += 1
            TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
                self.setRetweeted(true, self.retweetCount)
            }, failure: { (Error) in
                print("Error")
            })
        } else {
            retweetCount -= 1
            TwitterAPICaller.client?.unretweet(tweetId: tweetId, success: {
                self.setRetweeted(false, self.retweetCount)
            }, failure: { (Error) in
                print("Error")
            })
        }
        
    }
    
    func setFavorite (_ isFavorited:Bool,_ count: Int) {
        favorited = isFavorited
        likes_count.text = setCount(likesCount)
        if(favorited == true) {
            likeButton.setImage(UIImage(named:"heart"), for: UIControl.State.normal)
        } else  {
            likeButton.setImage(UIImage(named:"empty_heart"), for: UIControl.State.normal)
        }
    }
    @IBAction func like(_ sender: Any) {
        let toBeFavorited = !favorited
    
        if(toBeFavorited) {
            likesCount += 1
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true,  self.likesCount)
            }, failure: { (Error) in
                print("Error")
            })
        } else {
            likesCount -= 1
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false, self.likesCount)
            }, failure: { (Error) in
                print("Error")
            })
        }
        
    }
    
    func setRetweeted (_ isRetweeted:Bool, _ count: Int) {
        retweeted = isRetweeted
        retweet_count.text = setCount(retweetCount)
        if(retweeted) {
             retweetButton.setImage(UIImage(named:"retweeted"), for: UIControl.State.normal)
        } else {
             retweetButton.setImage(UIImage(named:"retweet"), for: UIControl.State.normal)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
