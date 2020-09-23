//
//  RxSwiftCrashTests.swift
//  RxSwiftCrashTests
//
//  Created by Kevin ABRIOUX on 23/09/2020.
//

import XCTest
import RxSwift
import RxTest
import RxCocoa
@testable import RxSwiftCrash

class RxSwiftCrashTests: XCTestCase {

    var testScheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        self.testScheduler = TestScheduler(initialClock: .zero)
        self.disposeBag = DisposeBag()
    }
    
    func testCrash(){
        let observer = testScheduler
            .createObserver(Result<[Int]?, NSError>?.self)
        
        let observable = Observable.just(Result<[Int]?, NSError>.failure(NSError()))
        
        observable
            .bind(to: observer)
            .disposed(by: self.disposeBag)
        
        XCTAssertEqual(observer.events, [.next(0, .failure(NSError()))])
    }

}
