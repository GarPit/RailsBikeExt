class LiquidMailer
  include Mongoid::Document
  include Mongoid::Timestamps
  field :subject
  #advances
  field :template
  has_and_belongs_to_many :content_types
  
  ## associations ##
  referenced_in :site
  
  validates_presence_of :site, :subject
  
  
  def presentation
    content_types.map(&:name).join(" | ") || "Blank"
  end
end

Site.class_eval do
  references_many :liquid_mailers
end

ContentType.class_eval do
  has_and_belongs_to_many :liquid_mailers
end