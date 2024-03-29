#
#  Be sure to run `pod spec lint Core.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

#-―――――――――――――――――――――――――――――――――――――――――――――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――#
#
#  These will help people to find your library, and whilst it can feel like a chore to fill in it's definitely to your
#  advantage. The summary should be tweet-length, and the description more in depth.
#――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――----#
  s.name         = "ABCustomControl"
  s.version      = "1.1.0"
  s.summary      = "A common core module shared by akb iOS applications."
  s.description  = <<-DESC
                   A longer description of Core in Markdown format.
                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  #s.homepage     = "http://git.sys.cigna.com/ios/core" #TODO

#-―――――――――――――――――――――――――――――――――――――――――――――  Spec License --―――――――――――――――――――――――――――――――――――――――――――――――――――――――#
  s.license      = "akb"
#――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――----#


##――――――――――――――――――――――――――――――――――――――――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#  Specify the authors of the library, with email addresses. Email addresses of the authors are extracted from the SCM
#  log. E.g. $ git log. CocoaPods also accepts just a name if you'd rather not provide an email address.
#  Specify a social_media_url where others can refer to, for example a twitter profile URL.
#――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――----#
  s.author             = { "Amit Barman" => "amitkumar_barman@yahoo.com" }


##―――――――――――――――――――――――――――――――――――――――――― Platform Specifics ―――――――――――――――――――――――――――――――――――――――――――――――――――――――#
#  If this Pod runs only on iOS or OS X, then specify the platform and
#  the deployment target. You can optionally include the target after the platform.
##――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――---#

  s.platform     = :ios
  s.platform     = :ios, "6.0"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"


# ――― Source Location:
#  Specify the location from where the source should be retrieved. Supports git, hg, bzr, svn and HTTP.
#――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――----#

#  s.source       = { :git => "git@git.sys.cigna.com:ios/core.git", :tag => "1.1.4" } #TODO


# ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#
#  CocoaPods is smart about how it includes source code. For source files1.1.4
#  giving a folder will include any h, m, mm, c & cpp files. For header
#  files it will include any header in the folder.
#  Not including the public_header_files will make all headers public.
#――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――----#
	s.prefix_header_file = "ABCustomControl/ABCustomControl-Prefix.pch"
	s.source_files = "ABCustomControl/**/*.{h,m}"
  # s.source_files  = "Classes", "Classes/**/*.{h,m}"
  # s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"


# ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#
#  A list of resources included with the Pod. These are copied into the target bundle with a build phase script.
#  Anything else will be cleaned. You can preserve files from being cleaned, please don't preserve non-essential files
#  like tests, examples and documentation.
#――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――----#
  s.ios.resource_bundle = { 'ABResourceBundle' => "ABCustomControl/**/*.{xib,png}" }
  s.resource  = "icon.png"
  s.resources = "Resources/*.png"
  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


# ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#  Link your library with frameworks, or libraries. Libraries do not include the lib prefix of their name.
#――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――----#

  # s.framework  = "SomeFramework"
	s.frameworks = "CoreGraphics", "UIKit", "Foundation", "CoreFoundation", "CFNetwork"
  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
  # s.dependency "CocoaLumberjack", "~> 1.8"

end
