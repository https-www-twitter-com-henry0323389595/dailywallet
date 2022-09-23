//
//  WalletView.swift
//  dailywallet
//
//  Created by Daniel Nordh on 5/13/22.
//

import SwiftUI
import BDKManager
//import LDKFramework
import BlockSocket
import WalletUI

struct WalletView: View {
    @EnvironmentObject var bdkManager: BDKManager
    @EnvironmentObject var backupManager: BackupManager
    let blockSocket = BlockSocket.init(source: BlockSocketSource.blockchain_com)
    
    @State var blockHeight: UInt32?
    @State private var navigateTo: NavigateTo? = NavigateTo.none
    
    init () {
        let value = blockSocket.$latestBlockHeight.sink { (latestBlockHeight) in
            if latestBlockHeight != nil {
                print("Blockheight" + latestBlockHeight!.description)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack (spacing: 50){
                Spacer()
                switch bdkManager.syncState {
                case .synced:
                    Text("\(bdkManager.balance) sats")
                case .syncing:
                    Text("Syncing")
                default:
                    Text("Not synced")
                }
                //Text(bdkManager.wallet?.getAddress(addressIndex: AddressIndex.new).address ?? "-")
                Spacer()
                VStack (spacing: 50) {
                    HStack (spacing: 100) {
                        Text("1")
                        Text("2")
                        Text("3")
                    }
                    HStack (spacing: 100) {
                        Text("4")
                        Text("5")
                        Text("6")
                    }
                    HStack (spacing: 100) {
                        Text("7")
                        Text("8")
                        Text("9")
                    }
                    HStack (spacing: 100) {
                        Text(".")
                        Text("0")
                        Text("<")
                    }
                }
                HStack {
                    Spacer()
                    Button("Request") {
                        //self.navigateTo = .createWallet
                    }.buttonStyle(BitcoinFilled(width: 150))
                    Spacer()
                    Button("Pay") {
                        //self.navigateTo = .createWallet
                    }.buttonStyle(BitcoinFilled(width: 150))
                    Spacer()
                }.padding(.bottom, 32)
                
            }
        }.accentColor(.black)
        .task {
            bdkManager.sync() // to sync once
            //bdkManager.startSyncRegularly(interval: 120) // to sync every 120 seconds
            
        }.onDisappear {
            //bdkManager.stopSyncRegularly() // if startSyncRegularly was used
        }.onReceive(self.blockSocket.$latestBlockHeight) { flag in
            let cancellable = blockSocket.$latestBlockHeight.sink (
                receiveCompletion: { completion in
                    // Called once, when the publisher was completed.
                    switch completion {
                        case .failure(let error):
                            print(error)
                        case .finished:
                            print("Success")
                        }
                },
                receiveValue: { value in
                    // Can be called multiple times, each time that a
                    // new value was emitted by the publisher.
                    print(value)
                }
            )
        }
    }
    
    /*
    private func setupLDKManager() {
        // Initialize LDKManager
        let ldkNetwork = LDKNetwork_Testnet // set LDKNetwork_Bitcoin, LDKNetwork_Testnet, LDKNetwork_Signet or LDKNetwork_Regtest
        if blockSocket.latestBlockHeight != nil {
            print("LatestBlockHeight: " + self.blockSocket.latestBlockHeight!.description)
            let ldkManager = LDKManager.init(network: ldkNetwork, latestBlockHeight: blockSocket.latestBlockHeight!, latestBlockHash: blockSocket.latestBlockHash!)
        }
    }
    */
}

struct VerticalLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.icon.font(.headline)
            configuration.title.font(.caption)
        }
    }
}
