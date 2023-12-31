require 'rails_helper'

RSpec.describe 'Expenses', type: :request do
  include Devise::Test::IntegrationHelpers # Include Devise test helpers
  before(:each) do
    @user = User.create(name: 'Rita Daniel ', email: 'rita@gmail.com', password: '123456',
                        password_confirmation: '123456', confirmation_token: nil, confirmed_at: Time.now)
    @group = Group.create(name: 'Food', icon: 'icons/food.jpg', user_id: @user.id)
    @expense = Expense.create(name: 'Food expense', amount: 10.00, author_id: @user.id)
    @expense_group = ExpensesGroup.create(expense_id: @expense.id, group_id: @group.id)
    sign_in @user
  end

  describe 'GET /expenses/new' do
    it 'returns http success' do
      get new_user_group_expense_path(user_id: @user.id, group_id: @group.id)
      expect(response).to have_http_status(200)
    end
    it 'renders the new template' do
      get new_user_group_expense_path(user_id: @user.id, group_id: @group.id)
      expect(response).to render_template('new')
    end
    it 'displays the new expense form' do
      get new_user_group_expense_path(user_id: @user.id, group_id: @group.id)
      expect(response.body).to include('Add Transaction')
    end
  end
end
