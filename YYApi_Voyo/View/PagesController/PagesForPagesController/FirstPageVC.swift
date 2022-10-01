//
//  FirstPageVC.swift
//  YYApi_Voyo
//
//  Created by Stas Bezhan on 01.10.2022.
//

import UIKit

class FirstPageVC: UIViewController {

    @IBOutlet weak var subscribersLabel: UILabel!
    @IBOutlet weak var channelBannerImage: UIImageView!
    @IBOutlet weak var channelName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        channelBannerImage.layer.cornerRadius = 10
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
