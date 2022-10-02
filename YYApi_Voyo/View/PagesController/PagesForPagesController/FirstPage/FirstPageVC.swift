//
//  FirstPageVC.swift
//  YYApi_Voyo
//
//  Created by Stas Bezhan on 01.10.2022.
//

import UIKit
import YoutubeKit

class FirstPageVC: UIViewController, Page {
    
    var uploadsPlaylist: [String]?
    
    @IBOutlet weak var channelSubscribers: UILabel!
    @IBOutlet weak var channelImage: UIImageView!
    @IBOutlet weak var channelName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        channelImage.layer.cornerRadius = 10
        channelImage.backgroundColor = .white
        setThumbNail()
    }
    
    internal func setThumbNail() {
        let fetchImageQueue = DispatchQueue(label: "ImageLoader", qos: .userInteractive, attributes: .concurrent)
        let manager = NetworkingManager()
        var data: Data = Data()
        manager.fetchPlaylists(with: "UCZU9T1ceaOgwfLRq7OKFU4Q", completion: { result in
            result.items.forEach { channel in
                fetchImageQueue.async { [weak self] in
                guard channel.snippet?.title != nil else { return }
                guard let url = URL(string: (channel.snippet?.thumbnails.high.url)!) else { return }
                    data = try! Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self?.channelImage.image = UIImage(data: data)
                        self?.channelName.text = channel.snippet!.title
                        self?.channelSubscribers.text = channel.statistics!.subscriberCount! + " подписчика"
                    }
                }
            }
        })
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
