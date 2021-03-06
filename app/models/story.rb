class Story < ActiveRecord::Base
  # Validations
  validates :title, length: { maximum: 100 }
  validates :description, length: { maximum: 2000 }
  # ----

  # Relations
  belongs_to :user
  # ----

  def title=(title)
    write_attribute :title, Sanitize.fragment(title)
  end

  def description=(description)
    write_attribute :description, Sanitize.fragment(description)
  end

  def body=(body)
    write_attribute :body, Sanitize.fragment(body, Sanitize::Config::BASIC)
  end
end
