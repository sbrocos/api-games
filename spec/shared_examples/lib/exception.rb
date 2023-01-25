# frozen_string_literal: true

shared_examples_for 'StandardError' do
  it { is_expected.to be_a(StandardError) }
end

shared_examples_for 'error response' do |status_code|
  before { get :index, params: {} }

  it "renders error response with status #{status_code}" do
    error = JSON[error_response]['errors'].first
    expect(response).to have_status_and_error(status_code, error)
  end
end
