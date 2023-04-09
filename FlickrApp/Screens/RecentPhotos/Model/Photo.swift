import Foundation

struct Photo: Codable {
    let id, owner, secret, server: String?
    let farm: Int?
    let title: String?
    let ispublic, isfriend, isfamily: Int?
    let description: Description?
    let ownername, iconserver: String?
    let iconfarm: Int?
    let urlN: String?
    let heightN, widthN: Int?
    let urlZ: String?
    let heightZ, widthZ: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, owner, secret, server, farm, title, ispublic, isfriend, isfamily, description, ownername, iconserver, iconfarm
        case urlN = "url_n"
        case heightN = "height_n"
        case widthN = "width_n"
        case urlZ = "url_z"
        case heightZ = "height_z"
        case widthZ = "width_z"
    }
}

// MARK: - Description
struct Description: Codable {
    let content: String
    
    enum CodingKeys: String, CodingKey {
        case content = "_content"
    }
}

// MARK: - URL BuddyIcon
extension Photo {
    var buddyIconURL: String {
        
        if let iconServer = iconserver,
           let iconFarm = iconfarm,
           let nsId = owner,
           NSString(string: iconServer).intValue > 0 {
            return "http://farm\(iconFarm).staticflickr.com/\(iconServer)/buddyicons/\(nsId).jpg"
        }else {
            return "https://www.flickr.com/images/buddyicon.gif"
        }
    }
}




