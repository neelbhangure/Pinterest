//
//  PinterestCollectionViewController.swift
//  Pinterest
//
//  Created by neelkant on 02/06/20.
//  Copyright © 2020 appscrip. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PinterestCollectionViewCell"


class PinterestCollectionViewController: UICollectionViewController {
    
    var pinterestViewModel = PinterestViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        pinterestViewModel.getImageList()
        pinterestViewModel.reloadData = {
            [weak self] in
            self?.collectionView.reloadData()
        }
    }
    

    fileprivate func setupCollectionView() {
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        collectionView.register(UINib(nibName: "PinterestCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.contentInset = UIEdgeInsets(top: 23, left:8, bottom: 10, right: 8)
    }
}

extension PinterestCollectionViewController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pinterestViewModel.listCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! PinterestCollectionViewCell
        cell.imageView.image = nil
        cell.imageDetails = pinterestViewModel.imageList[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
}

extension PinterestCollectionViewController: PinterestLayoutDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        let height = pinterestViewModel.imageList[indexPath.item].height / 10
        return CGFloat(integerLiteral: height)
    }
}
