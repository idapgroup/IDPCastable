//
//  IDPCastableTests.swift
//  IDPCastableTests
//
//  Created by Oleksa 'trimm' Korin on 12/12/16.
//  Copyright © 2016 Oleksa 'trimm' Korin. All rights reserved.
//

import Quick
import Nimble

@testable import IDPCastable

class CastTestClass { }
class ChildCastTestClass : CastTestClass { }

class IDPCastableSpec: QuickSpec {
    override func spec() {
        describe("func cast<Type, Result>(_ value: Type) -> Result?") {
            let value: Any = CastTestClass()
            
            it("should cast to optional .some for types castable from Type to Result") {
                let castedValue: CastTestClass? = cast(value)
                
                expect(castedValue).notTo(beNil())
            }
            
            it("should not cast to optional .some for types not castable from Type to Result") {
                let castedValue: ChildCastTestClass? = cast(value)
                
                expect(castedValue).to(beNil())
            }
        }
        
        let wrapped: AnyObject = ChildCastTestClass()
        describe("Castable") {
            
            let value = Castable<AnyObject>.value(wrapped)
            context("when matching") {
                it("should call the function with argument type castable to .value") {
                    var called = false
                    value.match { (_: CastTestClass) in called = true }
                    
                    expect(called).to(beTrue())
                }
                
                it("should not call the function with argument type not castable to .value") {
                    var called = false
                    value.match { (_: CustomStringConvertible) in called = true }
                    
                    expect(called).to(beFalse())
                }
                
                context("when extracting") {
                    it("should return the value it was created with") {
                        expect(ObjectIdentifier(value.extract())).to(equal(ObjectIdentifier(wrapped)))
                    }
                }
            }
        }
        
        describe("func castable<Wrapped>(_ x: Wrapped) -> Castable<Wrapped>") {
            it("should return Castable wrapping x") {
                let value = castable(wrapped)
                
                expect(ObjectIdentifier(value.extract())).to(equal(ObjectIdentifier(wrapped)))
            }
        }
        
        describe("func castable<Wrapped, Subject>(_ x: Wrapped, f: (Subject) -> ()) -> Castable<Wrapped>") {
            var value = Castable<AnyObject>.value(wrapped)
            
            context("when Wrapped can be cast to Subject") {
                it("should apply f to x") {
                    var called = false
                    value = castable(wrapped) { (x: CastTestClass) in called = true }
                    
                    expect(called).to(beTrue())
                }
                
                it("should return Castable wrapping x") {
                    expect(ObjectIdentifier(value.extract())).to(equal(ObjectIdentifier(wrapped)))
                }
            }
            
            context("when Wrapped can not be cast to Subject") {
                it("should not apply f to x") {
                    var called = false
                    value = castable(wrapped) { (x: CustomStringConvertible) in called = true }
                    
                    expect(called).to(beFalse())
                }
                
                it("should return Castable wrapping x") {
                    expect(ObjectIdentifier(value.extract())).to(equal(ObjectIdentifier(wrapped)))
                }
            }
        }
        
        describe("func match<Wrapped, Subject>(_ value: Wrapped, f: (Subject) -> ()) -> Wrapped") {
            context("when Wrapped can be cast to Subject") {
                it("should apply f to x") {
                    var called = false
                    match(wrapped) { (x: CastTestClass) in called = true }
                    
                    expect(called).to(beTrue())
                }
                
                it("should return x") {
                    expect(ObjectIdentifier(match(wrapped) { (x: CastTestClass) in  }))
                        .to(equal(ObjectIdentifier(wrapped)))
                }
            }
            
            context("when Wrapped can not be cast to Subject") {
                it("should not apply f to x") {
                    var called = false
                    match(wrapped) { (x: CustomStringConvertible) in called = true }
                    
                    expect(called).to(beFalse())
                }
                
                it("should return x") {
                    expect(ObjectIdentifier(match(wrapped) { (x: CustomStringConvertible) in  }))
                        .to(equal(ObjectIdentifier(wrapped)))
                }
            }
        }
    }
}
