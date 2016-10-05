

class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED)}
  validate :overlapping_approved_requests

  belongs_to :cat

  def approve!
    CatRentalRequest.transaction do
      self.status = "APPROVED"
      self.save
      overlapping_requests('PENDING').each {|request| request.deny! }
    end
  end

  def pending?
    self.status == 'PENDING'
  end

  def deny!
    self.status = "DENIED"
    self.save
  end

  private
  def overlapping_requests(status = 'APPROVED')
    start_date_overlapping_requests(status) + end_date_overlapping_requests(status)
  end

  def start_date_overlapping_requests(status = 'APPROVED')
    self.cat.cat_rental_requests
    .where(status: status)
    .where("? BETWEEN start_date AND end_date", self.start_date)
    .where.not(id: self.id)
  end

  def end_date_overlapping_requests(status = 'APPROVED')
    self.cat.cat_rental_requests
    .where(status: status)
    .where("? BETWEEN start_date AND end_date", self.end_date)
    .where.not(id: self.id)
  end

  def overlapping_approved_requests
    unless self.status == 'DENIED' || overlapping_requests.empty?
      self.errors[:overlapping] << "requests cannot be completed"
    end
  end
end
