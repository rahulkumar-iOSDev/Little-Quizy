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
    @Environment(Router.self) private var router
    
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
                    .font(.callout)
                    .foregroundStyle(.gray)
                    .fixedSize(horizontal: false, vertical: true)
            }
            LazyVGrid(columns: columns) {
                ForEach(viewModel.subjects) { subject in
                    SubjectCard(subject: subject)
                        .onTapGesture {
                            router.subject.push(.subjectQuizView(subject.name, subject.name.title))
                        }
                }
            }
            .padding(.top, 20)
            Spacer()
        }
        .appScreenStyle()
    }
}

#Preview {
    SubjectsView()
}
