//
//  BotPlaylistCell.swift
//  YYApi_Voyo
//
//  Created by Stas Bezhan on 01.10.2022.
//

import UIKit

class BotPlaylistCell: UICollectionViewCell {

    @IBOutlet weak var viewsCount: UILabel!
    @IBOutlet weak var videoName: UILabel!
    @IBOutlet weak var videoImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        videoImage.image = .add
        
    }

}
