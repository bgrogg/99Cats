class Cat < ActiveRecord::Base
  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :color, inclusion: ["brown", "pink", "blue"]
  validates :sex, inclusion: ["F", "M"]

  has_many :requests
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: :CatRentalRequest, dependent: :destroy

  def age
    ((Date.today - birth_date)/365).to_i
  end

end
