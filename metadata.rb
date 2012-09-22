maintainer       "Jacques Marneweck"
maintainer_email "jacques@powertrip.co.za"
license          "All rights reserved"
description      "Checks out pk from github and the Joyent pkgsrc bits"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.3"

%w{
  opensolaris
  smartos
}.each do |os|
  supports os
end
