//
//  MonthDetailView.swift
//  MoneyTracking
//
//  Created by Kai Nielsen on 2026/02/16.
//
import SwiftUI
import SwiftData

struct MonthDetailView: View {
    
    let month: DateComponents
    let expenses: [Expense]
    
    @Environment(\.modelContext) private var modelContext
    @State private var selectedExpense: Expense?
    
    var body: some View {
        
        List {
            ForEach(expenses) { expense in
                Button {
                    selectedExpense = expense
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(expense.category)
                                .font(.headline)
                            
                            Text(expense.date.formatted(date: .numeric, time: .omitted))
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Text(expense.amount, format: .currency(code: "JPY"))
                    }
                }
                .buttonStyle(.plain)
            }
            .onDelete(perform: deleteExpense)
        }
        .navigationTitle(monthTitle)
        .sheet(item: $selectedExpense) { expense in
            EditExpenseView(expense: expense)
        }
    }
    
    private func deleteExpense(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(expenses[index])
        }
    }
    
    private var monthTitle: String {
        guard let date = Calendar.current.date(from: month) else {
            return "Month"
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年M月"
        return formatter.string(from: date)
    }
}

