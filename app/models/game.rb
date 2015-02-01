class Game < ActiveRecord::Base
  require 'open-uri'
  has_many :results

end
