//
//  HomeView.swift
//  Focus Journal
//
//  Created by Ben Gohlke on 5/27/25.
// Copyright © 2025 Adapty. All rights reserved.
//

import SwiftUI
import Adapty
import AdaptyUI

struct HomeView: View {
  @Environment(ProfileManager.self) private var profileManager
  
  @State private var entryText: String = ""
  @State private var flowConfig: AdaptyUI.FlowConfiguration?
  
  @State private var isShowingFlow = false
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
          isShowingFlow = true
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
    .iflet(flowConfig, transform: { view, unwrappedFlowConfig in
      view.flow(
        isPresented: $isShowingFlow,
        fullScreen: false,
        flowConfiguration: flowConfig,
        didFinishPurchase: { _, purchaseResult in
          switch purchaseResult {
            case .success(let profile, _):
              profileManager.subscriptionPurchased(with: profile)
            default:
              break
          }
          isShowingFlow = false
        },
        didFailPurchase: { _, error in
          isShowingFlow = false
          // TODO: Present error to user and offer alternative
        },
        didFinishRestore: { profile in
          profileManager.subscriptionPurchased(with: profile)
          isShowingFlow = false
        },
        didFailRestore: { error in
          isShowingFlow = false
          // TODO: Present error to user and offer alternative
        },
        didReceiveError: { error in
          isShowingFlow = false
          // TODO: Present error to user and offer alternative
        })
    })
    .task {
      do {
        if !profileManager.isPremium {
          let flow = try await Adapty.getFlow(placementId: AppConstants.Adapty.placementID)
          flowConfig = try await AdaptyUI.getFlowConfiguration(forFlow: flow, locale: "en")
        }
      } catch {
        print("Error fetching flow or flow config: \(error)")
      }
    }
  }
  
  func saveEntry() {
    guard !entryText.isEmpty else { return }
    profileManager.addEntry(entryText)
    entryText = ""
  }
}
