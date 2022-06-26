//
//  HomeDataModel.swift
//  MachineTestSampleApp
//
//  Created by ashik_h on 24/06/22.
//

import Foundation

struct HomeDataModel: Codable {
    var status: Bool?
    var homeData: [ItemTypeModel]?
    
    enum CodingKeys: String, CodingKey {
        case status
        case homeData
    }
    
    init(){
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        homeData = try values.decodeIfPresent([ItemTypeModel].self, forKey: .homeData)
    }
}

struct ItemTypeModel: Codable {
    var type: String?
    var itemDetails: [ItemDetailsModel]?
    
    enum CodingKeys: String, CodingKey {
        case type
        case itemDetails = "values"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        itemDetails = try values.decodeIfPresent([ItemDetailsModel].self, forKey: .itemDetails)
    }
}

struct ItemDetailsModel: Codable {
    var id: Int?
    var name: String?
    var image_url: String?
    var banner_url: String?
    var image: String?
    var actual_price: String?
    var offer_price: String?
    var offer: Int?
    var isExpress: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image_url
        case banner_url
        case image
        case actual_price
        case offer_price
        case offer
        case isExpress = "is_express"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
        banner_url = try values.decodeIfPresent(String.self, forKey: .banner_url)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        actual_price = try values.decodeIfPresent(String.self, forKey: .actual_price)
        offer_price = try values.decodeIfPresent(String.self, forKey: .offer_price)
        offer = try values.decodeIfPresent(Int.self, forKey: .offer)
        isExpress = try values.decodeIfPresent(Bool.self, forKey: .isExpress)
    }
}
