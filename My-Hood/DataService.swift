//
//  DataService.swift
//  My-Hood
//
//  Created by Tony Merritt on 07/09/2016.
//  Copyright © 2016 Tony Merritt. All rights reserved.
//

import Foundation
import UIKit

class DataService {
    static let  instance = DataService()
    
    let KEY_POSTS = "posts"
    private var _loadedPosts = [Post]()
    
    var loadedPosts: [Post] {
        return _loadedPosts
    }
    
    func savePosts() {
        let postsData = NSKeyedArchiver.archivedDataWithRootObject(_loadedPosts)
        NSUserDefaults.standardUserDefaults().setObject(postsData, forKey: KEY_POSTS)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func loadPosts() {
         if let postsData = NSUserDefaults.standardUserDefaults().objectForKey(KEY_POSTS) as? NSData {
           
            if let postsArray = NSKeyedUnarchiver.unarchiveObjectWithData(postsData) as? [Post] {
                _loadedPosts = postsArray
            }
        }
    
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "postsLoaded", object: nil))
        
    }
    
    func saveImageAndCreatePath(image : UIImage) -> String {
       let imageData = UIImagePNGRepresentation(image)
        let imagePath = "image\(NSDate.timeIntervalSinceReferenceDate()).png"
        let fullPath = documentsPathforFileName(imagePath)
        imageData?.writeToFile(fullPath, atomically: true)
        return imagePath
        
    }
    
    func imageForPath(path: String) -> UIImage? {
        let fullPath = documentsPathforFileName(path)
        let image = UIImage(named: fullPath)
        return image
      
        
    }
    
    
    func addPost(post: Post) {
        _loadedPosts.append(post)
        savePosts()
        loadPosts()
    }
    
    
    
    func documentsPathforFileName(name: String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let fullPath = paths[0] as NSString
        return fullPath.stringByAppendingPathComponent(name)
    }
}