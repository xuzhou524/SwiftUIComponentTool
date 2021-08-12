//
//  NetworkRequest.swift
//  SwiftUIComponentTool
//
//  Created by hualala on 2021/8/12.
//

import SwiftUI

//网络请求示例

//Model
struct MarkeTemplate {
    let templateId: String
    let name: String
    let activityTypeStr: String
    var iconImage: UIImage? = UIImage(named: "plan_collect")
}

struct TemplateListData {
    //网络请求
    static func getTemplateList(completion: @escaping (Result<MarkeTemplate, Error>) -> Void) {
        let url = URL(string: "https://test-shop.caidanmao.com/api/template/getClassifyTemplateList")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error==nil else{
                completion(.failure(error!))
                return
            }
            let template = templateFromJson(fromData: data!)
            completion(.success(template))
        }
        task.resume()
    }
    
    //数据转换
    static func templateFromJson(fromData data:Data) -> MarkeTemplate {
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        guard let result = json["result"] as? [String: Any] else{
            return MarkeTemplate(templateId: "2", name: "通用模板", activityTypeStr: "菜品促销,节日促销")
        }
        
        let templateId = result["id"] as! String
        let name = result["name"] as! String
        let activityTypeStr = result["activityTypeStr"] as! String
        let iconImage = result["iconImage"] as! String
        
        //图片同步请求 - 根据URL地址得到 image
        var image: UIImage? = nil
        if let imageData = try? Data(contentsOf: URL(string: iconImage)!) {
            image = UIImage(data: imageData)
        }
        
        return MarkeTemplate(templateId: templateId, name: name, activityTypeStr: activityTypeStr, iconImage: image)
    }
}
