require 'rails_helper'

RSpec.describe 'opinions/show', type: :view do
  before(:each) do
    @opinion = assign(:opinion, Opinion.create!(
                                  user: nil,
                                  text: 'MyText'
                                ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
  end
end
