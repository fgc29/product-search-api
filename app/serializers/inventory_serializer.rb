class InventorySerializer < ActiveModel::Serializer
  type :inventory

  attributes :id, :waist, :length, :style, :count
end