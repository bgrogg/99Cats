class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: ["PENDING", "APPROVED", "DENIED"]
  validate :does_not_overlap_approved_request

  private

  def overlapping_requests
    CatRentalRequest
      .where.not(id: self.id)
      .where(cat_id: cat_id)
      .where(<<-SQL, start_date: start_date, end_date: end_date)
         NOT( (start_date > :end_date) OR (end_date < :start_date) )
      SQL
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: "APPROVED")
  end

  def does_not_overlap_approved_request
    unless overlapping_approved_requests.empty?
      errors[:overlapping_approved_requests] << "You already have a request approved that overlaps!"
    end
  end
end
