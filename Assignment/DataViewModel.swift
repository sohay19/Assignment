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
    
    // 각 데이터리스트 전달
    func getTvList() -> [YSTv] {
        return tvList
    }
    func getRecommendList() -> [RecommendEvent] {
        return recommendList
    }
    func getNewEventList() -> [NewEvent] {
        return newEventList
    }
    // 서버에서 데이터 가져오기
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
    // 결과에서 데이터만 저장
    private func setData(_ data:Results) {
        tvList = data.ysTvList
        recommendList = data.recommendEventList
        newEventList = data.newEventList
    }
}
