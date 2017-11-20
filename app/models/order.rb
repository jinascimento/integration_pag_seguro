class Order < ActiveRecord::Base
  belongs_to :ad
  belongs_to :buyer, class_name: 'member'

  # Statuses
  enum status: [:requested, :waiting, :analysing, :paid, :avaliable, :dispute, :returned, :canceled, :debited,
  :temporary_retention]

end