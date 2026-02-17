//
//  AddExpenseView.swift
//  MoneyTracking
//
//  Created by Kai Nielsen on 2026/02/16.
//

import SwiftUI
import SwiftData

struct AddExpenseView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var category: String = ""
    @State private var amountString: String = ""
    @State private var date: Date = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section(header: Text("詳細")) {
                    
                    TextField("カテゴリー", text: $category)
                    
                    TextField("金額", text: $amountString)
                        .keyboardType(.numberPad)
                    
                    DatePicker(
                        "日付",
                        selection: $date,
                        displayedComponents: .date
                    )
                }
            }
            .navigationTitle("支出を追加")
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("キャンセル") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("保存") {
                        saveExpense()
                    }
                    .disabled(!isValidInput)
                }
            }
        }
    }
    
    private var isValidInput: Bool {
        guard !category.trimmingCharacters(in: .whitespaces).isEmpty,
              let amount = Int(amountString),
              amount > 0
        else {
            return false
        }
        return true
    }
    
    private func saveExpense() {
        guard let amount = Int(amountString) else { return }
        
        let newExpense = Expense(
            category: category,
            amount: amount,
            date: date
        )
        
        modelContext.insert(newExpense)
        dismiss()
    }
}
