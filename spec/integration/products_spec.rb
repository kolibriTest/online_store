# spec/requests/products_spec.rb

require 'swagger_helper'

RSpec.describe 'Products API', type: :request do
  path '/products/{id}' do
    # PUT /products/{id}
    put 'Updates a product' do
      tags 'Products'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :product, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          price: { type: :number },
          description: { type: :string }
        },
        required: [ 'name', 'price' ]
      }

      response '200', 'product updated' do
        let(:id) { Product.create(name: 'Old Product', price: 50, description: 'An old product').id }
        let(:product) { { name: 'Updated Product', price: 150, description: 'An updated product' } }
        run_test!
      end

      response '404', 'product not found' do
        let(:id) { 'nonexistent-id' }
        let(:product) { { name: 'Updated Product', price: 150, description: 'An updated product' } }
        run_test!
      end
    end
  end
end
