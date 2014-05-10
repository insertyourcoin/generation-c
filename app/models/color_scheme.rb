class ColorScheme < ActiveRecord::Base
  def get_url
    self.scheme.downcase
  end
end
