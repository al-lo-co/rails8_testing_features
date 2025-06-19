class ProductWelcomeJob < ApplicationJob
  queue_as :default

  def perform(product)
    puts "Welcome, #{product.name}"
  end
end
