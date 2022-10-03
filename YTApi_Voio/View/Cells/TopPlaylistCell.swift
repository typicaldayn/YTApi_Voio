//
//  TopPlaylistCell.swift
//  YYApi_Voyo
//
//  Created by Stas Bezhan on 01.10.2022.
//

import UIKit

class TopPlaylistCell: UICollectionViewCell {

    @IBOutlet weak var viewsCount: UILabel!
    @IBOutlet weak var videoName: UILabel!
    @IBOutlet weak var videoImage: UIImageView!
    
    var views: String = ""
    var image: UIImage?
    var title: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewsCount.text = views
        videoName.text = title
    }

}
