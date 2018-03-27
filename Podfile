# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'ReactiveViewModels' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!


  # Pods for ReactiveViewModels
  pod 'RxSwift', '4.1.2'
  pod 'RxCocoa', '4.1.2'
  pod 'Cartography', '3.0.1'

  target 'ReactiveViewModelsFramework' do
      inherit! :search_paths
      target 'ReactiveViewModelsFrameworkTests' do
          inherit! :search_paths
      end
  end

  target 'ReactiveViewModelsTests' do
    inherit! :search_paths
    # Pods for testing
#    pod 'RxSwift', '4.1.2'
#    pod 'RxCocoa', '4.1.2'
    pod 'RxBlocking', '4.1.2'
    pod 'RxTest', '4.1.2'
  end

  target 'ReactiveViewModelsUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
