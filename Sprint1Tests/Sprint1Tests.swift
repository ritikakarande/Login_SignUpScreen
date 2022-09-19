//
//  Sprint1Tests.swift
//  Sprint1Tests
//
//  Created by Capgemini-DA087 on 8/25/22.
//

import XCTest
@testable import Sprint1

class Sprint1Tests: XCTestCase {
    var loginVC: LoginViewController!
    var signUpVC: SignUpViewController!
    var networkVC: NetworkCallViewController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        loginVC = LoginViewController.getVC()
        loginVC!.loadViewIfNeeded()
        signUpVC = SignUpViewController.getSignVC()
        signUpVC!.loadViewIfNeeded()
    }
  func test_checkButtonAction() throws{
      let loginBtn: UIButton = try XCTUnwrap(loginVC.loginButton, "login button has no referencing outlet")
      let loginAction = try XCTUnwrap(loginBtn.actions(forTarget: loginVC, forControlEvent: .touchUpInside), "Login Button does not have an action")
      
      XCTAssertEqual(loginAction.count, 1)
      XCTAssertEqual(loginAction.first, "loginClicked:", "No action available for login button")
      
      let signUpBtn: UIButton = try XCTUnwrap(signUpVC.signUpButton, "SignUp button has no referencing outlet")
      let signupAction = try XCTUnwrap(signUpBtn.actions(forTarget: signUpVC, forControlEvent: .touchUpInside), "SignUp Button does not have an action")
      
      XCTAssertEqual(signupAction.count, 1)
      XCTAssertEqual(signupAction.first, "signupButtonClicked:", "No action for signUp button" )
  }
    //func test_validUsername(){
        
    //}
    func test_SignUpVCoutlets() throws{
        XCTAssertNotNil(loginVC.emailIdText, "Failed - no connected outlet")
        XCTAssertNotNil(loginVC.passwordText, "Failed- no outlets connected")
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
