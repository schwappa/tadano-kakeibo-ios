//
//  Expense.swift
//  MoneyTracking
//
//  Created by Kai Nielsen on 2026/02/16.
//

import Foundation
import SwiftData

@Model
class Expense {
    var category: String
    var amount: Int
    var date: Date
    
    init(category: String, amount: Int, date: Date = Date()) {
        self.category = category
        self.amount = amount
        self.date = date
    }
}
