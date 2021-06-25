//
//  NetworkManager.swift
//  Test
//
//  Created by Sergey Starchenkov on 23.06.2021.
//

import Foundation
import Alamofire

protocol INetworkManager
{
    func fetchWeatherData(completion: @escaping (Result<WeatherApiResponse, Error>) -> Void)
}

final class NetworkManager: INetworkManager
{
    private init() {}
    static let instance = NetworkManager()
    
    private let url = "https://api.weather.yandex.ru/v2/forecast?lat=55.75396&lon=37.620393&limit=7&hours=true"
    private let key = "74eaffef-28c6-4abc-962a-9983c0fe5cff"
    
    func fetchWeatherData(completion: @escaping (Result<WeatherApiResponse, Error>) -> Void) {
        let headers: HTTPHeaders = ["X-Yandex-API-Key": key]
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: WeatherApiResponse.self) { response in
            switch (response.result) {
            case .success(let weather):
                completion(.success(weather))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
}
