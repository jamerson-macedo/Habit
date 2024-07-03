//
//  String+Extension.swift
//  Habit
//
//  Created by Jamerson Macedo on 28/06/24.
//

import Foundation

extension String {
    func isEmail () -> Bool{
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@",regEx).evaluate(with: self)
    }
    
    func toDate(source:String, dest:String) ->String?{
        // pegar a string -> dd/MM/yyyy ->
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = source
        
        let dateFormatted = formatter.date(from: self)
        // validar a data
        guard let dateFormatted = dateFormatted else {
            
            return nil
        }
        // convertendo para o objeto
        formatter.dateFormat = dest
       return formatter.string(from: dateFormatted)
        
    }
    func toDate(source:String)->Date?{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = source
        
       return formatter.date(from: self)
        
    }
}
