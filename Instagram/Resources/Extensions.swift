//
//  Extensions.swift
//  Instagram
//
//  Created by Elif İlay KANDEMİR on 11.02.2023.
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
