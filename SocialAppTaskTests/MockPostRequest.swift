//
//  MockPostRequest.swift
//  SocialAppTaskTests
//
//  Created by Youxel mac5 on 1/23/20.
//  Copyright © 2020 Maged Mohammed. All rights reserved.
//

import Foundation
@testable import SocialAppTask

class MockPostPresenter: PostsListPresenter{
    override func getPostsData() {
        let bundle = Bundle.init(for: type(of: self))
        if let path = bundle.path(forResource: "JSON", ofType: "txt"){
            if let data = try? Data.init(contentsOf: URL.init(fileURLWithPath: path)){
                let json = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                print(json)
            }
        }
        
        
        
        PostsRequest.getPosts { [weak self](data, error) in
            guard let self = self else{return}
            if let data = data, error == nil{
                self.view.setPost(data: data)
            }else{
                if let error = error{
                    self.view.showAlert(title: "Error", message: error.localizedDescription )
                }
            }
        }
    }
}
