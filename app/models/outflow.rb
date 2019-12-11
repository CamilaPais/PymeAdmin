class Outflow < ApplicationRecord
	alias_attribute :items, :outflow_items
	belongs_to :supplier
	has_many :outflow_items, dependent: :destroy
	validates :amount, :supplier_id, presence: true
	validates :amount, numericality: { greater_than: 0 }
	accepts_nested_attributes_for :outflow_items, allow_destroy: true

	def update_stocks
		self.items.each do |item|
			item.product.update_stock(item.quantity)
		end
	end
end
