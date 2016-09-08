//
//  PostCell.swift
//  My-Hood
//
//  Created by Tony Merritt on 06/09/2016.
//  Copyright © 2016 Tony Merritt. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var postImage: UIImageView!

    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var descLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
       
        postImage.layer.cornerRadius = postImage.frame.size.width / 2
        postImage.clipsToBounds = true
        
    }

    
    func configureCell(post: Post) {
        titleView.text = post.title
        descLabel.text = post.postDesc
      postImage.image = DataService.instance.imageForPath(post.imagePath)
        
    }

}
