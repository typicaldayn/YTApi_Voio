//
//  Networking Manager.swift
//  YYApi_Voyo
//
//  Created by Stas Bezhan on 02.10.2022.
//

import Foundation
import YoutubeKit
import Combine
import UIKit

class NetworkingManager {
    
    private let queue: DispatchQueue = DispatchQueue(label: "Networking", qos: .userInteractive, attributes: .concurrent)
    
    func fetchPlaylists(with id: String, completion: @escaping (ChannelListRequest.Response) -> ()) {
        queue.async {
            let request = ChannelListRequest(part: [.snippet, .id, .statistics, .brandingSettings], filter: .id(id))
            YoutubeAPI.shared.send(request) { result in
                switch result {
                case .success(let response):
                    completion(response)
                case .failure(let error):
                    fatalError("\(error)")
                }
            }
        }
    }
    
    func fetchTopPlaylist(completion: @escaping (PlaylistItemsListRequest.Response) -> ()) {
        queue.async {
            let request = PlaylistItemsListRequest(part: [.contentDetails, .snippet, .status, .id], filter: .playlistID("PLMFUaRAk0WsYnHWedUMm1jdVn9TvznVnY"), maxResults: 10)
            YoutubeAPI.shared.send(request) { result in
                switch result {
                case .success(let response):
                    completion(response)
                case .failure(let error):
                    fatalError("\(error)")
                }
            }
        }
    }
    
}
