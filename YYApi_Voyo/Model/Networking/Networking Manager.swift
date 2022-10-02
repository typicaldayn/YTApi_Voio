//
//  Networking Manager.swift
//  YYApi_Voyo
//
//  Created by Stas Bezhan on 02.10.2022.
//

import Foundation
import YoutubeKit

class NetworkingManager {
    
    func fetchPlaylists(completion: @escaping (ChannelListRequest.Response) -> ()) {
        let req = ChannelListRequest(part: [.snippet, .id, .statistics], filter: .userName("CodeWithChris"))
            YoutubeAPI.shared.send(req) { result in
                switch result {
                case .success(let response):
                    completion(response)
                case .failure(let error):
                    fatalError("\(error)")
            }
        }
    }
    
}
