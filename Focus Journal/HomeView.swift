//
//  HomeView.swift
//  Focus Journal
//
//  Created by Ben Gohlke on 5/27/25.
// Copyright © 2025 Adapty. All rights reserved.
//

import SwiftUI

struct HomeView: View {
  @Environment(ProfileManager.self) private var profileManager
  
  @State private var entryText: String = ""
  
  @State private var isShowingPaywall = false
  @State private var isShowingHistory = false
  
  var body: some View {
    VStack(spacing: 20) {
      Text("What was your focus today?")
        .font(.headline)
      
      TextField("Enter your thoughts...", text: $entryText)
        .textFieldStyle(.roundedBorder)
        .padding(.horizontal)
      
      Button(action: saveEntry) {
        Text("Save Entry")
          .frame(maxWidth: .infinity)
          .padding()
          .background(Color.blue)
          .foregroundColor(.white)
          .cornerRadius(8)
      }
      .padding(.horizontal)
      
      Spacer()
      
      Button {
        if profileManager.isPremium {
          isShowingHistory = true
        } else {
          isShowingPaywall = true
        }
      } label: {
        Text("View History")
      }
      .buttonStyle(.bordered)
    }
    .sheet(isPresented: $isShowingHistory) {
      NavigationStack {
        HistoryView()
      }
    }
    .sheet(isPresented: $isShowingPaywall) {
      Button {
        profileManager.purchasePremium()
        isShowingPaywall = false
      } label: {
        Text("Unlock Premium")
      }
      .buttonStyle(.borderedProminent)
    }
  }
  
  func saveEntry() {
    guard !entryText.isEmpty else { return }
    profileManager.addEntry(entryText)
    entryText = ""
  }
}
