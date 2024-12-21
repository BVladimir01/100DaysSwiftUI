//
//  CheckView.swift
//  CupcakeCorner
//
//  Created by Vladimir on 18.12.2024.
//

import SwiftUI

struct CheckView: View {
    
    var orderStore: OrderStore
    @Binding var path: NavigationPath
    @State private var responseMessage = "response message"
    @State private var showAlert = false
    @State private var requestFailed = false
    @State private var requestErrorMessage = "Unknown error occured"
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { phase in
                    switch phase {
                    case .empty:
                        ProgressView("loading image")
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .containerRelativeFrame(.horizontal) { width, _ in
                                width
                            }
                    case .failure(let error):
                        Text(error.localizedDescription)
                    @unknown default:
                        fatalError()
                    }
                }
                Text("Your total is \(orderStore.order.cost.formatted(.currency(code: "USD")))")
                    .font(.headline)
                Button {
                    Task {
                        await placeOrder()
                    }
                } label: {
                    Text("Place order")
                        .font(.title)
                }
                .padding()
                .alert("Thank you", isPresented: $showAlert) {
                    Button("Ok") {
                        orderStore.deleteOrderInfoExceptAddress()
                        path.removeLast(2)
                    }
                } message: {
                    Text(responseMessage)
                }
                .alert("Error", isPresented: $requestFailed) {
                    Button("OK") {
                        path.removeLast(2)
                    }
                } message: {
                    Text(requestErrorMessage)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .scrollBounceBehavior(.basedOnSize)
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func placeOrder() async {
        guard let data = try? JSONEncoder().encode(orderStore.order) else { return }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: data)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            responseMessage = "You ordered \(decodedOrder.quantity) \(decodedOrder.type.rawValue.lowercased()) cupcakes"
            showAlert = true
        } catch {
            print(error.localizedDescription)
            requestFailed = true
            requestErrorMessage = error.localizedDescription
        }
    }
}

//#Preview {
//    CheckView(order: Order())
//}
