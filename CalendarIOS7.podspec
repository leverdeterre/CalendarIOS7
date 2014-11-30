Pod::Spec.new do |s|

  s.name         = "CalendarIOS7"
  s.version      = "0.0.6"
  s.summary      = "Calendar component for iOS apps."
  s.requires_arc = true

  s.description  = <<-DESC
                   UICollectionViewController and Layout for a perfect iOS Calendar.
                   DESC

  s.homepage     = "https://github.com/leverdeterre/CalendarIOS7"
  s.license      = 'MIT'
  s.author             = { "jerome Morissard" => "morissardj@gmail.com" }
  s.platform     = :ios, '7.0'
  s.source = {
        :git => 'https://github.com/leverdeterre/CalendarIOS7.git',
        :tag => '0.0.6'
 }
  s.source_files  = 'Classes', 'CalendarIOS7/CalendarIOS7/CalendarIOS7/*.{h,m}'
  s.public_header_files = 'CalendarIOS7/CalendarIOS7/CalendarIOS7/*.h'
  s.resources = "CalendarIOS7/CalendarIOS7/CalendarIOS7/*.xib"

end
