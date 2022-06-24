//
//  CollectionViewCell.swift
//  uplod File
//
//  Created by Ibrahim MOHAMMED on 14/11/1443 AH.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    var buttonAction : (() -> ())?
    
    
    
    @IBAction func deleteAcation(_ sender: Any) {
        
        buttonAction?()
        
    }
    
    
    @IBOutlet weak var signtuerImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
