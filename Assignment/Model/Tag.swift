//
//  Tag.swift
//  Assignment
//
//  Created by 소하 on 2023/02/16.
//

import Foundation

struct Tag:Decodable {
    let id:Int?
    let tagId:String?
    let tagName:String
    let tagLink:String
    let tagRank:Int
    let createAdminId:Int
    let updateAdminId:Int
    let createAt:String
    let updatedAt:String
}
