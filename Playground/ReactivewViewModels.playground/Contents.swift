//: Playground - noun: a place where people can play

import UIKit
import RxSwift
import PlaygroundSupport
@testable import ReactiveViewModelsFramework

let page = PlaygroundPage.current
page.needsIndefiniteExecution = true

let usernameSubject = PublishSubject<String?>()
let passwordSubject = PublishSubject<String?>()
let loginSubject = PublishSubject<Void>()
let returnPressedOnPassword = PublishSubject<Void>()

let viewModel = LoginViewModel(username: usernameSubject, password: passwordSubject, loginPressed: loginSubject, returnPressedOnPassword: returnPressedOnPassword)

viewModel.loginResult.debug("loginResult").subscribe()
viewModel.loggedIn.debug("loggedIn").subscribe()
viewModel.isUsernameEnabled.debug("isUsernameEnabled").subscribe()
viewModel.isPasswordEnabled.debug("isPasswordEnabled").subscribe()
viewModel.isLoginEnabled.debug("isLoginEnabled").subscribe()
viewModel.isIncorrectUsernameOrPasswordHidden.debug("isIncorrectUsernameOrPasswordHidden").subscribe()

usernameSubject.onNext("reaktor")
passwordSubject.onNext("pikkukakkonen!")
print("Logging in")
loginSubject.onNext(())

