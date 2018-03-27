import RxSwift

extension ObservableType {
    func map<T>(to constant: T) -> Observable<T> {
        return map { _ in constant }
    }
}
