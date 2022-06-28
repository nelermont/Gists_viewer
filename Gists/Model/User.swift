//
//  User.swift
//  Gists
//
//  Created by Дмитрий Подольский on 24.06.2022.
//

import Foundation

struct GistsRoot: Decodable {
    let owner: Owner
    let files: UnkownName
}

struct UnkownName: Decodable {
    var randomId: RandomID?
    struct RandomID: Decodable {
        let raw_url: String?
        let filename: String?
        
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        for key in container.allKeys {
            randomId = try? container.decode(RandomID.self, forKey: key)
        }
        print(container.allKeys)
    }
    struct CodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }
}


struct Owner: Codable {
    let login: String?
    let avatar_url: String?
}


//struct RawUrl: Decodable {
//    let raw_url:String?
//}
