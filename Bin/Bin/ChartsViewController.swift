//
//  ChartsViewController.swift
//  Bin
//
//  Created by Mike Choi on 2/24/19.
//  Copyright © 2019 Mike JS. Choi. All rights reserved.
//

import UIKit

class ChartsViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StatCell", for: indexPath) as? ChartCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setup(index: indexPath)
        return cell
    }
}
