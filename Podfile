platform :ios, '13.0'

def globalPods
    pod 'Swinject'
    pod 'SwiftLint'
end

target 'TripManager' do
  use_frameworks!
  globalPods
  target 'TripManagerTests' do
    inherit! :search_paths
  end

  target 'TripManagerUITests' do
  end
end

target 'TripManagerData' do
  use_frameworks!
  globalPods
  target 'TripManagerDataTests' do
  	inherit! :search_paths
  end
end

target 'TripManagerDomain' do
  use_frameworks!
  globalPods
  target 'TripManagerDomainTests' do
  	inherit! :search_paths
  end
end
