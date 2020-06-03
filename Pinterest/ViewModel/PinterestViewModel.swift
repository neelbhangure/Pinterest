//
//  PinterestViewModel.swift
//  Pinterest
//
//  Created by neelkant on 02/06/20.
//  Copyright © 2020 appscrip. All rights reserved.
//

import Foundation

class PinterestViewModel {
    
    /// Clouser to be called when data is retrieved from asynchronus call to update the view.
    var reloadData : (() -> ())?
    /// array of  ImageData instances
    var imageList = [ImageData]()
    /// image array count
    var listCount : Int {
        get {
            return  imageList.count
        }
    }
    /**
    Get json image list array.

    - Parameter completion: closure which excutes with error as parameter on completion of asynchronus call.

    */
    func getImageList(completion :  ((Error?) -> ())? = nil) {
        
        ImageAPI.shared.getImageList(successHandler: { [weak self] (list) in
             
            self?.imageList = list
            if let reloadData = self?.reloadData {
                reloadData()
            }
        }) { (err) in
            completion?(err)
            // handle error
        }
    }
}
