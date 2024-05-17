//
//  DataFile.swift
//  ApiwithShimmer
//
//  Created by Subhashini Chandranathan on 16/05/24.
//

import Foundation
struct sampleData : Codable {
    var albumId : Int?
    var id : Int?
    var title : String?
    var url : String?
    var thumbnailUrl : String?
  }

struct sampleData1 : Codable {
    var page : Int?
    var per_page : Int?
    var total : Int?
    var total_pages : Int?
    var data : [MultipleData]?
    var support : Support?
}
struct MultipleData : Codable{
    var id : Int?
    var email : String?
    var firstname : String?
    var lastname : String?
    var avatar : String?
}
struct Support : Codable{
    var url : String?
    var text : String?
}
