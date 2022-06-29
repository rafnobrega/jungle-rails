class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV["ADMIN_NAME"],
                               password: ENV["ADMIN_PASSWORD"]
  def show
    @product_counter = Product.count
    @category_counter = Category.count
  end
end
