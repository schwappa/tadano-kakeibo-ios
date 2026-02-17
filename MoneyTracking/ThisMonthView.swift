//
//  ThisMonthView.swift
//  MoneyTracking
//
//  Created by Kai Nielsen on 2026/02/16.
import SwiftUI
import SwiftData

struct ThisMonthView: View {
    
    @State private var selectedExpense: Expense?
    @State private var showingAddSheet = false
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Expense.date, order: .reverse) private var expenses: [Expense]
    
    var body: some View {
        NavigationStack {
            
            List {
                
                // 🔹 Header Section
                Section {
                    EmptyView()
                } header: {
                    VStack(spacing: 4) {
                        
                        Text(currentMonthTitle)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Text(monthlyTotal, format: .currency(code: "JPY"))
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                }
                
                // 🔹 Expense Rows
                Section {
                    ForEach(thisMonthExpenses) { expense in
                        Button {
                            selectedExpense = expense
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    
                                    Text(expense.category)
                                        .font(.headline)
                                    
                                    Text(expense.date.formatted(date: .numeric, time: .omitted))
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                Text(expense.amount, format: .currency(code: "JPY"))
                                    .fontWeight(.medium)
                            }
                            .padding(.vertical, 4)
                        }
                        .buttonStyle(.plain)
                    }
                    .onDelete(perform: deleteExpense)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("今月")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddExpenseView()
            }
            .sheet(item: $selectedExpense) { expense in
                EditExpenseView(expense: expense)
            }
        }
    }
    
    // MARK: - Computed Properties
    
    private var thisMonthExpenses: [Expense] {
        expenses.filter {
            Calendar.current.isDate($0.date, equalTo: Date(), toGranularity: .month)
        }
    }
    
    private var monthlyTotal: Int {
        thisMonthExpenses.reduce(0) { $0 + $1.amount }
    }
    
    private var currentMonthTitle: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年M月"
        return formatter.string(from: Date())
    }
    
    // MARK: - Delete
    
    private func deleteExpense(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(thisMonthExpenses[index])
        }
    }
}
