require 'rails_helper'

RSpec.describe 'opinions/index', type: :view do
  before(:each) do
    assign(:opinions, [
             Opinion.create!(
               user: nil,
               text: 'MyText'
             ),
             Opinion.create!(
               user: nil,
               text: 'MyText'
             )
           ])
  end

  it 'renders a list of opinions' do
    render
    assert_select 'tr>td', text: nil.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
  end
end
