//
//  AppError.swift
//  Habit
//
//  Created by Jamerson Macedo on 01/07/24.
//

import Foundation

enum AppError:Error{
    case response(message:String)
    public var message :String?{
        switch self{
        case .response(let message):
            return message
        }
    }
}
