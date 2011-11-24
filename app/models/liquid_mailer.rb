class LiquidMailer
  include Mongoid::Document
  include Mongoid::Timestamps
  field :subject
  #advances
  field :template
  references_many :content_types
  
  ## associations ##
  referenced_in :site
  
  validates_presence_of :site, :subject
end