//
//  EditExpenseView.swift
//  MoneyTracking
//
//  Created by Kai Nielsen on 2026/02/16.
//

import SwiftUI
import SwiftData

struct EditExpenseView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var expense: Expense
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section(header: Text("詳細")) {
                    
                    TextField("カテゴリー", text: $expense.category)
                    
                    TextField("金額", value: $expense.amount, format: .number)
                        .keyboardType(.numberPad)
                    
                    DatePicker(
                        "日付",
                        selection: $expense.date,
                        displayedComponents: .date
                    )
                }
            }
            .navigationTitle("支出を変更")
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("キャンセル") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("完了") {
                        dismiss()
                    }
                }
            }
        }
    }
}
