//
//  DataViewModel.swift
//  Assignment
//
//  Created by 소하 on 2023/02/16.
//

import Foundation


class DataViewModel {
    private var tvList:[YSTv] = []
    private var recommendList:[RecommendEvent] = []
    private var newEventList:[NewEvent] = []
    
    func getTvList() -> [YSTv] {
        return tvList
    }
    
    func getRecommendList() -> [RecommendEvent] {
        return recommendList
    }
    
    func getNewEventList() -> [NewEvent] {
        return newEventList
    }
    
    func getData(url:URL, completaion: @escaping(() -> Void)) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error")
                return
            }
            guard let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                print("request is failed")
                return
            }
            guard let data = data else {
                print("data is nil")
                return
            }
            if let loadData = try? JSONDecoder().decode(LoadData.self, from: data) {
                self.setData(loadData.results)
                completaion()
            }
        }.resume()
    }
    
    private func setData(_ data:Results) {
        tvList = data.ysTvList
        recommendList = data.recommendEventList
        newEventList = data.newEventList
    }
}
