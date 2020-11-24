Pod::Spec.new do |goSellAppClipSDK|
    
    goSellAppClipSDK.platform              = :ios
    goSellAppClipSDK.ios.deployment_target = '14.0'
	goSellAppClipSDK.swift_versions        = ['4.0', '4.2', '5.0']
    goSellAppClipSDK.name                  = 'goSellAppClipSDK'
    goSellAppClipSDK.summary               = 'goSellAppClip SDK for iOS'
    goSellAppClipSDK.requires_arc          = true
    goSellAppClipSDK.version               = '1.0.4'
    goSellAppClipSDK.license               = { :type => 'MIT', :file => 'LICENSE' }
    goSellAppClipSDK.author                = { 'Tap Payments' => 'hello@tap.company' }
    goSellAppClipSDK.homepage              = 'https://github.com/Tap-Payments/goSellAppClipSDK'
    goSellAppClipSDK.source                = { :git => 'https://github.com/Tap-Payments/goSellAppClipSDK.git', :tag => goSellAppClipSDK.version.to_s }


    goSellAppClipSDK.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
  }
    goSellAppClipSDK.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

	goSellAppClipSDK.default_subspec		= 'Core'
	
	goSellAppClipSDK.subspec 'Core' do |core|
		
		core.source_files			= 'goSellAppClipSDK/Core/**/*.{swift}'
		core.ios.resource_bundle	= { 'goSellAppClipSDKResources' => ['goSellAppClipSDK/Core/UI/Internal/Resources/*.{xcassets,storyboard,xib,json}', 'goSellAppClipSDK/Core/UI/Internal/Resources/Localization/*.lproj'] }
		
		core.dependency 'EditableTextInsetsTextFieldV2'
		core.dependency 'TapAdditionsKitV2'
		core.dependency 'TapApplicationV2'
		core.dependency	'TapBundleLocalization'
		core.dependency 'TapCardValidator'
		core.dependency 'TapEditableViewV2'
		core.dependency 'TapFontsKitV2'
		core.dependency 'TapGLKitV2'
		core.dependency 'TapKeychain'
		core.dependency 'TapNetworkManagerV2'
		core.dependency 'TapNibViewV2'				
		core.dependency 'TapResponderChainInputViewV2'
		core.dependency 'TapSearchViewV2'
		core.dependency 'TapVisualEffectViewV2'
		core.dependency 'SwiftyRSA'
		
	end
end
