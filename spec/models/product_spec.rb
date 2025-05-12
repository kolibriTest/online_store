# spec/requests/products_spec.rb

require 'swagger_helper'

RSpec.describe 'Products API', type: :request do
  path '/products' do
    # POST /products
    post 'Creates a product' do
      tags 'Products'
      consumes 'application/json'
      parameter name: :product, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          price: { type: :number },
          description: { type: :string }
        },
        required: [ 'name', 'price' ]
      }

      response '201', 'product created' do
        let(:product) { { name: 'Test Product', price: 100, description: 'A test product' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:product) { { name: '', price: -100 } }
        run_test!
      end
    end
  end
end
