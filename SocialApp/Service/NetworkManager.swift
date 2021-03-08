//
//  NetworkManager.swift
//  SocialApp
//
//  Created by Иван Казанцев on 26.02.2021.
//

import Foundation
import Alamofire
import SwiftyJSON


class NetworkManager {
    
    //MARK: BASE PARAMETERS
    let baseUrl = "https://api.vk.com"
    static let shared = NetworkManager()
    static let session: Session = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.waitsForConnectivity = true
        let session = Session(configuration: config)
        return session
    }()
    
    //MARK: LOGGING VIA VK / GETTING USER_ID AND ACCESS_TOKEN
    func networking() -> URLRequest {
    var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7773464"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "notify, friends, photos, audio, video, stories, pages, status, notes, wall, adds, offline, docs, groups, notification, stats, email"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
    
        return URLRequest(url: urlComponents.url!)
    }
    
    //MARK: GETTING FRIENDS FROM VK API BY USER_ID AND ACCESS_TOKEN
    func loadFriends() {
        let path = "/method/friends.get"
        guard let userId = AppSession.instance.userId else { preconditionFailure("Empty user_id") }
        guard let token = AppSession.instance.token else { preconditionFailure("Empty access_token") }
        var parameters: Parameters = [
            "user_ids" : userId,
            "order" : "name",
            "fields" : "photo_200, is_friend",
            "access_token" : token,
            "v" : "5.68"
        ]
        parameters.forEach { (k,v) in parameters[k] = v }
        let url = baseUrl.self + path
        DispatchQueue.global().async {
            AF.request(url, parameters: parameters).responseData { response in
                guard let data = response.value else { return }
                let json = JSON(data)
                let usersJSONs = json["response"]["items"].arrayValue
                print(usersJSONs)
            }
        }
    }
    
    func loadNews() {
        let path = "/method/newsfeed.get"
        guard let userId = AppSession.instance.userId else { preconditionFailure("Empty user_id") }
        guard let token = AppSession.instance.token else { preconditionFailure("Empty access_token") }
        var parameters: Parameters = [
            "user_ids" : userId,
            "fields" : "photo_200, is_friend",
            "filters" : "post",
            "counts" : 10,
            "access_token" : token,
            "v" : "5.103"
        ]
        parameters.forEach { (k,v) in parameters[k] = v }
        let url = baseUrl.self + path
        DispatchQueue.global().async {
        AF.request(url, parameters: parameters).responseData { response in
            switch response.result {
            case .success(let value):
                let newsDispatchGroup = DispatchGroup()
                var news = [News]()
                var groups = [Group]()
                var profiles = [User]()
                var nextFrom: String = ""
                let json = JSON(value)
                DispatchQueue.global().async(group: newsDispatchGroup){
                    let newsJSONs = json["response"]["items"].arrayValue
                    news = newsJSONs.map {News($0)}
                }
                DispatchQueue.global().async(group: newsDispatchGroup){
                    let groupsJSONs = json["response"]["groups"].arrayValue
                    groups = groupsJSONs.map {Group($0)}
                }
                DispatchQueue.global().async(group: newsDispatchGroup) {
                    let profilesJSONs = json["response"]["profiles"].arrayValue
                    profiles = profilesJSONs.map {User($0)}
                }
                DispatchQueue.global().async {
                    nextFrom = json["response"]["next_from"].stringValue
                }
                newsDispatchGroup.notify(queue: .main){
                    let result = Alamofire.AFResult<(news: [News], users: [User], groups: [Group], nextFrom: String)>.success((news, profiles, groups, nextFrom))
                    print(result)
                }
            case .failure(let error):
                print(error)
                let result = Alamofire.AFResult<(news: [News], users: [User], groups: [Group], nextFrom: String)>.failure(error)
                print(result)
            }
        }
        }
    }
    
    func loadVideo(owner_id: Int? = nil, id: Int? = nil, completion: @escaping ([Video]) -> Void){
        let path = "/method/video.get"
        guard let token = AppSession.instance.token else {preconditionFailure("Empty token!")}
            
        var params: Parameters = [
            "access_token" : token,
            "extended" : 1,
            "v" : "5.101"
        ]
        if let owner_id = owner_id {
            params.merge (["owner_id": String(owner_id)]) { (current, _) in current }
        }
        if let id = id,
            let owner_id = owner_id {
            params.merge (["videos": String(owner_id)+"_"+String(id)]) { (current, _) in current }
        }
        NetworkManager.session.request(self.baseUrl + path, method: .get, parameters: params).responseJSON(queue: DispatchQueue.global()) { response in
            switch response.result {
            case .success(let value) :
                let json = JSON(value)
                var video = [Video]()
                let videoJSONs = json["response"]["items"].arrayValue
                video = videoJSONs.map {Video($0)}
                DispatchQueue.main.async {
                    completion(video)
                }
            case .failure(let err):
                print(err)
            }
        }
    }
    
}