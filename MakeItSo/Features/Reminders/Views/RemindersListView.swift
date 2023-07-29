//
//  ContentView.swift
//  MakeItSo
//
//  Created by madeinweb on 22/07/23.
//

import SwiftUI

struct RemindersListView: View {
    @StateObject var viewModel = RemindersListViewModel()
    
    @State private var isAddReminderDialogPresented = false
    
    @State private var editableReminder: Reminder? = nil
    
    private func presentAddReminderView() {
        isAddReminderDialogPresented.toggle()
    }
    
    @State private var isSettingsScreenPresented = false


      private func presentSettingsScreen() {
          isSettingsScreenPresented.toggle()
      }

    
    var body: some View {
        List($viewModel.reminders) { $reminder in
            RemindersListRowView(reminder: $reminder)
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive, action: { viewModel.deleteReminder(reminder) }) {
                                Image(systemName: "trash")
                              }
                              .tint(Color(UIColor.systemRed))
                        }
                .onChange(of: reminder.isCompleted) { newValue in
                    viewModel.setCompleted(reminder, isCompleted: newValue)
                }
                .onTapGesture {
                    editableReminder = reminder
                }
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                      Button(action: presentSettingsScreen) {
                          Image(systemName: "gearshape")
                      }
                  }
            ToolbarItemGroup(placement: .bottomBar) {
                Button(action: presentAddReminderView) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("New Reminder")
                    }
                }
                Spacer()
            }
        }
        .sheet(isPresented: $isAddReminderDialogPresented) {
            EditReminderDetailsView { reminder in
                viewModel.addReminder(reminder)
            }
        }
        .sheet(item: $editableReminder) { reminder in
            EditReminderDetailsView(mode: .edit, reminder: reminder) { reminder in
                viewModel.updateReminder(reminder)
                  }
            }
        .sheet(isPresented: $isSettingsScreenPresented) {
              SettingsView()
            }
        .tint(.red)
    }
}

struct RemindersListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RemindersListView()
                .navigationBarTitle("Reminders", displayMode: .inline)
        }
    }
}
