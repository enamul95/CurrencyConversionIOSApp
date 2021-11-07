//
//  CurrencyResponse.swift
//  CurrencyConversionIOSApp
//
//  Created by Enamul Haque on 7/11/21.
//

import Foundation

struct CurrencyResponse : Codable {
  
    var success: Bool?
    var source : String?
    var quotes: [String:Double]?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case source = "source"
        case quotes = "quotes"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.success = try values.decodeIfPresent(Bool.self, forKey: .success)
        self.source = try values.decodeIfPresent(String.self, forKey: .source)
        self.quotes = try values.decodeIfPresent([String: Double].self , forKey: .quotes)
    }

}
