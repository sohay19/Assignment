//
//  LoadData.swift
//  Assignment
//
//  Created by 소하 on 2023/02/16.
//

import Foundation


struct LoadData:Decodable {
    let serverCode:String
    let serverMsg:String
    let results:Results
}

struct Results:Decodable {
    let displayTagList:[Tag]
    let bannerList:[Banner]
    let recommendEventList:[RecommendEvent]
    let newEventList:[NewEvent]
    let ysTvList:[YSTv]
}
