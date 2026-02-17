//
//  TotalView.swift
//  MoneyTracking
//
//  Created by Kai Nielsen on 2026/02/16.
//

import SwiftUI
import SwiftData

struct TotalView: View {
    
    @Query(sort: \Expense.date, order: .reverse) private var expenses: [Expense]
    
    var body: some View {
        NavigationStack {
            
            List {
                ForEach(groupedMonths, id: \.key) { month, monthExpenses in
                    
                    NavigationLink {
                        MonthDetailView(
                            month: month,
                            expenses: monthExpenses
                        )
                    } label: {
                        HStack {
                            Text(monthTitle(from: month))
                                .font(.headline)
                            
                            Spacer()
                            
                            Text(monthTotal(monthExpenses), format: .currency(code: "JPY"))
                                .fontWeight(.medium)
                        }
                    }
                }
            }
            .navigationTitle("合計")
        }
    }
    
    // MARK: - Grouping Logic
    
    private var groupedMonths: [(key: DateComponents, value: [Expense])] {
        
        let grouped = Dictionary(grouping: expenses) { expense in
            Calendar.current.dateComponents([.year, .month], from: expense.date)
        }
        
        return grouped
            .sorted {
                guard let d1 = Calendar.current.date(from: $0.key),
                      let d2 = Calendar.current.date(from: $1.key)
                else { return false }
                return d1 > d2
            }
    }
    
    private func monthTitle(from components: DateComponents) -> String {
        guard let date = Calendar.current.date(from: components) else {
            return "Unknown"
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年M月"
        return formatter.string(from: date)
    }
    
    private func monthTotal(_ expenses: [Expense]) -> Int {
        expenses.reduce(0) { $0 + $1.amount }
    }
}
