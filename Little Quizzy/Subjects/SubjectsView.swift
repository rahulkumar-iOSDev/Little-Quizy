//
//  SubjectsView.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 29/09/26.
//

import SwiftUI

struct SubjectsView: View {
    @AppStorage(AppStorageKey.userName) private var AppStorageUserName = ""
    @State private var viewModel = SubjectsViewModel()
    
    let columns = [
        GridItem(.flexible(), spacing: 24),
        GridItem(.flexible(), spacing: 24)
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Hello, \(AppStorageUserName) 👋")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 28))
                    .fontWeight(.semibold)
                    .foregroundStyle(.appText)
                
                Text("Ready to learn?")
                    .multilineTextAlignment(.leading)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                    .fixedSize(horizontal: false, vertical: true)
            }
            LazyVGrid(columns: columns) {
                ForEach(viewModel.subjects) { subject in
                    SubjectCard(subject: subject)
                }
            }
            .padding(.top, 20)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(.appWhiteBg)
        .ignoresSafeArea(edges: .horizontal)
    }
}

#Preview {
    SubjectsView()
}
