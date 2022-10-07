//
//  SendView.swift
//  dailywallet
//
//  Created by Daniel Nordh on 07/10/2022.
//

import SwiftUI
import BDKManager
import WalletUI

struct SendView: View {
    @EnvironmentObject var bdkManager: BDKManager
    @Environment(\.presentationMode) var presentationMode
    
    @State private var address: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                TextField("Enter address", text: $address).padding(32)
                    .textFieldStyle(.roundedBorder)
                    .tint(Color.bitcoinOrange)
                Spacer()
                Button("Send bitcoin") {
                    sendBitcoin()
                }
                .buttonStyle(BitcoinFilled())
                .disabled(self.address == "").padding(16)
            }
            .navigationTitle("Send bitcoin")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }.accentColor(.black)
    }
    
    func sendBitcoin() {
        switch bdkManager.walletState {
            case .loaded:
                do {
                    //
                } catch (let error){
                    print(error)
                }
            default: do {}
        }
    }
}

struct SendView_Previews: PreviewProvider {
    static var previews: some View {
        SendView()
    }
}
