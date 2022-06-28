//
//  Parser.swift
//  Gists
//
//  Created by Дмитрий Подольский on 24.06.2022.
//

import Foundation

struct Parser {
    
    func parse(comp: @escaping ([GistsRoot])->()) {
        let api = URL(string: "https://api.github.com/gists")
        
        URLSession.shared.dataTask(with: api!) {
            data, response, error in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            do {
                let result = try JSONDecoder().decode([GistsRoot].self, from: data!)
                comp(result)
                
            } catch {
                
            }
        }.resume()
        
        
    }
    
}
