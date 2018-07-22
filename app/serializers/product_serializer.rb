class ProductSerializer < ActiveModel::Serializer
  type :product

  attributes :name, :image, :description, :total_inventory

  has_many :inventories

  private

  def total_inventory
    product.total_inventory
  end
end