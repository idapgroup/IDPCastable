//
//  IDPCastable.swift
//  Pods
//
//  Created by Oleksa 'trimm' Korin on 12/12/16.
//
//

/**
 Casts a value from Type to Result?
 
 - Parameter value:     Value to be casted
 - Returns:             *.some(value: Result)* if the value could be casted, *.none* otherwise
 */
public func cast<Type, Result>(_ value: Type) -> Result? {
    return value as? Result
}

/**
 Chainable type representing the value matching different types
 */
public enum Castable<Wrapped> {
    case value(Wrapped)
    
    /**
     Casts a value to function argument type and calls a function, if the cast was successfull.
     - Parameter f:     Function to call, if the *.value* in can be be casted to function argument
     - Returns:         Castable wrapping the same value
     */
    @discardableResult
    public func match<Subject>(f: (Subject) -> ()) -> Castable<Wrapped> {
        switch self {
        case let .value(x):
            cast(x).map { f($0) }
            return .value(x)
        }
    }
    
    /**
     Extracts a value from Castable
     
     - Returns:     Value wrapped by Castable
     */
    public func extract() -> Wrapped {
        switch self {
        case let .value(x):
            return x
        }
    }
}

/**
 Wraps a value in Castable.
 - Parameters:
    - x:    Value to wrap.
  
 - Returns: Value wrapped by Castable
 */
@discardableResult
public func castable<Wrapped>(_ x: Wrapped) -> Castable<Wrapped> {
    return Castable.value(x)
}

/**
 Wraps a value in Castable and matches the function to it.
 - Parameters:
    - x:    Value to wrap.
    - f:    Function to call, if the function type argument can be casted to type of *x*.
 
 - Returns: Value wrapped by Castable
 */
@discardableResult
public func castable<Wrapped, Subject>(_ x: Wrapped, f: (Subject) -> ()) -> Castable<Wrapped> {
    return castable(x).match(f: f)
}

/**
 Calls a function if the value can be casted to function argument type
 - Parameters:
    - x:    Value to cast.
    - f:    Function to call, if the function type argument can be casted to type of *x*.
 
 - Returns: Same value as *x*
 */
@discardableResult
public func match<Wrapped, Subject>(_ x: Wrapped, f: (Subject) -> ()) -> Wrapped {
    return castable(x, f: f).extract()
}
