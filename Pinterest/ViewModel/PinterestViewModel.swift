//
//  PinterestViewModel.swift
//  Pinterest
//
//  Created by neelkant on 02/06/20.
//  Copyright © 2020 appscrip. All rights reserved.
//

import Foundation

class PinterestViewModel {
    var reloadData : (() -> ())?
    var imageList = [ImageData]()
    var listCount : Int {
        get {
            return  imageList.count
        }
    }
    
    func getImageList(completion :  ((Error?) -> ())? = nil) {
        
        ImageAPI.shared.getImageList(successHandler: { [weak self] (list) in
            
            
//            self?.imageList = list
            if let reloadData = self?.reloadData {
                reloadData()
                
            }
        }) { (err) in
           
            completion?(err)
            
        }
    }
}
