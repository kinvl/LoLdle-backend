//
//  Sequence+Async.swift
//  
//
//  Created by Krzysztof Kinal on 06/09/2022.
//

extension Sequence {
    func concurrentForEach(_ operation: @escaping (Element) async throws -> Void) async throws {
        await withTaskGroup(of: Void.self) { group in
            for element in self {
                group.addTask {
                    try? await operation(element)
                }
            }
        }
    }
}
