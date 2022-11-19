class ProductVoucher < ApplicationRecord
  belongs_to :product
  belongs_to :voucher
end
