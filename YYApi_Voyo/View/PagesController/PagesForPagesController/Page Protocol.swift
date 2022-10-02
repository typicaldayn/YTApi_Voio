//
//  Page Protocol.swift
//  YYApi_Voyo
//
//  Created by Stas Bezhan on 02.10.2022.
//

import Foundation
import UIKit

protocol Page: UIViewController {
    var channelSubscribers: UILabel! { get set }
    var channelImage: UIImageView! { get set }
    var channelName: UILabel! { get set }
}
