//
//  Ext+CollectionView.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 28/08/2025.
//

import UIKit
import ViewAnimator

extension UICollectionView {
    
    func animateVisibleCellsin(section: Int,
                               animation: AnimationType,
                               duration: TimeInterval = 0.5) {
        let indexPaths = self.indexPathsForVisibleItems.filter{ $0.section == section }
        let cells = indexPaths.compactMap{ self.cellForItem(at: $0) }
        UIView.animate(views: cells,
                       animations: [animation],
                       duration: duration)
    }
}
