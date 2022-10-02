//
//  Networking Manager.swift
//  YYApi_Voyo
//
//  Created by Stas Bezhan on 02.10.2022.
//

import Foundation
import YoutubeKit
import Combine

class NetworkingManager {
    
    private let queue: DispatchQueue = DispatchQueue(label: "Networking", qos: .userInteractive, attributes: .concurrent)
    
    func fetchPlaylists(with id: String, completion: @escaping (ChannelListRequest.Response) -> ()) {
        let workItem = DispatchWorkItem {
            let req = ChannelListRequest(part: [.snippet, .id, .statistics, .brandingSettings], filter: .id(id))
            YoutubeAPI.shared.send(req) { result in
                switch result {
                case .success(let response):
                    completion(response)
                case .failure(let error):
                    fatalError("\(error)")
                    
                }
            }
            
        }
        queue.async(execute: workItem)
    }
    
}
