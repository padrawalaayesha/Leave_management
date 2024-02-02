class SinglePagePdf < ApplicationRecord
  belongs_to :script
  has_one_attached :file
end
