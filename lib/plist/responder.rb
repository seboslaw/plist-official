module Plist
  module PlistResponder
    def to_format
      Plist::Emit.dump(resource)
    end
  end
end
