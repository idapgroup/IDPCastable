//
//  IDPCastable.swift
//  Pods
//
//  Created by Oleksa 'trimm' Korin on 12/12/16.
//
//

func cast<Type, Result>(_ value: Type) -> Result? {
    return value as? Result
}

enum Castable<Wrapped> {
    case value(Wrapped)
    
    @discardableResult
    func match<Subject>(f: (Subject) -> ()) -> Castable<Wrapped> {
        switch self {
        case let .value(x):
            cast(x).map { f($0) }
            return .value(x)
        }
    }
    
    func extract() -> Wrapped {
        switch self {
        case let .value(x):
            return x
        }
    }
}

func match<Wrapped, Subject>(_ x: Wrapped, f: (Subject) -> ()) -> Castable<Wrapped> {
    return Castable.value(x).match(f: f)
}

func match<Wrapped, Subject>(value: Wrapped, f: (Subject) -> ()) -> Wrapped {
    return match(value, f: f).extract()
}
