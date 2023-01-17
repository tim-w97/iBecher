//
//  ModelInterface+Persistence.swift
//  iBecher
//
//  Created by Tim Wagner on 17.01.23.
//

import Foundation

extension ModelInterface {
    private func getFileURL() throws -> URL {
        try FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )
        .appendingPathComponent("coffeePurchases.data")
    }
    
    func loadDataFromDisk(completionHandler: @escaping (Result<[CoffeePurchase], Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try self.getFileURL()
                
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completionHandler(.success([]))
                    }
                    return
                }
                
                let coffeePurchases = try JSONDecoder().decode([CoffeePurchase].self, from: file.availableData)
                
                DispatchQueue.main.async {
                    completionHandler(.success(coffeePurchases))
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
            }
        }
    }
    
    func saveDataToDisk(coffeePurchases: [CoffeePurchase], completionHandler: @escaping (Result<Int, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let jsonData = try JSONEncoder().encode(coffeePurchases)
                let outputFile = try self.getFileURL()
                
                try jsonData.write(to: outputFile)
                
                DispatchQueue.main.async {
                    completionHandler(.success(coffeePurchases.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
            }
        }
    }
}
