require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

    let(:valid_product_attributes) {
        { :name => "Google Pixel 6", :description => "This is a test description.", :price => 1250, :category => "Phone" }
    }

    let(:invalid_product_attributes) { { } }

    describe "Products /index" do
        it "renders the index template" do
            get :index
            expect(response).to render_template("index")
        end

        it "assigns all products to @products" do
            get :index
            expect(assigns(:products)).to eq(Product.all)
        end
    end

    describe "Products /search" do
        it "should return searched product" do
            # get :search, params: { product: 'Samsung' }
            # expect(assigns(:products)).to eq()
        end
    end

    describe "Products /create" do
        context 'with valid parameters' do
            it 'creates a new product' do
                expect {
                    get :create, params: { product: valid_product_attributes }
                }.to change(Product, :count).by(1)
            end
      
            it 'redirects to the created product' do
                products_url(product: valid_product_attributes)
                expect(response).to be_successful
            end
          end
      
          context 'with invalid parameters' do
            it 'does not create a new product' do
                #
            end
          end
    end
end