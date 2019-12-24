Pod::Spec.new do |s|
  s.name = "MoPub-AtmosplayAds-Adapters"
  s.version = "3.0.0"
  s.summary = "Atmosplay adapter used for mediation with the Mopub Mobile Ads SDK"
  s.license = "Custom"
  s.authors = {"Atmosplay sdk team"=>"ad-client@atmosplay.com"}
  s.homepage = "https://github.com/atmosplay/AtmosplayAds-iOS"
  s.description = "Atmosplay SDK provides a better ad format for monetizing."
  s.source = { :git => 'https://github.com/Atmosplay/MopubAdapter-AtmosplayAds-iOS.git', :tag => s.version.to_s}
  s.source_files = 'PlayableMopubAd/Adapters/*.{h,m}'
  s.ios.deployment_target = '9.0'
  s.dependency 'AtmosplayAds', '~> 3.0.0'
  s.dependency 'mopub-ios-sdk'
  s.static_framework = true
  
end
