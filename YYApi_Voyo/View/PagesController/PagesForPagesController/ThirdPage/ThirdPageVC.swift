//
//  ThirdPageVC.swift
//  YYApi_Voyo
//
//  Created by Stas Bezhan on 01.10.2022.
//

import UIKit

class ThirdPageVC: UIViewController, Page {

    @IBOutlet weak var channelName: UILabel!
    @IBOutlet weak var channelSubscribers: UILabel!
    @IBOutlet weak var channelImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        channelImage.layer.cornerRadius = 10
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
