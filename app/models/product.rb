class Product < ApplicationRecord
  has_many :inventories

  def total_inventory
    inventories.pluck(:count).reduce(:+)
  end

  def self.search(params)
    return if name.blank?
    products = where('name like ?', "%#{params}%").includes(:inventories)
    return products.first if products.size == 1

    fuzzy_match(params)
  end

  private

  def self.levenshtein_distance(product_name, search_param)
    product_name, search_param = product_name.downcase, search_param.downcase
    costs = Array(0..search_param.length)

    (1..product_name.length).each do |i|
      costs[0], nw = i, i - 1
      (1..search_param.length).each do |j|
        costs[j], nw = [costs[j] + 1, costs[j - 1] + 1, product_name[i - 1] == search_param[j - 1] ? nw : nw + 1].min, costs[j]
      end
    end
    costs[search_param.length]
  end

  def self.fuzzy_match(params)
    # a match is found when the match_percentage is .20 < match >= 1.00
    products        = Product.all.includes(:inventories)
    params_length   = params.length.round(2)
    closest_match   = 0
    matched_product = nil


    products.each do |product|
      product_name          = product.name
      distance              = levenshtein_distance(product_name, params)
      longest_string_length = [product_name.size.round(2), params_length].max
      numerator             = longest_string_length - distance

      next if numerator.zero? || distance.zero?

      match_percentage = numerator/longest_string_length

      if match_percentage > 0.20 && closest_match < match_percentage
        closest_match   = match_percentage
        matched_product = product
      end
    end

    matched_product
  end
end