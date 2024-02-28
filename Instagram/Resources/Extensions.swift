//
//  Extensions.swift
//  Instagram
//
//  Created by Elif İlay Eser
//

import Foundation
import UIKit

extension UIView{
    var top: CGFloat{
        frame.origin.y
    }
    var bottom: CGFloat{
        frame.origin.y+height
    }
    var left: CGFloat{
        frame.origin.x
    }
    var right: CGFloat{
        frame.origin.x+width
    }
    var width: CGFloat{
        frame.size.width
    }
    var height: CGFloat{
        frame.size.height
    }
}

//what is the purpose of this code
//We are going to be convert into a dictionary
extension Encodable {
    func asDictionary()->[String:Any]?{
        guard let data = try? JSONEncoder().encode(self) else {return nil} // self tell us about the User
        let json = try? JSONSerialization.jsonObject(with: data,options: .allowFragments) as? [String:Any]
        return json
    }
}

extension Decodable{
    init?(with dictionary: [String:Any] ){
        guard let data = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted) else {return nil}
        guard let result = try? JSONDecoder().decode(Self.self, from: data) else {return nil}
        self = result
    }
}

extension DateFormatter{
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
}
extension String {
    static func date(from date: Date) -> String? {
        let formatter = DateFormatter.formatter
        let string = formatter.string(from: date)
        return string
    }
}
extension Notification.Name {
    static let didPostNotification = Notification.Name("didPostNotification")
}
